close all
clear all
clc

files_number = 8;
rgb = cell(1,files_number);
bw = cell(1,files_number);
bw_resized = cell(1,files_number);
wb_resized = cell(1,files_number);
wb_skel = cell(1,files_number);

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
    wb_resized{i} = imcomplement(bw_resized{i});
    wb_skel{i} = bwmorph(wb_resized{i},'skel',Inf);
%     se = strel('disk',3);        
%     wb_skel{i} = imerode(wb_resized{i}, se);
end

for i = 1:files_number
    
end

figure(3)
for i = 1:files_number
    subplot(1, files_number, i)
    imshow(wb_skel{i})
    title(name{i})
end

vzor = (size(wb_skel{2},1)*size(wb_skel{2},2))- sum(sum(wb_skel{2}));

for i = 1:files_number
    temp = (size(wb_skel{i},1)*size(wb_skel{i},2))- sum(sum(wb_skel{i})) - vzor;
     sprintf('%s: %d',name{i}, temp)
end
