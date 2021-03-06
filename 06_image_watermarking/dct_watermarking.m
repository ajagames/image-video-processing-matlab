function = dct_watermarking(img_original,watermark)
%This function implements image watermarking based on Discrete Cosine Transform (DCT).
% The original image is divided into 8�8 blocks. The variances of all the sub-blocks is first calculated. 
% Then the front n blocks with the maximum variance with maximum variance. 
% The random sequence pn_sequence_zero is embedded in the medium frequency of the DCT domain according to the 
% system key K. Finally, the result image is generated by the inverse DCT transform of the sub-blocks. 
% K and pn_sequence_zero are used in combination to select the embedding position.

k=20; % set the watermark strength
blocksize=8; % set the block size of the image to be 8
midband=[0,0,0,1,1,1,1,0; % define the frequency coefficients of DCT
0,0,1,1,1,1,0,0;
0,1,1,1,1,0,0,0;
1,1,1,1,0,0,0,0;
1,1,1,0,0,0,0,0;
1,1,0,0,0,0,0,0;
1,0,0,0,0,0,0,0;
0,0,0,0,0,0,0,0];
message=double(imread(watermark));% read the watermark image and convert it to double-precision array
Mm=size(message,1); % calculate the height of image
Nm=size(message,2); % calculate the width of image
Qm=size(message,3); % the number of image channels
n=Mm*Nm;
%transform the watermarked image into one-dimensional row vector
message=round(reshape(message,1,n*Qm)./256);
%read the original host image and convert it into a double-precision array
cover_object=double(imread(img_original));
Mc=size(cover_object,1);Nc=size(cover_object,2);% calculate the height and width of original image
c=Mc/8; d=Nc/8; m=c*d; % compute blocks for image segmentation
% calculate the variance of each piece of host image
xx=1;

for j=1:c
for i=1:d
pjhd(xx)=1/64*sum(sum(cover_object((1+(j-1)*8):j*8,(1+(i-1)*8):i*8)));
fc(xx)=1/64*sum(sum((cover_object((1+(j-1)*8):j*8,(1+(i-1)*8):i*8)-pjhd(xx)).^2));
xx=xx+1;
end
end
A=sort(fc);B=A((c*d-n+1):c*d); % selete the top n of the variance
% embed the watermark information into the former n block with the largest variance
fc_o=ones(1,c*d);
for g=1:n
for h=1:c*d
if B(g)==fc(h)
fc_o(h)=message(g);
h=c*d;
end
end
end
message_vector=fc_o;
watermarked_image=cover_object;
% set the MATlAB random number generator state J as the system key K
rand('state',7);
% based on current random number generator state J,a pseudo-random sequence of 0,1 is generated
pn_sequence_zero=round(rand(1,sum(sum(midband))));
% embed the watermark
x=1;y=1;
for (kk = 1:m)
% block DCT transform
dct_block=dct2(cover_object(y:y+blocksize-1,x:x+blocksize-1));
ll=1;
if (message_vector(kk)==0)
for ii=1:blocksize
for jj=1:blocksize
if (midband(jj,ii)==1)
dct_block(jj,ii)=dct_block(jj,ii)+k*pn_sequence_zero(ll);
ll=ll+1;
end
end
end
end
watermarked_image(y:y+blocksize-1,x:x+blocksize-1)=idct2(dct_block);
if (x+blocksize) >= Nc
x=1; y=y+blocksize;
else
x=x+blocksize;
end
end
watermarked_image_int=uint8(watermarked_image);
% generate and output the image embeded with watermark
imwrite(watermarked_image_int,'dct2_watermarked.bmp','bmp');
% show the PSNR
xsz=255*255*Mc*Nc/sum(sum((cover_object-watermarked_image).^2));
psnr=10*log10(xsz)
% show the image after embedding the watermark
figure(1)
imshow(watermarked_image_int,[])
title('Watermarked Image')

end

