load trainImages.mat;
load valImages.mat;
numClasses = numel(categories(trainImages.Labels));

layers = [
     imageInputLayer([112 112 3], 'Name', 'input')
     convolution2dLayer(11, 96,'Padding',1,'Stride',4, 'Name', 'conv_1')
     reluLayer('Name', 'relu_1')
     crossChannelNormalizationLayer(5,'alpha',0.0001,'beta',0.75,'name','norm_1')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_1')
     convolution2dLayer(5, 256,'Padding',1,'Stride',1, 'Name', 'conv_2')
     reluLayer('Name', 'relu_2')
     crossChannelNormalizationLayer(5,'alpha',0.0001,'beta',0.75,'name','norm_2')
     maxPooling2dLayer(3,'Padding',1,'Stride',1,'name','maxpool_2')
     convolution2dLayer(3, 384,'Padding',1,'Stride',1, 'Name', 'conv_3')
     reluLayer('Name', 'relu_3')
     convolution2dLayer(3, 384,'Padding',1,'Stride',1, 'Name', 'conv_4')
     reluLayer('Name', 'relu_4')
     convolution2dLayer(3, 256,'Padding',1,'Stride',1, 'Name', 'conv_5')
     reluLayer('Name', 'relu_5')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_5')
     fullyConnectedLayer(4096,'Name','fc_6')
     reluLayer('Name', 'relu_6')
     fullyConnectedLayer(4096,'Name','fc_7')
     reluLayer('Name', 'relu_7')     
     fullyConnectedLayer(numClasses,'Name','fc_8')
     softmaxLayer('Name','softmax')];    
     lgraph = layerGraph(layers);
classoutput = classificationLayer('Name','classoutput');
lgraph = addLayers(lgraph,classoutput);
lgraph = connectLayers(lgraph,'softmax','classoutput');

options = trainingOptions('sgdm',...
    'LearnRateSchedule', 'piecewise', ...
           'LearnRateDropFactor', 0.1, ...
           'LearnRateDropPeriod',10, ...
           'InitialLearnRate',0.005,...
           'MaxEpochs', 30, ...
           'MiniBatchSize', 160,...
           'ValidationData',valImages,...
           'ValidationPatience',5,...
           'ValidationFrequency',50);
net = trainNetwork(trainImages,lgraph,options);
%Classify the validation images using the fine-tuned network, and calculate the classification accuracy.
predictedLabels = classify(net,valImages);
accuracy = mean(predictedLabels == valImages.Labels)