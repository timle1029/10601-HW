function [w] = Expectation(X, k, t, mu, sigma)
[a,b]=size(X);
n=a;
f=b;
vw=zeros(n,k);
for i = 1:n
    sum1=0;
    for j = 1:k
       %vw(i,j)=normpdf(X(i,:),mu(j,:),sigma(:,:,j))*t(j,:);
       part1 = 1/((sqrt((2*pi)^f))*(sqrt(det(sigma(:,:,j)))));
       part2 = (-0.5)*((X(i,:)-mu(j,:))*(inv(sigma(:,:,j)))*(X(i,:)-mu(j,:))');
       vw(i,j) = part1*exp(part2).*t(j,:);
       sum1 = sum1 + vw(i,j);
    end
    vw(i,:)=vw(i,:)./sum1;
end
w = vw;
end