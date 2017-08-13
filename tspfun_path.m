%
% ObjVal = tspfun(Phen, Dist)
% Implementation of the TSP fitness function
%	Phen contains the phenocode of the matrix coded in adjacency
%	representation
%	Dist is the matrix with precalculated distances between each pair of cities
%	ObjVal is a vector with the fitness values for each candidate tour (=each row of Phen)

function ObjVal = tspfun_path(Phen,Dist)

	ObjVal=zeros(size(Phen,1),1);                     %Preallocating the ObjectValue vector to be used as input in run_ga 
    Objtemp=zeros(size(Phen,1),size(Dist,2));       %Preallocating the Temporary Objectvalue vector to be used inside the loop 
    
	for t=1:size(Phen,1)
        for r=1:(size(Dist,2)-1)
            Objtemp(t,r)=Dist(Phen(t,r),Phen(t,r+1)); %Edge from city 1 to city 2 would choose Dist(1,2)
        end
            Objtemp(t,size(Dist,2))=Dist(Phen(t,1),Phen(t,size(Dist,2)));
    	ObjVal(t)=sum(Objtemp(t,:));                  %Appending individual edges of a particular tour to get the total fitness value.
	end

% End of function

