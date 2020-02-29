function [image, descriptors, locs] = sift(img)
%Scale-Invariant Feature Transform (SIFT)
%   The function is a local descriptor used for object recognition and image matching.
% It has the invariance of scale, rotation and translation and is robust to illumination change, 
% affine transformation and 3-D projection transformation.

% Load image
image = imread(img);
image = rgb2gray(image);

[rows, cols] = size(image);
% Convert into PGM imagefile, readable by "keypoints" executable
f = fopen('tmp.pgm', 'w');
if f == -1
error('Could not create file tmp.pgm.');
end
fprintf(f, 'P5\n%d\n%d\n255\n', cols, rows);
fwrite(f, 'image', 'uint8');
fclose(f);
% Call keypoints executable
if isunix
command = '!./sift ';
else
command = '!siftWin32 ';
end
command = [command ' <tmp.pgm >tmp.key'];
eval(command);
% Open tmp.key and check its header
g = fopen('tmp.key', 'r');
if g == -1
error('Could not open file tmp.key.');
end
[header, count] = fscanf(g, '%d %d', [1 2]);
if count ~= 2
error('Invalid keypoint file beginning.');
end
num = header(1);
len = header(2);
if len ~= 128
error('Keypoint descriptor length invalid (should be 128).');
end
% Creates the two output matrices (use known size for efficiency)
locs = double(zeros(num, 4));
descriptors = double(zeros(num, 128));
% Parse tmp.key
for i = 1:num
[vector, count] = fscanf(g, '%f %f %f %f', [1 4]); %row col scale ori
if count ~= 4
error('Invalid keypoint file format');
end
locs(i, :) = vector(1, :);
[descrip, count] = fscanf(g, '%d', [1 len]);
if (count ~= 128)
error('Invalid keypoint file value.');
end
% Normalize each input vector to unit length
descrip = descrip / sqrt(sum(descrip.^2));
descriptors(i, :) = descrip(1, :);
end
fclose(g);
function showkeys(image, locs)
disp('Drawing SIFT keypoints ...');
% Draw image with keypoints
figure('Position', [50 50 size(image,2) size(image,1)]);
colormap('gray');
imagesc(image);
hold on;
imsize = size(image);
for i = 1: size(locs,1)
% Draw an arrow, each line transformed according to keypoint parameters.
TransformLine(imsize, locs(i,:), 0.0, 0.0, 1.0, 0.0);
TransformLine(imsize, locs(i,:), 0.85, 0.1, 1.0, 0.0);
TransformLine(imsize, locs(i,:), 0.85, -0.1, 1.0, 0.0);
end
hold off;
% ------ Subroutine: TransformLine -------
% Draw the given line in the image, but first translate, rotate, and
% scale according to the keypoint parameters.
%
% Parameters:
% Arrays:
% imsize = [rows columns] of image
% keypoint = [subpixel_row subpixel_column scale orientation]
%
% Scalars:
% x1, y1; begining of vector
% x2, y2; ending of vector
function TransformLine(imsize, keypoint, x1, y1, x2, y2)
% The scaling of the unit length arrow is set to approximately the radius
% of the region used to compute the keypoint descriptor.
len = 6 * keypoint(3);
% Rotate the keypoints by 'ori' = keypoint(4)
s = sin(keypoint(4));
c = cos(keypoint(4));
% Apply transform
r1 = keypoint(1) - len * (c * y1 + s * x1);
c1 = keypoint(2) + len * (- s * y1 + c * x1);
r2 = keypoint(1) - len * (c * y2 + s * x2);
c2 = keypoint(2) + len * (- s * y2 + c * x2);
line([c1 c2], [r1 r2], 'Color', 'c');

