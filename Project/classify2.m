function [y] = classify2(Model2,x)

w1 = Model2.w1;
w2 = Model2.w2;
cellSize = 4;
XTestFeat = [];
for i = 1:size(x,1)
    im = im2single(reshape(x(i,:), 32, 32, 3));
    hog = vl_hog(im, cellSize);
    XTestFeat = [XTestFeat;hog(:)'];
end
XTestFeat = [ones(1000,1),XTestFeat];
[Y,Ah] = NNmodel_new(XTestFeat,w1,w2);
[value,y] =max(Y,[],2);
y = y - 1;
end
