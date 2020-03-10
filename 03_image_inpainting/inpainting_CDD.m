function = inpainting_CDD(img)
%This function implement Curvature-Driven Diffusions (CDD) inpainting model.
%In the CDD model, the TV conductivity coefficient is modified
%so that the the curvature is as small as possible to obtain images more conform to human vision.

close all;
clc;
clear;
imgoriginal=img;
figure(1);
imshow(imgoriginal);
[width,height] = size(imgoriginal);
img= double(imgoriginal);
mask = zeros(width,height/3,3);
for j = 1:height/3
for i = 1:width
if ((imgoriginal(i,j,1) >220)&&(imgoriginal(i,j,2) >220)&&(imgoriginal(i,j,3) >220))
mask(i,j,1) = 255;
mask(i,j,2) = 255;
mask(i,j,3) = 255;
else
mask(i,j,1) = 0;
mask(i,j,2) = 0;
mask(i,j,3) = 0;
end
end
end
figure(2);
imshow(mask);
a=zeros(width,height);
I=cat(3,a,2*a,3*a);
J=cat(3,a,2*a,3*a);
n = 1;
itertimes=1000;
tic;
while n <= itertimes
for i = 2:width-1
for j = 2:height/3-1
if (mask(i,j+1,1) == 255)||(mask(i,j-1,1) == 255)||(mask(i+1,j,1) == 255)||(mask(i-1,j,1) ==
255)
for k=1:3
grid_w(k) = (img(i,j,k)-img(i-1,j,k))^2+(1.0/16)*(img(i-1,j+1,k)+img(i,j+1,k)-
img(i-1,j-1,k)-img(i,j-1,k))^2;
grid_e(k) = (img(i,j,k)-img(i+1,j,k))^2+(1.0/16)*(img(i,j+1,k)+img(i+1,j+1,k)-
img(i,j-1,k)-img(i+1,j-1,k))^2;
grid_s(k) = (img(i,j,k)-img(i,j-1,k))^2+(1.0/16)*(img(i+1,j,k)+img(i+1,j-1,k)-
img(i-1,j,k)-img(i-1,j-1,k))^2;
grid_n(k) = (img(i,j,k)-img(i,j+1,k))^2+(1.0/16)*(img(i+1,j,k)+img(i+1,j+1,k)-
img(i-1,j,k)-img(i-1,j+1,k))^2;
I(i,j,k)=0.5*(img(i+1,j,k)-img(i-1,j,k))/sqrt(0.25*(img(i+1,j,k)-img(i-
1,j,k))^2+0.25*(img(i,j+1,k)-img(i,j-1,k))^2+1);
J(i,j,k)=0.5*(img(i,j+1,k)-img(i,j-1,k))/sqrt(0.25*(img(i+1,j,k)-img(i-1,j,k))^2+0.25*(img(i,j+1,k)-
img(i,j-1,k))^2+1);
Kw(k)=sqrt((I(i,j,k)-I(i-1,j,k)+(I(i-1,j+1,k)+I(i,j+1,k)-I(i-1,j
1,k)-I(i,j-1,k))/2)^2+(J(i,j,k)-J(i-1,j,k)+(J(i-1,j+1,k)+J(i,j+1,k)-J(i-1,j-1,k)-J(i,j-1,k))/2)^2);
Ke(k)=sqrt((I(i+1,j,k)-I(i,j,k)+(I(i,j+1,k)+I(i+1,j+1,k)-I(i,j-1,k)-I(i+1,j-1,k))/2)^2+(J(i+1,j,k)-
J(i,j,k)+(J(i,j+1,k)+J(i+1,j+1,k)-J(i,j-1,k)-J(i+1,j-1,k))/2)^2);
Ks(k)=sqrt((I(i,j,k)-I(i,j-1,k)+(I(i+1,j,k)+I(i+1,j-1,k)-I(i-1,j,k)-I(i-1,j-1,k))/2)^2+(J(i,j,k)-J(i,j-
1,k)+(J(i+1,j,k)+J(i+1,j-1,k)-J(i-1,j,k)-J(i-1,j-1,k))/2)^2);
Kn(k)=sqrt((I(i,j+1,k)-I(i,j,k)+(I(i+1,j,k)+I(i+1,j+1,k)-I(i-1,j,k)-I(i-1,j+1,k))/2)^2+(J(i,j+1,k)-
J(i,j,k)+(I(i+1,j,k)+J(i+1,j+1,k)-J(i-1,j,k)-J(i-1,j+1,k))/2)^2);
w1(k) = Kw(k)/sqrt(1+grid_w(k))+1;
w2(k) = Ke(k)/sqrt(1+grid_e(k))+1;
w3(k) = Ks(k)/sqrt(1+grid_s(k))+1;
w4(k) = Kn(k)/sqrt(1+grid_n(k))+1;
img(i,j,k) =(w1(k)*img(i-1,j,k)+w2(k)*img(i+1,j,k)+w3(k)*img(i,j-1,k)
+w4(k)*img(i,j+1,k))/(w1(k)+w2(k)+w3(k)+w4(k));
end
end
end
end
n = n+1;
end
img = uint8(floor(img));
toc;
figure(3);
imshow(img,[]);
imwrite(img,'CDD_result.bmp');

end

