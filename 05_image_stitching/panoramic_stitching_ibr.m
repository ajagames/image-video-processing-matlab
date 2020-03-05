function = panoramic_stitching_ibr(img1, img2, img3, img4, img5, img6, img7, img8)
%This function do seamless stitching on image sequence taken from the same scene 
% with the same optical center and partial overlap but with different perspective and different focal lengths.
%The image registration algorithm is used to calculate the motion parameters 
% between each frame and then synthetize a large static wide-angle image.

tic
fprintf(' input images, tectonic image pyramid,...');
level=3;
T0=uint8([]);T=uint8([]);
%%%%%%%%%%%%%%%%%%%%%%
i1=imread(img1);T0(:,:,:,1)=i1;
i2=imread(img2);T0(:,:,:,2)=i2;
i3=imread(img3);T0(:,:,:,3)=i3;
i4=imread(img4);T0(:,:,:,4)=i4;
i5=imread(img5);T0(:,:,:,5)=i5;
i6=imread(img6);T0(:,:,:,6)=i6;
i7=imread(img7);T0(:,:,:,7)=i7;
i8=imread(img8);T0(:,:,:,8)=i8;

[h,w,d]=size(T0(:,:,:,1));%%%same image size is required
% [T,Terr]=multi_resolution(T0,level);
T=multi_resolution(T0,level);
toc
% %%%%%%%%%%%%%%%%%%%%% calculate offset through phase correlation
tic
fprintf(' calculate offset through phase correlation..');
M=8;%% number of images
% L=M*w;%% total length of images
for N=1:M
if N<M [i,j]=poc_2pow(T(:,:,:,N),T(:,:,:,N+1));
elseif N==M [i,j]=poc_2pow(T(:,:,:,N),T(:,:,:,1));
end
coor_shift(N,1)=i;
coor_shift(N,2)=j;
end
coor_shift=coor_shift*2^level;%%% convert the offsets in the pyramid hierarchy to the offset of the
original
toc
%%%%%%%%%%%%%%%%% Transform to cylindrical coordinate system
tic
fprintf(' Transform to cylindrical coordinate system..');
f=sqrt(h^2+w^2);
[T1,coor_shift02]=coortransf(T0,f,coor_shift);
toc
%%%%%%%%%%%%% merge overlapping parts
tic
fprintf(' merge overlapping parts, stitching image....');
panorama1=T1(:,:,:,1);
for N=1:M
if N<M
panorama1=mosaic(panorama1,T1(:,:,:,N+1),coor_shift02(N,1),coor_shift02(N,2));
end
end
toc
%%%%%%%%%%%%%%%% reconstruct image
tic
fprintf(' save and show result..');
toc
image1=rgb2gray(panorama1);
index=find(image1(:,1)>=255);
aa=max(index);
[r,c]=size(image1)
image1=imcrop(panorama1,[1,aa,c,r]);
imshow(image1);
imwrite(image1,'pic1.jpg','jpg');

end

