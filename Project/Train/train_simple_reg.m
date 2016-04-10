clc;clear
% k = 1000;
% train_data = zeros(k,3072);
% train_label = zeros(k,1)+500;
% w0 = zeros(497,1);
% right = 0;
% load(['subset_CIFAR10/small_data_batch_',num2str(1),'.mat']);
% train_data1 = [train_data;double(data)];
% train_label1 = [train_label;double(labels)];
% load(['subset_CIFAR10/small_data_batch_',num2str(2),'.mat']);
% test_data = data;
% test_label = labels;
% train_data(all(train_data == 0,2),:)=[];
% train_label(all((train_label - 500)==0,2),:)=[];
% test_data = double(test_data);
% test_label = double(test_label);
k = 5000;
w0 = zeros(1985,1);
right = 0;
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
ini4 = ones(k,1);
for c = 0:1:9
    
    for m = 1:1:k
        if train_label(m) == c
            new_label(m,1) = 1;
        else
            new_label(m,1) = 0;
        end
    end
    fprintf('the class: %f\n',c);

%% Extract HoG features
cellSize = 4;

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
%% not needed
%     for i = 1:k
%         x = train_data(i,:);
%         im = reshape(x,32,32,3);
%         P_train(i,:) = extract_feature(im);
%     end
%     for i = 1:1000
%         x = test_data(i,:);
%         im = reshape(x,32,32,3);
%         P_test(i,:) = extract_feature(im);
%     end
%     [Train_norm, average_train, sigma_train] = featureNormalize(P_train);
%     [Test_norm, average_test, sigma_test] = featureNormalize(P_test);
    Train_norm = double([ini4, P_train]);
    Test_norm = double([ini1, P_test]);
 % train the model: optimizing problem using the made-in function:
 % fminunc
%     options = optimset('GradObj', 'on', 'MaxIter', 20);
    lambda = 0.5;
%  Run fminunc to obtain the optimal weights
%     [w, cost] = fminunc(@(t)(CostFuncReg(Train_norm, new_label,t,lambda)), w0, options);
    [cost,gradient] = CostFuncReg(Train_norm, new_label,w0,lambda);
    for i = 1:170
        w = w0 + gradient*0.1;
        [cost1,gradient1] = CostFuncReg(Train_norm, new_label,w,lambda);
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
    W(:,c+1) = w;
% make a prediction probability of the testing data
p(:,c+1) = prediction(w, Test_norm);
fprintf('the prediction has finished\n');
end
%% choose the maximimum of the probability
[maxp,tc] = max(p,[],2);
tc = tc -1;
% computing the error rate
for j= 1:1:1000
    if tc(j) == test_label(j)
        right = right + 1;
    end
end
% error_R(i,1) = 1- (right/k);