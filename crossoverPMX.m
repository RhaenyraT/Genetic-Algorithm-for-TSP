function offspring=crossoverPMX(parent);


if mod(size(parent,1),2)~=0
    parent=parent(1:(size(parent,1)-1),:);
end
w=1:2:size(parent,1);
    
offspring=zeros(size(parent,1),size(parent,2));

for g=1:length(w)
    
%Random number generator
p=randi([1,((size(parent,2))-floor(size(parent,2)/4))],1,1);
r=p+floor(size(parent,2)/4);     
   
%********************************************************************************************************************        
    % 1 . Equality
    for e=p:r
        offspring((w(g)+1),e)=parent(w(g),e);
        offspring(w(g),e) =parent(w(g)+1,e);
    end
    
    set_diff_o1= setdiff(parent(w(g),:),parent(w(g)+1,p:r));
 for zz=1:length(set_diff_o1)
     x1=set_diff_o1(zz);
     x_next1=x1;
     while true
         index=find(parent(w(g),:)==x_next1);
         value=offspring(w(g),index);
         if value==0
             offspring(w(g),index) = x1;
             break;
         end
         x_next1 = value;
     end
 end

    set_diff_o2= setdiff(parent(w(g)+1,:),parent(w(g),p:r));
 for zzz=1:length(set_diff_o2)
     x2=set_diff_o2(zzz);
     x_next2=x2;
     while true
         index=find(parent(w(g)+1,:)==x_next2);
         value=offspring(w(g)+1,index);
         if value==0
             offspring(w(g)+1,index) = x2;
             break;
         end
         x_next2 = value;
     end
 end
%********************************************************************************************************************   
%********************************************************************************************************************

   
end

                
     
