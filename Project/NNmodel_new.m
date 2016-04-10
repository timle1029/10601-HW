function [Y,Ah] = NNmodel_new(X,Wih,Who)
    samples = size(X,1);
    Zh = X*Wih;
    Zh = Zh./repmat(max(abs(Zh)),samples,1)*5;
    Ah = sigmoid(Zh);
    %Ah = [ones(size(Ah,1),1),Ah]; % add the bias
    Zo = Ah * Who;
    Zo = Zo./repmat(max(abs(Zo)),samples,1)*5;
    Y = sigmoid(Zo);
end