function [k] = ChooseK(X, restarts, maxK)
vbic=zeros(maxK,1);
vrestarts=zeros(restarts,1);
for p = 1:maxK;
    for q = 1:restarts;
        [idx,C]= kmeans(X,p);
        vrestarts(q,:)=BIC(X,C,idx,p);
    end
    vbic(p,:)=max(vrestarts);
end
[y,n]=max(vbic);
k=n;