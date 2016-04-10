%% Load the data, split it into train and test data
function [Y] = classify1(Model1,X)
    
    XTrain = [];
    YTrain = [];
    
    XTest = X;
    
    YTrain = Model1.YTrain;
    P_train = Model1.feature;
    
%     load dataset_small/small_data_batch_1.mat
%     XTrain = [XTrain;data];
%     YTrain = [YTrain;labels];
% 
%     load dataset_small/small_data_batch_2.mat
%     XTrain = [XTrain;data];
%     YTrain = [YTrain;labels];
% 
%     load dataset_small/small_data_batch_3.mat
%     XTrain = [XTrain;data];
%     YTrain = [YTrain;labels];
% 
%     load dataset_small/small_data_batch_4.mat
%     XTrain = [XTrain;data];
%     YTrain = [YTrain;labels];
% 
%     load dataset_small/small_data_batch_5.mat
%     XTrain = [XTrain;data];
%     YTrain = [YTrain;labels];
% 
%     dXTrain = double(XTrain);
%     dXTest = double(XTest);

    %% extract feature
    P_test = [];
%     P_train = [];
    cellSize = 4;
    for i = 1:size(XTest,1)
        im = im2single(reshape(XTest(i,:), 32, 32, 3));
        hog = vl_hog(im, cellSize);
        P_test = [P_test;hog(:)'];
    end
%     for i = 1:size(XTrain,1)
%         im = im2single(reshape(XTrain(i,:), 32, 32, 3));
%         hog = vl_hog(im, cellSize);
%         P_train = [P_train;hog(:)'];
%     end
    %[XTrainFeat, XTestFeat] = hoguse(XTrain, XTest);
    %load('hogdata.mat');
    %% computing the distance
    [sample,feature]=size(P_test);
%     D = DisEucid(P_train,P_test);
    [m,n] = size(P_test); % m should be samples, n should be features
    TrainM = size(P_train, 1);
    D=[];
    for i = 1:1:m    % for every samples, computing the distance
        sample = P_test(i,:);
        samplem = repmat(sample,TrainM,1);
        delta = samplem - P_train;
        dist = delta.*delta;
        temp = dist*ones(n,1);
        D(i,:) = temp';
%         for j = 1:1:TrainM
%             D(i,j) = 0;
%             for k = 1:1:n
%                 D(i,j) = (P_train(j,k)-P_test(i,k))^2+D(i,j);
%             end
%         end
    end
    D = sqrt(D);
    %load('distance.mat');
    %% using KNN
    k = 23;
    Ytrain = double(YTrain);
%     label = Knn(k,YTrain,D);
    [valueDis,ordered] = sort(D,2,'ascend');
    for j=1:size(ordered,1)
        for i=1:1:k
            C(j,i) = Ytrain(ordered(j,i),1);
        end
        U = unique(C(j,:));
        [m,n]=size(U);
        if n > 1
           count = hist(C(j,:),U);
           [value, location] = max(count);
            label(j,1) = U(1,location);
        else
            label(j,1) = U;
        end

    end
    Y = label;
end
