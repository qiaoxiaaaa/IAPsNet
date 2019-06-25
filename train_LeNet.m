Images = imageDatastore('MerchData_T','IncludeSubfolders',true,'LabelSource','foldernames');
[trainImages,valImages] = splitEachLabel(Images,0.9,'randomized');
numClasses = numel(categories(trainImages.Labels));

layers = [
     imageInputLayer([112 112 3], 'Name', 'input')
     convolution2dLayer(7, 96,'Padding',1,'Stride',2, 'Name', 'conv_1')
     reluLayer('Name', 'relu_1')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_1')
     convolution2dLayer(5, 256,'Padding',1,'Stride',2, 'Name', 'conv_2')
     reluLayer('Name', 'relu_2')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_2')
     convolution2dLayer(3, 384,'Padding',1,'Stride',1, 'Name', 'conv_3')
     reluLayer('Name', 'relu_3')
     fullyConnectedLayer(2048,'Name','fc_6')
     reluLayer('Name', 'relu_6') 
     fullyConnectedLayer(numClasses,'Name','fc_8','WeightLearnRateFactor',20,'BiasLearnRateFactor', 20)
     softmaxLayer('Name','softmax')];    
     lgraph = layerGraph(layers);
classoutput = classificationLayer('Name','classoutput');
lgraph = addLayers(lgraph,classoutput);
lgraph = connectLayers(lgraph,'softmax','classoutput');

options = trainingOptions('sgdm',...
    'LearnRateSchedule', 'piecewise', ...
           'LearnRateDropFactor', 0.1, ...
           'LearnRateDropPeriod',10, ...
           'InitialLearnRate',0.001,...
           'MaxEpochs', 200, ...
           'MiniBatchSize', 160,...
           'ValidationData',valImages,...
           'ValidationPatience',5,...
           'ValidationFrequency',50,...
           'Plots', 'training-progress');

net = trainNetwork(trainImages,lgraph,options);
%Classify the validation images using the fine-tuned network, and calculate the classification accuracy.
predictedLabels = classify(net,valImages);
accuracy = mean(predictedLabels == valImages.Labels)