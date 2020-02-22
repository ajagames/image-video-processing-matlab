function [g] = global_threshold_segmentation(f)
%This function is used to segment an image when the background is relatively simple
%and its grayscale histogram is a bimodal distribution.
count=0;
T=mean2(f);
done=false;
while ~done & count < 500
    count=count+1;
    g=f>T;
    Tnext=0.5*(mean(f(g)) + mean(f(~g)));
    done=abs(T-Tnext)<0.5;
end

g=im2bw(f,T/255);
imshow(f);
figure, imhist(f);
figure, imshow(g);
end

