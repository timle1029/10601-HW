function [t] = naiveBayesClassify(xTest, M, V, p)
m=M';
v=V';
[c,d]=size(M);
Q=zeros(5,1);
[a,b]=size(xTest);
R=zeros(a,1);
for i=1:a;
    for j=1:d; %class j
        q1=(1/sqrt(2*pi*v(j,1)))*exp(-((xTest(i,1)-m(j,1))^2)/(2*v(j,1)));
        q2=(1/sqrt(2*pi*v(j,2)))*exp(-((xTest(i,2)-m(j,2))^2)/(2*v(j,2)));
        q3=(1/sqrt(2*pi*v(j,3)))*exp(-((xTest(i,3)-m(j,3))^2)/(2*v(j,3)));
        q4=(1/sqrt(2*pi*v(j,4)))*exp(-((xTest(i,4)-m(j,4))^2)/(2*v(j,4)));
        q5=(1/sqrt(2*pi*v(j,5)))*exp(-((xTest(i,5)-m(j,5))^2)/(2*v(j,5)));
        Q(j) = log(q1)+log(q2)+log(q3)+log(q4)+log(q5)+log(p(j));
    end
    [y,n]=max(Q);
    t(i)=n;
end
t=t';

end
