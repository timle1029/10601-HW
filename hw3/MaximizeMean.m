function [mu] = MaximizeMean(X, k, w)
[n,f]=size(X);
N=zeros(k,1);
munew=zeros(k,f);
for j = 1:k
    for i = 1:n
       N(j,:)=N(j,:)+w(i,j);
    end
end
for j = 1:k
    sum1=zeros(1,f);
    for i = 1:n
       sum1 = sum1 + X(i,:).*w(i,j);
    end
    munew(j,:)=sum1.*(1/N(j,:));
end
mu = munew;
end
