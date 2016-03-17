function [w] = logisticRegressionWeights(xTrain, yTrain, w0, nIter)
u=size(w0);
m=zeros(u,1);
m(1)=w0;
v=size(yTrain)
z=zeros(v,1);
for k=1:nIter;
    for i=1:v;
        z(i)=sigmoidProb(1,xTrain(i,:),m);
    end
    for i=1:v;
        for j=2:u;
            m(j)=m(j)+0.1*xTrain(i,j)*(yTrain(i)-z(i));
        end
    end
end
w=m;
end