function [ls] = logSum(x)
y=max(x);
z=size(x);
s=0;
for i=1:z;
    s=s+exp(x-y);
end
ls=y+log(s);
end
