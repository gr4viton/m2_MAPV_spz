close all
clear all
clc

files_number = 4;
rgb = cell(1,files_number);
bw = cell(1,files_number);
bw_resized = cell(1,files_number);
bw_fft = cell(1,files_number);

hist_x = cell(1,files_number); % nad osou x
hist_y = cell(1,files_number); % nad osou y

names = cell(1,files_number);

rgb{1} = imread('SPZ_058_3.bmp');
rgb{2} = imread('SPZ_058_8.bmp');
rgb{3} = imread('SPZ_024_8.bmp');
rgb{4} = imread('SPZ_066_B.bmp');
% rgb{5} = imread('SPZ_024_8.bmp');

name{1} = 'SPZ-058-3';
name{2} = 'SPZ-058-8';
name{3} = 'SPZ-024-8';
name{4} = 'SPZ-066-B';
% name{5} = 'SPZ_024_8';

lvl = 0;

for i = 1:files_number 
    lvl = lvl + graythresh(rgb{i});
end

lvl = lvl /4;
% lvl = 0.35;

for i = 1:files_number 
    bw{i} = im2bw(rgb{i}, lvl);
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

cols = size(bw_resized{1}, 2);
rows = size(bw_resized{1}, 1);

for i = 1:files_number
    
    hist_x{i} = zeros(1, cols);
    hist_y{i} = zeros(1, rows);
    
    for j = 1:cols
        hist_x{i}(1,j) = sum(bw_resized{i}(:,j));
    end
    
    for j = 1:rows
        hist_y{i}(1,j) = sum(bw_resized{i}(j,:));
    end
    
end

figure(3)
for i = 1:files_number
    subplot(2, files_number, i)
    plot(hist_x{i})
    title([name{i} ' x'])
    
    subplot(2, files_number, i+4)
    plot(hist_y{i})
    title([name{i} ' y'])
end

vzor_8_x = hist_x{2};
vzor_8_y = hist_y{2};

for i = 1:files_number
     sprintf('%s: %d',name{i}, (max(xcorr(vzor_8_x, hist_x{i})) + max(xcorr(vzor_8_y, hist_y{i})))/2)
%      sprintf('%s %d',name{i}, (vzor_8_x*hist_x{i}' + vzor_8_y*hist_y{i}')/2)
%      sprintf('%s: %d',name{i}, (sum(abs((vzor_8_x-hist_x{i}))) + sum(abs((vzor_8_y-hist_y{i}))))/2)
%      sprintf('%s x: %d',name{i}, sum(abs((vzor_8_x-hist_x{i}))))
%      sprintf('%s y: %d',name{i}, sum(abs((vzor_8_y-hist_y{i}))))
end

for i = 1:files_number
    bw_fft{i} = log10(abs(fftshift(fft2(bw_resized{i}))));
end

figure(4)
for i = 1:files_number
    subplot(1, files_number, i)
    imshow(bw_fft{i})
end

vzor_8_fft = bw_fft{2};
% vzor_8 = bw_resized{2};

% figure(5)
% for i = 1:files_number
%      subplot(1, files_number, i)
%      sloupce = zeros(1, size(bw_resized{i}, 1));
%      for j = 1:size(vzor_8, 1)
%             sloupce(j) = max(xcorr(uint8(vzor_8(j, :)), uint8(bw_resized{i}(j, :))));
%      end
%      plot(sloupce)
% %      sprintf('Fourierka %s: %d',name{i}, (sum(sum(abs(vzor_8_fft - bw_fft{i})))))
% end

% figure(6)
for i = 1:files_number
     sprintf('Fourierka %s: %d',name{i}, (max(max(xcorr2(vzor_8_fft, bw_fft{i})))))
    
%      subplot(1, files_number, i)
%      sloupce = zeros(1, size(bw_fft{i}, 1));
%      for j = 1:size(bw_fft{i}, 1)
%             sloupce(j) = max(xcorr(vzor_8_fft(j, :), bw_fft{i}(j, :)));
%      end
%      plot(sloupce)
%      sprintf('Fourierka %s: %d',name{i}, (sum(sum(abs(vzor_8_fft - bw_fft{i})))))
end