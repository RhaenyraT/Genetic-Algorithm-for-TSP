function run_ga_pathPMX(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, LOCALLOOP, ah1, ah2, ah3)
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT LOCALLOOP}


        GGAP = 1 - ELITIST;%The portion of the population that is replaced each generation. A generation gap of 0 means none of the population is replaced, conversely a generation gap of 1 means that the entire population is replaced each generation. 
        mean_fits=zeros(1,MAXGEN+1); %MAXGEN-Max number of generations
        worst=zeros(1,MAXGEN+1);
        Dist=zeros(NVAR,NVAR); %NVAR No of variables
        for i=1:size(x,1)
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        % initialize population
        Chrom=zeros(NIND,NVAR);
        for row=1:NIND
            Chrom(row,:)=randperm(NVAR);
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        ObjV = tspfun_path(Chrom,Dist);
        best=zeros(1,MAXGEN);
        % generational loop
        while gen<MAXGEN
            sObjV=sort(ObjV);
          	best(gen+1)=min(ObjV);
        	minimum=best(gen+1);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum)
                    break;
                end
            end
            
            visualizeTSP(x,y,(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
%adj2path(Chrom(t,:))
            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end   
            
        	%ASSIGN FITNESS VALUE
          	FitnV=ranking(ObjV);
            %non-linear ranking and selective pressure 2:
            %FitnV=ranking(ObjV,[2 1]); %linear ranking is assumed and the scalar indicates the selective pressure.
            
            %CHECKS IF FITNESS VALUES ARE UNIQUE
            FitnVcheck=unique(FitnV); 
            
            %PARENT SELECTION
         	%SelCh=FPSselection(Chrom, FitnV,GGAP); % ROULETTE SELECTION / FITNESS PROPORTIONAL SELECTION
            %SelCh=TournamentSelection(Chrom, FitnV,GGAP); %TOURNAMENT SELECTION
            SelCh=select('sus', Chrom, FitnV, GGAP); %DEFAULT PARENT
            [rowFPS columnFPS]=find(SelCh==0);
            
            %RECOMBINATION (crossover)
            SelCh = crossoverPMX(SelCh);
            [rowpmx columnpmx]=find(SelCh==0);
             
            %MUTATION (displacement type)
            SelCh=mutation_dispPMX(SelCh);
            [rowmut columnmut]=find(SelCh==0);

            %evaluate offspring, call objective function
        	ObjVSel = tspfun_path(SelCh,Dist);
            
            %reinsert offspring into population
        	[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            %Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        	%increment generation counter
        	gen=gen+1;            
        end
end
