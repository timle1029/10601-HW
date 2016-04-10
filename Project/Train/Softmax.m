clc;clear
k = 4000;
w0 = 0.1.*rand(497,10);
right = 0;
%% load data
XTrain = [];
YTrain = [];

load small_data_batch_1
XTrain = [XTrain;data];
YTrain = [YTrain;labels];

load small_data_batch_2
XTrain = [XTrain;data];
YTrain = [YTrain;labels];

load small_data_batch_3
XTrain = [XTrain;data];
YTrain = [YTrain;labels];

load small_data_batch_4
XTrain = [XTrain;data];
YTrain = [YTrain;labels];

load small_data_batch_5
XTest = data;
YTest = labels;
train_data = double(XTrain);
test_data = double(XTest);
train_label = double(YTrain);
test_label = double(YTest);
ini1 = ones(1000,1);
ini4 = ones(4000,1);
%% extract feature
cellSize = 8;
XTrainFeat = [];
for i = 1:size(XTrain,1)
    im = im2single(reshape(XTrain(i,:), 32, 32, 3));
    hog = vl_hog(im, cellSize);
    XTrainFeat = [XTrainFeat;hog(:)'];
end
P_train = XTrainFeat;
XTestFeat = [];
for i = 1:size(XTest,1)
    im = im2single(reshape(XTest(i,:), 32, 32, 3));
    hog = vl_hog(im, cellSize);
    XTestFeat = [XTestFeat;hog(:)'];
end
P_test = XTestFeat;
%% format train data and test data
Train_norm = double([ini4, P_train]);
Test_norm = double([ini1, P_test]);
%% train model
lambda = 1;
[cost,gradient] = CostSoft(Train_norm,train_label,w0,lambda);
for i = 1:100
    w = w0 + gradient*0.1;
    [cost1,gradient1] = CostSoft(Train_norm, train_label,w,lambda);
        delta = cost - cost1;
        if cost1 < cost
            w0 = w;
            cost = cost1;
            gradient = gradient1;
            if abs(delta)<0.0001
                break;
            end
        else
            break;
        end
end
p = SoftPred(w,Test_norm);
for m = 1:1000
    if p(m) == test_label(m);
        right = right + 1;
    end
end
fprintf('the prediction has finished\n');