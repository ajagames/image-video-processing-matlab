function [result] = local_dynamic_threshold_segmentation(f)
%This function divides the original image into several sub-images,
%and select the corresponding segmentation threshold to complete the segmentation of the image. 
%The function normalizes the non-uniform brightness intensity of the original image.

original_image = imread(f);   %read the image
gray_image = rgb2gray(original_image);
gray_image=double(gray_image);
[m,n]=size(gray_image);
result=zeros(m,n);
block_size=input('Block size=');    %enter block size(ex. 15)
for i=1:block_size:m
    for j=1:block_size:n
        if((i+block_size)>m)&&((j+block_size)>n)   %block
            block=gray_image(i:end,j:end);
        elseif((i+block_size)>m)&&((j+block_size)<=n)
            block=gray_image(i:end,j:j+block_size-1);
        elseif((i+block_size)<=m)&&((j+block_size)>n)
            block=gray_image(i:i+block_size-1,j:end);            
        else
            block=gray_image(i:i+block_size-1,j:j+block_size-1); 
        end
            t=mean(block(:));
        t_org=t;
        is_done=false;
        count=0;
        while ~is_done
            r1=find(block<=t);
            r2=find(block>t);
            temp1=mean(block(r1));
            if isnan(temp1);
                temp1=0;
            end
            temp2=mean(block(r2));
            if isnan(temp2);
                temp2=0;
            end   
            t_new=(temp1+temp2)/2;
            is_done=abs(t_new-t)<1;
            t=t_new;
            count=count+1;
            if count>1000
                Error='Error:Cannot find the ideal threshold.';
                return
            end
        end
        block(r1)=255;
        block(r2)=0;
        if((i+block_size)>m)&&((j+block_size)>n)   %merge results
            result(i:end,j:end)=block;
        elseif((i+block_size)>m)&&((j+block_size)<=n)
            result(i:end,j:j+block_size-1)=block;
        elseif((i+block_size)<=m)&&((j+block_size)>n)
            result(i:i+block_size-1,j:end)=block;            
        else
            result(i:i+block_size-1,j:j+block_size-1)=block; 
        end
    end
end
result=uint8(result);
figure;
imshow(result);
