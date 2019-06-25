clear;clc;
load net_IAPsNet;
files = dir('C:\Program Files\MATLAB\R2017b\bin\JL_multi-species\*.tif');
len=length(files);
for i=1:len
    file = imread(strcat(files(i).folder,'\',files(i).name));
    file = imresize(file,[112,112]);
    Labels = classify(net,file);
    if Labels == 'Bidens alba'
      file(:,:,1) = file(:,:,1).*uint8(zeros(112,112));
      file(:,:,2) = file(:,:,2).*uint8(zeros(112,112))+255;
      file(:,:,3) = file(:,:,3).*uint8(zeros(112,112))+255;
      file = file(:,:,:);
imwrite(file,['C:\Users\dell\Documents\MATLAB\JL_WZJL\',files(i).name]);
else if Labels == 'Eichhornia crassipes'
file(:,:,1) = file(:,:,1).*uint8(zeros(112,112))+255;
      file(:,:,2) = file(:,:,2).*uint8(zeros(112,112));
      file(:,:,3) = file(:,:,3).*uint8(zeros(112,112))+255;
      file = file(:,:,:);
      imwrite(file,['C:\Users\dell\Documents\MATLAB\JL_WZJL\',files(i).name]);
    else if Labels == 'Mimosa sepiaria'
file(:,:,1) = file(:,:,1).*uint8(zeros(112,112));
      file(:,:,2) = file(:,:,2).*uint8(zeros(112,112));
      file(:,:,3) = file(:,:,3).*uint8(zeros(112,112))+255;
      file = file(:,:,:);    
imwrite(file,['C:\Users\dell\Documents\MATLAB\JL_WZJL\',files(i).name]);
    else if Labels == 'Ageratum conyzoides'
file(:,:,1) = file(:,:,1).*uint8(zeros(112,112))+255;
      file(:,:,2) = file(:,:,2).*uint8(zeros(112,112))+255;
      file(:,:,3) = file(:,:,3).*uint8(zeros(112,112));
      file = file(:,:,:);    
imwrite(file,['C:\Users\dell\Documents\MATLAB\JL_WZJL\',files(i).name]);
    else if Labels == 'Wedelia trilobata' 
file(:,:,1) = file(:,:,1).*uint8(zeros(112,112))+255;
      file(:,:,2) = file(:,:,2).*uint8(zeros(112,112))+150;
      file(:,:,3) = file(:,:,3).*uint8(zeros(112,112))+50;
     file = file(:,:,:);    
imwrite(file,['C:\Users\dell\Documents\MATLAB\JL_WZJL\',files(i).name]);
    else if Labels == 'Mikania micrantha'
file(:,:,1) = file(:,:,1).*uint8(zeros(112,112))+255;
      file(:,:,2) = file(:,:,2).*uint8(zeros(112,112));
      file(:,:,3) = file(:,:,3).*uint8(zeros(112,112));
      file = file(:,:,:);    
imwrite(file,['C:\Users\dell\Documents\MATLAB\JL_WZJL\',files(i).name]);
    else if Labels == 'Ipomoea cairica'
file(:,:,1) = file(:,:,1).*uint8(zeros(112,112))+100;
      file(:,:,2) = file(:,:,2).*uint8(zeros(112,112))+50;
      file(:,:,3) = file(:,:,3).*uint8(zeros(112,112))+255;
      file = file(:,:,:);    
imwrite(file,['C:\Users\dell\Documents\MATLAB\JL_WZJL\',files(i).name]);
    end
    end
    end
    end
    end
    end
    end
end
