load trainImages.mat;
load valImages.mat;
numClasses = numel(categories(trainImages.Labels));
layers = [
     imageInputLayer([112 112 3], 'Name', 'input')
     convolution2dLayer(5, 64,'Padding',1,'Stride',1, 'Name', 'conv_1_1')
     reluLayer('Name', 'relu_1_1')
     convolution2dLayer(3, 128,'Padding',1,'Stride',2, 'Name', 'conv_1_2')
     reluLayer('Name', 'relu_1_2')
     crossChannelNormalizationLayer(5,'alpha',0.0001,'beta',0.75,'name','norm_1')
     maxPooling2dLayer(3,'Padding',1,'Stride',2,'name','maxpool_2')
     ];
     lgraph = layerGraph(layers);
%Inception1
incep_1_conv_1 = convolution2dLayer(1,64,'Name', 'incep_1_conv_1');
incep_1_relu_1 = reluLayer('Name', 'incep_1_relu_1');
incep_1_conv_2 = convolution2dLayer(1,96,'Name','incep_1_conv_2');
incep_1_relu_2 = reluLayer('Name', 'incep_1_relu_2');
incep_2_conv_2 = convolution2dLayer(3,128,'Padding',1,'Name', 'incep_2_conv_2');
incep_2_relu_2 = reluLayer('Name', 'incep_2_relu_2');
incep_1_conv_3 = convolution2dLayer(1,16,'Name','incep_1_conv_3');
incep_1_relu_3 = reluLayer('Name', 'incep_1_relu_3');
incep_2_conv_3 = convolution2dLayer(5,32,'Padding',2,'Name','incep_2_conv_3');
incep_2_relu_3 = reluLayer('Name', 'incep_2_relu_3');
incep_1_maxpool_4 = maxPooling2dLayer(3,'Stride',1,'Padding',1,'name','incep_1_maxpool_4');
incep_2_conv_4 = convolution2dLayer(1,32,'Name','incep_2_conv_4');
incep_2_relu_4 = reluLayer('Name', 'incep_2_relu_4');
depth_1 = depthConcatenationLayer(4,'Name','depth_1');
lgraph = addLayers(lgraph,incep_1_conv_1);
lgraph = addLayers(lgraph,incep_1_relu_1);
lgraph = addLayers(lgraph,incep_1_conv_2);
lgraph = addLayers(lgraph,incep_1_relu_2);
lgraph = addLayers(lgraph,incep_2_conv_2);
lgraph = addLayers(lgraph,incep_2_relu_2);
lgraph = addLayers(lgraph,incep_1_conv_3);
lgraph = addLayers(lgraph,incep_1_relu_3);
lgraph = addLayers(lgraph,incep_2_conv_3);
lgraph = addLayers(lgraph,incep_2_relu_3);
lgraph = addLayers(lgraph,incep_1_maxpool_4);
lgraph = addLayers(lgraph,incep_2_conv_4);
lgraph = addLayers(lgraph,incep_2_relu_4);
lgraph = addLayers(lgraph,depth_1);
lgraph = connectLayers(lgraph,'maxpool_2','incep_1_conv_1');
lgraph = connectLayers(lgraph,'maxpool_2','incep_1_conv_2');
lgraph = connectLayers(lgraph,'maxpool_2','incep_1_conv_3');
lgraph = connectLayers(lgraph,'maxpool_2','incep_1_maxpool_4');
lgraph = connectLayers(lgraph,'incep_1_conv_1','incep_1_relu_1');
lgraph = connectLayers(lgraph,'incep_1_relu_1','depth_1/in1');
lgraph = connectLayers(lgraph,'incep_1_conv_2','incep_1_relu_2');
lgraph = connectLayers(lgraph,'incep_1_relu_2','incep_2_conv_2');
lgraph = connectLayers(lgraph,'incep_2_conv_2','incep_2_relu_2');
lgraph = connectLayers(lgraph,'incep_2_relu_2','depth_1/in2');
lgraph = connectLayers(lgraph,'incep_1_conv_3','incep_1_relu_3');
lgraph = connectLayers(lgraph,'incep_1_relu_3','incep_2_conv_3');
lgraph = connectLayers(lgraph,'incep_2_conv_3','incep_2_relu_3');
lgraph = connectLayers(lgraph,'incep_2_relu_3','depth_1/in3');
lgraph = connectLayers(lgraph,'incep_1_maxpool_4','incep_2_conv_4');
lgraph = connectLayers(lgraph,'incep_2_conv_4','incep_2_relu_4');
lgraph = connectLayers(lgraph,'incep_2_relu_4','depth_1/in4');

%main
maxpool_3 = maxPooling2dLayer(3,'Stride',2,'name','maxpool_3');
lgraph = addLayers(lgraph,maxpool_3);
lgraph = connectLayers(lgraph,'depth_1','maxpool_3');

