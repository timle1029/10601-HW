function p = prediction(w, X)
%    p = (sigmoid(X*w) >= 0.5);
     p = sigmoid(X*w);
end
