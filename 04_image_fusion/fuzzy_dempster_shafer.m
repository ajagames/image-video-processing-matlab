function = fuzzy_dempster_shafer(x,y)
%This function process images using fuzzy Dempster-Shafer evidence theory.
%   Fuzzy C-Means clustering is operated on two source images to
% get the fuzzy membership degree of each point in each image.The simple
% hypothesis and compound hypothesis are determined according to the fuzzy category.
% The single and compound basic probability assignment mass function values of
% each pixel in the two images are determined by the heuristic least squares algorithm.
% The basic probability assignment of two images is fused with the Dempster
% criterion in D-S evidential theory and the final fusion result is obtained by decision.


% DS-fusion theory function
function x=DS_fusion(x,y)
% function:fuse x, y two vectors(classic Dempster-Shafer Combination formula)
% x,y s’ format looks like[m1 m2 m3, ... , mk, m(complete set), m(null set)]
% Require m1 m2 m3 ...don’t have Intersection
% m(complete set)could be zero or not, representing Uncertainty
% m(null se)must be 0
[nx,mx]=size(x);
if 1~=nx
disp('x should be row vector');
return;
end
[ny,my]=size(y);
if 1~=ny
disp('y should be row vector');
return;
end
if mx~=my
disp('x,y should have equal cols');
return;
end
temp=0;
for i=1:mx-1
if i==mx-1
x(1,i)=x(1,i)*y(1,i); %special operation on complete set
else
x(1,i)=x(1,i)*y(1,i)+x(1,i)*y(1,mx-1)+y(1,i)*x(1,mx-1);
end
temp=temp+x(1,i);
end
for i=1:mx-1
x(1,i)=x(1,i)/temp;
end
x(1,mx)=0;
% Image fusion function
subplot(1,3,1);
imshow(g);
title('Fist image');
subplot(1,3,2);
imshow(h);
Title ('Second image');
g1=g(:);
h1=h(:);
g2=g1';
h2=h1';
a(1,1:65536)=DS_fusion(g2,h2);
b=a;
k=6500000.*b;
l=uint8(k);
l2=reshape(l,256,256);
subplot(1,3,3);
l3=imadjust(l2,[],[],1);
imshow(l3);
title(‘fusion result’);

end

