%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEANING - delete when it works
close all; clear; clc;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_initials();
addpath('.\debug');
% 
% 
% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp2_level = 3; % how deep to display on console
% nLptAll = 100; % database count
% 
% whichLpt = 2;    % if try on different LPTs each time
% % [1] - random, [2] - group
% sumLpt = 5;     % number of lpts to try
% nSubplots = 11;  % number of subplots for each lpt
% was = [-1];      % indexes of OCRed lpts
% 
% gpLpt = [67 41 40 61];
% if whichLpt  == 2
%     sumLpt = numel(gpLpt);
% end
% traditional = [l->r] -> [u->d]
FI = 0;
SY = 3;
SX = 12;
FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = SY; SX = SX;
% 
% % all the [chim]s of processed lpts
% chimzy = [];
% 

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% chimzy = cat(2,chimzy,chim);

% load('chimzy.mat')
%% load images from chimzy dir
% done = 0;
%     imgPath = 'chimzy\'; 
%     dCell = dir(strcat(imgPath,'*.png'));    
% for iA = 1:length(dCell) 
%     chimzy{iA} = imread(strcat(imgPath, dCell(iA).name)); 
%     should{iA} = dCell(iA).name(1);
% end
% chim = chimzy;
dirfont = 'font\';
path = [dirfont,'font.png'];
im = imread(path);
% to bw
im = uint8(rgb2gray(im));
lvl = graythresh(im);
im = im2bw(im,lvl);

% remove last line
ih = size(im,1);
h = ceil(ih/4);

im = im(1:3*h,:);

% remove cz euro sign
iw = size(im,2);
w = ceil(iw/13);
im(1:h,1:w) = 1;
imshow(im)

bw = imcomplement(im);

chs{1} = '0123456789';
chs{2} = 'ABCDEFGHIJKLM';
chs{3} = 'NOPQRSTUVWXYZ';
% po radcich
for q=1:3
    from = (q-1)*h+1;
    to = q*h;
    im = bw(from:to,:);

    ih = size(im,1);
    iw = size(im,2);
    
    cc = bwconncomp(im, 4);
    labeled = labelmatrix(cc);
    RGB_label = label2rgb(labeled, @copper, 'c', 'noshuffle');

%     aux_imprint(RGB_label,'radek');
    
% save each character
    cnt = max(max(labeled));
    subdir = 'chims\';
    for c = 1:cnt
        
%         character
        ch = chs{q}(c);
%         chimage
        chim = labeled==c;
        chim = reshape(chim,ih,iw);

        s = regionprops(chim,'BoundingBox');
        bb = ceil(s.BoundingBox);
        if(ch~='I')
%             in I character there would be no background
            bb(3:4) = bb(3:4)-1;
        end
        chim = imcrop(chim, bb);
        max(max(chim))
%         chim = uint8(chim) ./ uint8(c);
        
        aux_imprintS(chim,ch);
%         write
        name = sprintf('%c.png',ch);
        path = strcat(dirfont,subdir,name);
        imwrite(chim,path,'png');
    end
end
 
% numPixels = cellfun(@numel, cc.PixelIdxList);
% [biggest, idx] = max(numPixels);

% bw_notBiggest = bw;
% bw_notBiggest(cc.PixelIdxList{idx}) = 0;

% cc now have only object with most pixels
% bw_biggest = bw - bw_notBiggest;
% 