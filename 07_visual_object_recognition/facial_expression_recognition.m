function = facial_expression_recognition()
%This function implements Facial Expression Recognition Using Principal Component Analysis (PCA).
% Images used as the training set and test set are from in the YALE Face database. 10 images
% are selected for each kind of emotional expression. After the end of the training, the image of 
% the known category was tested, which realize the recognition of happiness, sadness, and surprise.
% Images with three kinds of emotions were selected as the training set, which are happiness, sadness, 
% surprise, and each kind takes 10 images. After reducing the dimension of the face by the PCA method, 
% the least nearest neighbor method is used to identify an unknown facial emotion image.

clear all
close all
clc
xunlian=[];% All training images
for i=1:10
a=imread(strcat('happiness\',num2str(i),'.bmp'));
subplot(121);
imshow(a);title('training data set');drawnow;
title('training data set');
b=a(1:100*100);%The b is the row vector of 1*N, where N is 10000
b=double(b);
xunlian=[xunlian;b];% The xunlian is a matrix of M*N, and each line of data in it is a picture, in which
M is
%10.
end;
for i=1:10
a=imread(strcat('sadness \',num2str(i),'.bmp'));
imshow(a);title('training data set');drawnow;
title('traning data set\');
b=a(1:100*100);% The b is the row vector of 1*N, where N is 10000
b=double(b);
xunlian=[xunlian;b];% The xunlian is a matrix of 20*10000, and each line of data in it is a picture.
end;
for i=1:10
a=imread(strcat(' surprise \',num2str(i),'.bmp'));
imshow(a);title('training data set');drawnow;
imshow([]);title(' The training is over !');
b=a(1:100*100);% The b is the row vector of 1*N, where N is 10000
b=double(b);
xunlian=[xunlian; b];% The xunlian is a matrix of 30*1000, and each line of data in it is a picture.
end;
xunlian=xunlian';% Each column is a picture, and the xunlian’dimension is 10000*30.
for i=1:1000
cy(i,1:30)=xunlian(10*i,:);
end
pmetrix=cy*cy';
[vet vetvalue t1]=pcacov(pmetrix);% Finding eigenvalues and eigenvectors by principal component
analysis, and
%find eigenvalue vetvalue and corresponding eigenvector vet from sorted covariance matrix which is in
ascending
%order
sum2=sum(vetvalue);
temp=0;
con=0;
m=0;
for i=1:1000
if(con<0.99)
temp=temp+vetvalue(i);
con=temp/sum2;
m=m+1;
else
break;
end
end
A=vet(:,1:m);
y=A'*cy;%m*10000*10000*30 Each kind of emotion is projected into the eigenface space
f=imread('s146.bmp');
ff=f;
f=f(1:100*100);%The f is the row vector of 1*N, where N is 10000
f=double(f);
f=f';
for i=1:1000
cs(i)=f(10*i);
end;
xl=cs';
sum1=zeros(18,1);
sum2=zeros(18,1);
sum3=zeros(18,1);
zbceshi=A'* xl; %18*1 Find the coordinates of it in the eigenface space.
%size(zbceshi)
for i=1:10
%size(y:i)
%size(sum1)
sum1=y(:,i)+sum1;
end
for i=11:20
sum2=y(:,i)+sum2;
end
for i=21:30
sum3=y(:,i)+sum3;
end
a=zeros(18,3);
a(:,1)=sum1./10;
a(:,2)=sum2./10;
a(:,3)=sum3./10;
for i=1:3
wucha(i)=norm(zbceshi-a(:,i));
end
[h,I]=min(wucha);% Using nearest neighbor method to do face recognition.
if I==1
subplot(122);
imshow(ff);
title('The emotion which is identified is happiness!');
elseif I==3
subplot(122);
imshow(ff);
title(' The emotion which is identified is suprise!');
else
subplot(122);
imshow(ff);
title(' The emotion which is identified is sadness!');
end
end

