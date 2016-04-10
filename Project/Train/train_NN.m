function [W1,W2] =  train_NN(X,Label,iter,hidden,step,m)
features = size(X,2);
output = size(Label,2);
epsilon = 0.95;   % the parameter to adjust the initial weight.
W1 = rand(features,hidden) *2*epsilon -epsilon; % input-hiddenlayer weight
W2 = rand(hidden+1,output)*2*epsilon -epsilon;     % hiddenlayer-output weight
DW1 = zeros(features,hidden);   
DW2 = zeros(hidden+1,output);

for i = 1:iter
    [Y,Ah] = NNmodel_bias(X,W1,W2);
    %backpropagation
    
    do = (Label - Y).*Y.*(1-Y);
    dh = do * W2(2:end,:)'.* Ah(:,2:end) .* (1-Ah(:,2:end));
    Dh = X' * dh;
    Do = Ah' * do;
    %update 
    temp2 = W2;
    temp1 = W1;
    W2 = W2 +step * Do +m*DW2;
    W1 = W1 +step * Dh +m*DW1;
    DW1 = W1 - temp1;
    DW2 = W2 - temp2;
    % computing the loss fucntion
    loss = sum(sum(Label - Y).^2);
end

    
    
    
