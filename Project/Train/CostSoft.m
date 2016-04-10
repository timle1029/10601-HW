function [loss,gradient] = CostSoft(X,Y,w,lambda)
    loss = 0;
    sample = size(Y,1);
    gradient = zeros(size(w));
    [a,b] = size(w);
    T = w.*w;
    sum0 = 0;
    for i = 2:a
        sum0 = sum0 + sum(T(i,:));
    end
    R = lambda/2*sum0;
    for i = 1:sample
        c = Y(i,1)+1;
        sum1 = sum(X(i,:)*w);
        loss = loss + log(X(i,:)*w(:,c)/sum1);
    end
    loss = -1*loss./sample + R;
    for j = 1:b
        for i = 1:sample
            sum1 = sum(X(i,:)*w);
            for k = 1:10
                if k == j;
                    gradient(:,j) = gradient(:,j) + (1-X(i,:)*w(:,k)/sum1).*X(i,:)';
                else
                    gradient(:,j) = gradient(:,j) - X(i,:)*w(:,k)/sum1.*X(i,:)';
                end
            end
        end
        t = [0;gradient(2:a,j)];
        gradient(:,j) = lambda*t-1./sample*gradient(:,j);
    end