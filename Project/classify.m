function [p] = classify(Model, X)
    w = Model.weight;
    P_test = [];
    cellSize = 4;
    for i = 1:size(X,1)
        im = im2single(reshape(X(i,:), 32, 32, 3));
        hog = vl_hog(im, cellSize);
        P_test = [P_test;hog(:)'];
    end
    Test_norm = double([ones(size(X,1),1), P_test]);
    for c = 0:1:9
        z = Test_norm*w(:,c+1);
        p0(:,c+1) = 1./(1 + exp(-z));    
    end
    [maxp,tc] = max(p0,[],2);
    p = tc-1;
end