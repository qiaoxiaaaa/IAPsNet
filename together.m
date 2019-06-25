clear;clc
files = dir('C:\Users\dell\Documents\MATLAB\JL_WZJL\*.tif');
jj = cell(248,380);%if image size is 42560X27776,(42560/112)X(27776/112)=380X248,cell(i=248,j=380)
for i=1:248
 for j=1:380
    jj{i,j} = imread(strcat(files(j+(i-1)*380).folder,'\',files(j+(i-1)*380).name));% the number in code is max of j
 end
end
jj=cell2mat(jj);
imwrite(jj,[files(1).folder,'\',strcat('JL_WZJL_O','.tif')]);