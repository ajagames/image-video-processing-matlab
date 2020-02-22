function [Y] = region_growing(original)
% Combine the pixels with similar properties to form a region.
% Find a seed pixel as the starting point for each growth area, then combines the pixels in the neighborhood with properties similar as the seed. 
% A region grows if new pixels continue to meet the required conditions.
% image=imread(original);
image=imread(original);
I=rgb2gray(image);
figure, imshow(I), title('Original image');
I=double(I)/255;
[M,N]=size(I);   %Get the number of rows and columns of the image
[y,x]=getpts;   %Find region growing strating point
x1=round(x);   
y1=round(y);
seed=I(x1,y1);
Y=zeros(M,N);
Y(x1,y1)=1;
sum=seed;
suit=1;
count_=1;
threshold=0.05555;
while count_ >0
    s=0;
    count_=0;
    for i=1:M
        for j=1:N
            if Y(i,j)==1
                if (i-1)>0 & (i+1)<(M+1) & (j-1)>0 & (j+1)<(N+1)
                    for u=-1:1
                        for v=-1:1
                            if Y(i+u,j+v)==0 & abs(I(i+u,j+v)-seed)<=threshold
                                Y(i+u, j+v)=1; count_=count_+1;
                                s=s+I(i+u,j+v);
                            end
                        end
                    end
                end
            end
        end
    end
    suit=suit+count_;
    sum=sum+s;
    seed=sum/suit;
end

figure,imshow(Y), title("Segmented image")
                                

end

