clear,clc;
[filename,filepath] = uigetfile('*.*','Select the image');  
if isequal(filename,0)||isequal(filepath,0)
    return;
else
   filefullpath=[filepath,filename];
end
[pathstr,name,ext] = fileparts(filename);
Im=imread(filefullpath);
L = size(Im);
%block size
height=112;
width=112;
%overlap
x=0;
h_val=height*(1-x);
w_val=width*(1-x);
max_row = (L(1)-height)/h_val+1;
max_col = (L(2)-width)/w_val+1;

if max_row==fix(max_row)
else
    max_row=fix(max_row+1);
end
if max_col==fix(max_col)
else
    max_col=fix(max_col+1);
end
seg = cell(max_row,max_col);
for row = 1:max_row      
    for col = 1:max_col        
        if ((width+(col-1)*w_val)>L(2)&&((row-1)*h_val+height)<=L(1))
    seg(row,col)= {Im((row-1)*h_val+1:height+(row-1)*h_val,(col-1)*w_val+1:L(2),:)};
        elseif((height+(row-1)*h_val)>L(1)&&((col-1)*w_val+width)<=L(2))
    seg(row,col)= {Im((row-1)*h_val+1:L(1),(col-1)*w_val+1:width+(col-1)*w_val,:)}; 
        elseif((width+(col-1)*w_val)>L(2)&&((row-1)*h_val+height)>L(1))
    seg(row,col)={Im((row-1)*h_val+1:L(1),(col-1)*w_val+1:L(2),:)};       
        else
     seg(row,col)= {Im((row-1)*h_val+1:height+(row-1)*h_val,(col-1)*w_val+1:width+(col-1)*w_val,:)};  
        end
    end
end 
 hold on
system(['mkdir ',name]);
paths=[pwd,'\',name]; 

for i=1:max_row
    for j=1:max_col
n = j+max_col*(i-1);
n = sprintf('%06d',n);
imwrite(seg{i,j},[paths,'\',strcat(n,'.tif')]); 
    end
end
