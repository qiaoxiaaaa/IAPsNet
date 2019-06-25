tic
clear;clc
valImages = imageDatastore('MerchData_V','IncludeSubfolders',true,'LabelSource','foldernames');
load net_IAPsNet.mat; 
%load net_LeNet.mat;
%load net_AlexNet.mat;
%load net_VGG_11.mat; 
predictedLabels = classify(net,valImages);
accuracy = mean(predictedLabels == valImages.Labels);
toc