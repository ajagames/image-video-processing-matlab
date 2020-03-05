function = ratio_matching_stitching(img1,img2)
%The function performs image stitching based on ratio matching. 
%  It first selects the ratio of two columns of pixels with a certain distance 
% between the overlapped parts of the template image. Then it searchs the best 
% match for the overlapped region in the second image and finds two columns corresponding 
% to the template taken from the first image to complete the image stitching.

clear;
clc;
A=imread(img1);% read Picture 1 A represents the pixel array of Picture 1
B=imread(img2);% read Picture 2
[x1,y1]=size(A(:,:,1));
% transform into greyscale images calculate the length and height of Picture 1
[x2,y2]=size(B(:,:,1));
A1=double(A);
B1=double(B);
sub_A=A1(:,end-1)./A1(:,end);%calculate the ratio of last two columns in Picture 1
sub_D = zeros(size(B,2)-1,2);%define sub_D
for y=1:y2-1
sub_B=B1(:,y)./B1(:,y+1);% calculate the ratio of two adjacent columns in Picture 2
sub_C=(sub_A-sub_B)'*(sub_A-sub_B);
%calculate the difference between template a and b, calculate the sum of column vector
sub_D(y,1)=y;
sub_D(y,2) =sub_C;%sub_D is a two-dimensional array
end

[a b]= sort(sub_D(:,2));% ascending sort
row = b(1,:);% the coordinate of first element is the best match
x3=x1;
y3 = y1-1+y2-row;%length and height of image to be stitched
C=zeros(x3,y3);
for i=1:x3
for j=1:y3
if j<y1
C(i,j)=A(i,j);
else
C(i,j)=B(i,row+j-y1);
end
end
end% image stitching
imwrite(C,'picture3.bmp');
imshow(mat2gray(C));


end

