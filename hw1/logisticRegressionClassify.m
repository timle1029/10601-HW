function [cls] = logisticRegressionClassify(xTest, w)
s=zeros(1,6);
o=zeros(109,1);
y=zeros(6;1);
for i=1:size(xTest);
    s=xTest(i,:);
    sum=0;
    for j=1:size(w);
        sum=sum+s(j)*w(j);
    end
    g=exp(sum);
    if g>1;
        o(i)=1;
    else
        o(i)=0;
    end
cls=o;
end
