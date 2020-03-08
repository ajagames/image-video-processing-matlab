function = dwt_watermarking(img1,img2)
%This function implements digital watermarking based on discrete wavelet transform (DWT).
% DWT uses a multi-resolution decomposition method to decompose the image, and adds the watermark 
% in the corresponding sub-band coefficient image. The wavelet coefficients image consists 
% of several sub-bands coefficients images, and the wavelet coefficients of different sub-bands 
% reflect the characteristics of different spatial resolution of the image.

%img1 = lena.bmp;
%img2 = 'cameraman256.tif';
I= imread(img1);
M=imread(img2);
W=im2bw(M); % Convert grayscale image to binary image
[CA,CH,CV,CD]=dwt2(I,'db1');
[length,width]=size(CA);
C=CD;
[M,N]=size(C);
Q=C;
step=5;
% the part of Watermark embedding
for i=1:M
for j=1:N
Q(i,j)=mod(round(C(i,j)/step),2);
if Q(i,j)==W(i,j)
C1(i,j)=C(i,j);
else
if C(i,j)>=0
C1(i,j)=C(i,j)-step;
else
C1(i,j)=C(i,j)+step;
end
end
end
end
WaterCD=C1(1:length,1:width);
IW=double(idwt2(CA,CH,CV,WaterCD,'db1'));
% the part of watermark extraction
[CA,CH,CV,CD]=dwt2(IW,'db1');
W1=zeros(64,64);
for i=1:M
for j=1:N
Q1(i,j)=mod(round(CD(i,j)/step),2);
W1(i,j)=Q1(i,j);
end
end
subplot(3,4,1),imshow(I,[]),title(' The original image ');
subplot(3,4,2),imshow(IW,[]),title(' Image embeded in watermark ');
subplot(3,4,3),imshow(W,[]),title(' Embedded watermark ');
subplot(3,4,4),imshow(W1,[]),title(' The extracted watermark ');
[PSNR_OUT,Z] = psnr(I,IW);
str = sprintf('PSNR = %f',PSNR_OUT);
disp(str);


end

