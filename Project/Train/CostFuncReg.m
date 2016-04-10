function [Loss, gradient] = CostFuncReg(X, y, w, lambda)
Loss = 0;
samples = size(y,1);
gradient = zeros(size(w));
% K = (X*w)./max(X*w).*5;
K = 5*mapminmax(X*w);
h = sigmoid(K);
R = lambda/(2*samples)*sum(w(2:end).^2);
Loss = (-1/samples) * sum(y .* log(h) + (1-y).* log(1-h)) + R;

for i=1:1:samples
    gradient = gradient + (y(i) - h(i)) * X(i,:)';
end

t = [0;w(2:end)];

gradient = 1/samples * gradient + lambda/samples*t;
end
