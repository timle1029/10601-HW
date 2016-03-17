function [bic] = BIC(X, C, idx, k)
[e,f]=size(C);
[n,z]=size(idx);
sum1 = 0;
for i = 1:n
    for j = 1:f 
        sum1 = sum1 + ((X(i,j)-C(idx(i),j))^2);
    end
end
o2 = sum1/((n-k)*f);
sum2 = 0;
r = zeros(k,1);
for i = 1:n
    for j = 1:k
        if (idx(i) == j)
            r(j,:) = r(j,:)+1;
        end
    end
end
for i = 1:k
    sum2 = sum2 - 0.5*r(i,:)*log(2*pi) - 0.5*r(i,:)*f*log(o2) - 0.5*(r(i,:) - k) + r(i,:)*log(r(i,:)) - r(i,:)*log(n);
end
bic = sum2 - 0.5*k*(f+1)*log(n);
end
