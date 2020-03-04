function = wavelet_fusion_regional_variance(img)
%This function performes wavelet fusion of regional variance.
%   The original image is decomposed by discrete wavelet frame, and different
% rules of image fusion are used to fuse the low and high frequency images.

Clear all;
close all;
% read the original image
x=img;
figure;
imshow(x);
title('original image 1')
y=imread('B.jpg');
figure;
imshow(y);
title('original image 2')
a=x;
b=y;
a=double(a);
b=double(b);
% perform 2D wavelet transform
[aA,aH,aV,aD]=dwt2(a,'bior2.4');
[bA,bH,bV,bD]=dwt2(b,'bior2.4');
newA=zeros(size(aA));
newH=zeros(size(aH));
newV=zeros(size(aV));
newD=zeros(size(aD));
% take average of the low frequency coefficient
[m,n]=size(aA);
for i=1:m
for j=1:n
newA(i,j)=(aA(i,j)+bA(i,j))/2;
end;
end;
% with 3*3 sliding window foe variance
fun=inline('var(x(:))');
Var_aH=nlfilter(aH,[3 3],fun);
Var_aV=nlfilter(aV,[3 3],fun);
Var_aD=nlfilter(aD,[3 3],fun);
Var_bH=nlfilter(bH,[3 3],fun);
Var_bV=nlfilter(bV,[3 3],fun);
Var_bD=nlfilter(bD,[3 3],fun);
% select the corresponding coefficient of larger variance as the high frequency coefficient
for i=1:m
for j=1:n
if Var_aH(i,j)>=Var_bH(i,j);
newH(i,j)=aH(i,j);
else
newH(i,j)=bH(i,j);
end
end
end
for i=1:m
for j=1:n
if Var_aV(i,j)>=Var_bV(i,j);
newV(i,j)=aV(i,j);
else
newV(i,j)=bV(i,j);
end
end
end
for i=1:m
for j=1:n
if Var_aD(i,j)>=Var_bD(i,j);
newD(i,j)=aD(i,j);
else
newD(i,j)=bD(i,j);
end
end
end
% reconstruction of image
new=idwt2(newA,newH,newV,newD,'bior2.4');
new=uint8(new);
figure;
imshow(new);
title('take large regional variance ')



end

