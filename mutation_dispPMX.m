%Displacement Mutation 
function mutated_offspring = mutation_dispPMX(offspring)
mutated_offspring=zeros(size(offspring,1),size(offspring,2));
for ff=1:size(offspring,1)
    p    =  randi([1,size(offspring,2)-floor(size(offspring,2)/4)],1,1);
    r    =  p+randi([floor(size(offspring,2)/7),floor(size(offspring,2)/4)],1,1);
    temp1=offspring(ff,p:r);
    temp=[1:(p-1),(r+1):size(offspring,2)];
    temp2=offspring(ff,temp);
    rr=randi([1,length(temp2)],1,1);
    mutated_offspring(ff,:)=[temp2(1:rr),temp1,temp2(rr+1:end)];
end

