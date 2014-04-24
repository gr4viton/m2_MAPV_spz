close all
clear all
clc
  
files_number = 8;
rgb = cell(1,files_number);
bw = cell(1,files_number);
bw_resized = cell(1,files_number);
wb_resized = cell(1,files_number);
wb_skel = cell(1,files_number);
points = cell(1,files_number);
features = cell(1,files_number);
valid_points = cell(1,files_number);

names = cell(1,files_number);

rgb{1} = imread('SPZ_058_3.bmp');
rgb{2} = imread('SPZ_058_8.bmp');
rgb{3} = imread('SPZ_066_8.bmp');
rgb{4} = imread('SPZ_066_B.bmp');
rgb{5} = imread('SPZ_024_8.bmp');
rgb{6} = imread('SPZ_037_8.bmp');
rgb{7} = imread('SPZ_037_B.bmp');
rgb{8} = imread('SPZ_046_9.bmp');

name{1} = 'SPZ-058-3';
name{2} = 'SPZ-058-8';
name{3} = 'SPZ-066-8';
name{4} = 'SPZ-066-B';
name{5} = 'SPZ-024-8';
name{6} = 'SPZ-037-8';
name{7} = 'SPZ-037-B';
name{8} = 'SPZ-046-9';

lvl = 0;

for i = 1:files_number 
    lvl = lvl + graythresh(rgb{i});
end

lvl = lvl /4;
% lvl = 0.35;

for i = 1:files_number 
%     bw{i} = im2bw(rgb{i}, lvl);
    bw{i} = im2bw(rgb{i}, graythresh(rgb{i}));
end

figure(1)
for i = 1:files_number
    subplot(1, files_number, i)
    imshow(bw{i})
    title(name{i})
end

bw_resized{1} = bw{1};

for i = 1:files_number
    bw_resized{i} = imresize(bw{i}, [size(bw{1}, 1) size(bw{1}, 2)]);
%     bw_resized{i} = imresize(bw_resized{i}, 10);
end

figure(2)
for i = 1:files_number
    subplot(1, files_number, i)
    imshow(bw_resized{i})
    title(name{i})
end

for i = 1:files_number
   points{i} = detectSURFFeatures(bw_resized{i});
%   [features{i}, valid_points{i}] = extractFeatures(bw_resized{i}, points{i});
end

figure(3)
for i = 1:files_number
    subplot(1, files_number, i)
    imshow(bw_resized{i}); 
    hold on;
    strongestPoints = points{i}.selectStrongest(10);
    strongestPoints.plot('showOrientation',true);
    title(name{i})
end