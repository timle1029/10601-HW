function [p] = SoftPred(w,X)
    sample = size(X,1);
    for i = 1:sample
        Z(i,:) = X(i,:)*w;
    end
    [maxz,tc] = max(Z,[],2);
    tc = tc-1;
    p = tc;
end