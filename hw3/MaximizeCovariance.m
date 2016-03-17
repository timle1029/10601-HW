function [sigma] = MaximizeCovariance(X, k, w, mu)
[a,b]=size(X);
f=b;
n=a;
sigmanew=zeros(f,f,k);
N=zeros(k,1);
for j = 1:k
    for i = 1:n
       N(j,:)=N(j,:)+w(i,j);
    end
end
for j = 1:k
    sum1 = zeros(f,f,1);
    for i = 1:n
        sum1 = sum1 + (X(i,:)-mu(j,:))'*(X(i,:)-mu(j,:)).*w(i,j);
    end
    sigmanew(:,:,j)=sum1.*(1/N(j,:));
end
sigma = sigmanew;
end