%Inception2
incep_3_conv_1 = convolution2dLayer(1,128,'Name', 'incep_3_conv_1');
incep_3_relu_1 = reluLayer('Name', 'incep_3_relu_1');
incep_3_conv_2 = convolution2dLayer(1,128,'Name','incep_3_conv_2');
incep_3_relu_2 = reluLayer('Name', 'incep_3_relu_2');
incep_4_conv_2 = convolution2dLayer(3,192,'Padding',1,'Name', 'incep_4_conv_2');
incep_4_relu_2 = reluLayer('Name', 'incep_4_relu_2');
incep_3_conv_3 = convolution2dLayer(1,32,'Name','incep_3_conv_3');
incep_3_relu_3 = reluLayer('Name', 'incep_3_relu_3');
incep_4_conv_3 = convolution2dLayer(5,96,'Padding',2,'Name','incep_4_conv_3');
incep_4_relu_3 = reluLayer('Name', 'incep_4_relu_3');
incep_3_maxpool_4 = maxPooling2dLayer(3,'Padding',1,'Stride',1,'name','incep_3_maxpool_4');
incep_4_conv_4 = convolution2dLayer(1,64,'Name','incep_4_conv_4');
incep_4_relu_4 = reluLayer('Name', 'incep_4_relu_4');
depth_2 = depthConcatenationLayer(4,'Name','depth_2');
lgraph = addLayers(lgraph,incep_3_conv_1);
lgraph = addLayers(lgraph,incep_3_relu_1);     
lgraph = addLayers(lgraph,incep_3_conv_2);
lgraph = addLayers(lgraph,incep_3_relu_2);
lgraph = addLayers(lgraph,incep_4_conv_2);
lgraph = addLayers(lgraph,incep_4_relu_2);
lgraph = addLayers(lgraph,incep_3_conv_3);
lgraph = addLayers(lgraph,incep_3_relu_3);
lgraph = addLayers(lgraph,incep_4_conv_3);
lgraph = addLayers(lgraph,incep_4_relu_3);
lgraph = addLayers(lgraph,incep_3_maxpool_4);
lgraph = addLayers(lgraph,incep_4_conv_4);
lgraph = addLayers(lgraph,incep_4_relu_4);
lgraph = addLayers(lgraph,depth_2);
lgraph = connectLayers(lgraph,'maxpool_3','incep_3_conv_1');
lgraph = connectLayers(lgraph,'maxpool_3','incep_3_conv_2');
lgraph = connectLayers(lgraph,'maxpool_3','incep_3_conv_3');
lgraph = connectLayers(lgraph,'maxpool_3','incep_3_maxpool_4');
lgraph = connectLayers(lgraph,'incep_3_conv_1','incep_3_relu_1');
lgraph = connectLayers(lgraph,'incep_3_relu_1','depth_2/in1');
lgraph = connectLayers(lgraph,'incep_3_conv_2','incep_3_relu_2');
lgraph = connectLayers(lgraph,'incep_3_relu_2','incep_4_conv_2');
lgraph = connectLayers(lgraph,'incep_4_conv_2','incep_4_relu_2');
lgraph = connectLayers(lgraph,'incep_4_relu_2','depth_2/in2');
lgraph = connectLayers(lgraph,'incep_3_conv_3','incep_3_relu_3');
lgraph = connectLayers(lgraph,'incep_3_relu_3','incep_4_conv_3');
lgraph = connectLayers(lgraph,'incep_4_conv_3','incep_4_relu_3');
lgraph = connectLayers(lgraph,'incep_4_relu_3','depth_2/in3');
lgraph = connectLayers(lgraph,'incep_3_maxpool_4','incep_4_conv_4');
lgraph = connectLayers(lgraph,'incep_4_conv_4','incep_4_relu_4');
lgraph = connectLayers(lgraph,'incep_4_relu_4','depth_2/in4');
%main
maxpool_4 = maxPooling2dLayer(5,'Stride',2,'name','maxpool_4');
fc = fullyConnectedLayer(numClasses,'Name','fc','WeightLearnRateFactor',20,'BiasLearnRateFactor', 20);
softmax = softmaxLayer('Name','softmax');
classoutput = classificationLayer('Name','classoutput');
lgraph = addLayers(lgraph,maxpool_4);
lgraph = addLayers(lgraph,fc);
lgraph = addLayers(lgraph,softmax);
lgraph = addLayers(lgraph,classoutput);
lgraph = connectLayers(lgraph,'depth_2','maxpool_4');
lgraph = connectLayers(lgraph,'maxpool_4','fc');
lgraph = connectLayers(lgraph,'fc','softmax');
lgraph = connectLayers(lgraph,'softmax','classoutput');

options = trainingOptions('sgdm',...
           'LearnRateSchedule', 'piecewise', ...
           'LearnRateDropFactor', 0.1, ...
           'LearnRateDropPeriod',15, ...
           'InitialLearnRate',0.005,...
           'MaxEpochs', 60, ...
           'MiniBatchSize', 160,...
           'ValidationData',valImages,...
           'ValidationPatience',5,...
           'ValidationFrequency',50);

net = trainNetwork(trainImages,lgraph,options);
%Classify the validation images using the fine-tuned network, and calculate the classification accuracy.
predictedLabels = classify(net,valImages);
accuracy = mean(predictedLabels == valImages.Labels)
