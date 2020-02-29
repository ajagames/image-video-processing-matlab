function [] = susan_corner_detection(img)
%Susan corner detection algorithms 
%   This function calculates the corner features in an image using  a
%   circular template.
clear all;
close all;
clc;
img=imread('lenna_RGB.tif');
img=rgb2gray(img);
imshow(img);
[m n]=size(img);
img=double(img);
t=45; % Set the threshold where the pixel grayscale of the template center is different from the surrounding gray level
usan=[]; % The difference between the current pixel and the surrounding pixel, which is less than t
% There are 37 pixels in the template
for i=4:m-3 % There is no extension of the image on the periphery, and the final image will shrink
for j=4:n-3
tmp=img(i-3:i+3,j-3:j+3); % Construct the template of 7*7 first, that is, 49 pixels
c=0;
for p=1:7
for q=1:7
if (p-4)^2+(q-4)^2<=12 % In the selection, the final template is similar to a circle
% usan(k)=usan(k)+exp(-(((img(i,j)-tmp(p,q))/t)^6));
if abs(img(i,j)-tmp(p,q))<t % Judge whether the grayscale is similar, and set t by yourself
c=c+1;
end
end

end
end
usan=[usan c];
end
end
g=2*max(usan)/3; % Confirm the number of corner extraction by yourself. When the value is relatively high, we will extract the edge.
for i=1:length(usan)
if usan(i)<g
usan(i)=g-usan(i);
else
usan(i)=0;
end
end
imgn=reshape(usan,[n-6,m-6])';
figure;
imshow(imgn)
% Non-maximum suppression
[m n]=size(imgn);
re=zeros(m,n);
for i=2:m-1
for j=2:n-1
if imgn(i,j)>max([max(imgn(i-1,j-1:j+1)) imgn(i,j-1) imgn(i,j+1) max(imgn(i+1,j-1:j+1))]);
re(i,j)=1;
else
re(i,j)=0;
end
end
end
figure;
imshow(re==1);