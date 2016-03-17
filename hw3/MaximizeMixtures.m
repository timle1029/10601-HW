function [t] = MaximizeMixtures(k, w)
[n,k]=size(w);
N=zeros(k,1);
tnew=zeros(k,1);
for j = 1:k
    for i = 1:n
       N(j,:)=N(j,:)+w(i,j);
    end
end
for j = 1:k
    tnew(j,:)=N(j,:)/n;
end
t = tnew;
end
