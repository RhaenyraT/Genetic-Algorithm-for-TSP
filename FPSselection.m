function SelectedParent = FPSselection(Parent,Fitness,GGAP)

Select=floor(GGAP*size(Parent,1));
SortParent=sortrows([Fitness,Parent],-1);
Newparent=SortParent((1:Select),2:end);

SelectedParent= zeros(size(Newparent,1),size(Newparent,2));
probability   = zeros(size(Newparent,1),1);

for f=1:size(Newparent,1)
    probability(f)=SortParent(f,1)/(sum(SortParent(:,1)));
end

for rr=1:size(Newparent,1)
      srandom=sum(probability)*rand(1,1);
      PartialSum=0;
            for ff=1:size(Newparent,1)
            PartialSum=probability(ff)+PartialSum;
            
                if PartialSum>=srandom
                    SelectedParent(rr,:)=Newparent(ff,:);
                    break
                end
                
            end
end