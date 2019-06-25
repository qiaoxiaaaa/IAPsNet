load trainImages.mat;
load valImages.mat;
numClasses = numel(categories(trainImages.Labels));
layers = [
     imageInputLayer([112 112 3], 'Name', 'input')

     convolution2dLayer(3, 64,'Padding',1,'Stride',1, 'Name', 'conv_2_1')
     reluLayer('Name', 'relu_2_1')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_2')

     convolution2dLayer(3, 128,'Padding',1,'Stride',1, 'Name', 'conv_3_1')
     reluLayer('Name', 'relu_3_1')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_3')

     convolution2dLayer(3, 256,'Padding',1,'Stride',1, 'Name', 'conv_4_1')
     reluLayer('Name', 'relu_4_1')
     convolution2dLayer(3, 256,'Padding',1,'Stride',1, 'Name', 'conv_4_2')
     reluLayer('Name', 'relu_4_2')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_4')

     convolution2dLayer(3, 512,'Padding',1,'Stride',1, 'Name', 'conv_5_1')
     reluLayer('Name', 'relu_5_1')
     convolution2dLayer(3, 512,'Padding',1,'Stride',1, 'Name', 'conv_5_2')
     reluLayer('Name', 'relu_5_2')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_5')

     convolution2dLayer(3, 512,'Padding',1,'Stride',1, 'Name', 'conv_6_1')
     reluLayer('Name', 'relu_6_1')
     convolution2dLayer(3, 512,'Padding',1,'Stride',1, 'Name', 'conv_6_2')
     reluLayer('Name', 'relu_6_2')
     maxPooling2dLayer(3,'Padding',1,'Stride',1,'name','maxpool_6')

     fullyConnectedLayer(4096,'Name','fc6')
     fullyConnectedLayer(4096,'Name','fc7')
     fullyConnectedLayer(numClasses,'Name','fc','WeightLearnRateFactor',20,'BiasLearnRateFactor', 20)
     softmaxLayer('Name','softmax')
     classificationLayer('Name','classoutput')];
lgraph = layerGraph(layers);
options = trainingOptions('sgdm',...
    'LearnRateSchedule', 'piecewise', ...
           'LearnRateDropFactor', 0.1, ...
           'LearnRateDropPeriod',10, ...
           'InitialLearnRate',0.005,...
           'MaxEpochs', 50, ...
           'MiniBatchSize', 160,...
           'ValidationData',valImages,...
           'ValidationPatience',5,...
           'ValidationFrequency',50);

net = trainNetwork(trainImages,lgraph,options);
%Classify the validation images using the fine-tuned network, and calculate the classification accuracy.
predictedLabels = classify(net,valImages);
accuracy = mean(predictedLabels == valImages.Labels)