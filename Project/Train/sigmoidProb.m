function [p] = sigmoidProb(y, x, w)
for i=1:size(w);
    s=0;
    s=s+w(i)*x(i);
end
p=(1-y)*1/(1+exp(s))+y*(exp(s)/(exp(s)+1));

end
