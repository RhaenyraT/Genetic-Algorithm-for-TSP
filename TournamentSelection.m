function SelectedParent = TournamentSelection(Parent,Fitness,GGAP)

Select=floor(GGAP*size(Parent,1));
SortParent=sortrows([Fitness,Parent],-1);
Newparent=SortParent((1:Select),2:end);

SelectedParent= zeros(size(Select,1),size(Parent,2));

Fineness=7; %CONTROLS TOURNAMENT SIZE, IF HIGHER TOURNAMENT SIZE IS SMALLER.

for ff=1:size(Newparent,1)
    
    PermFitnessValues      =  randperm(size(Newparent,1));
    SizeOfTournament       =  randi([1,floor(size(Newparent,1)/Fineness )],1,1);
    StartofSelection       =  randi([1,size(Newparent,1)-floor(size(Newparent,1)/Fineness)-1],1,1);    
    SelectedForTournament  =  PermFitnessValues(StartofSelection:(StartofSelection+SizeOfTournament));    
    SelectedFitnessValues  =  Fitness(SelectedForTournament);
    CheckFitnessRepeats    =  unique(SelectedFitnessValues);
    while length(SelectedFitnessValues)~=length(CheckFitnessRepeats)
        StartofSelection       =  randi([1,size(Newparent,1)-floor(size(Newparent,1)/3)-1],1,1);  
        SelectedForTournament  =  PermFitnessValues(StartofSelection:(StartofSelection+SizeOfTournament));    
        SelectedFitnessValues  =  Fitness(SelectedForTournament);
        CheckFitnessRepeats    =  unique(SelectedFitnessValues);
    end
    MaxFitnessValue        =  (SelectedFitnessValues==max(SelectedFitnessValues));
    MaxFitnessValuePosition=  SelectedForTournament*(MaxFitnessValue);
    SelectedParent(ff,:)   =  Newparent(MaxFitnessValuePosition,:);
        
end



 