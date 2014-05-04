% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
% \date		  15-04-2014
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [stringLPT] = F_OCR_LPT ( lpt, iLpt )
% Calls individual functions to OCR the LPT string from image [im]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEANING - delete when it works
close all; clear; clc;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_initials();

% on start of every function draw=draw-1;
% if draw>0
% -> than it means how many levels will it draw

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN OCR FCNS CALLING

% for debug reasons is the main for loop here - afterwards in F_OCR_all.m

nLptAll = 100; % database count

whichLpt = 2;    % if try on different LPTs each time
% [1] - random, [2] - group
sumLpt = 5;     % number of lpts to try
nSubplots = 11;  % number of subplots for each lpt
was = [-1];      % indexes of OCRed lpts

gpTilted = [9 14 24 25 33 43 46 48 50 55];
gpBadHalves = [21];
gpSmallBlue = [43 70];
gpNoDots = [80 16 66 69 40 66 33 96 39 80 41 31];
gpDots = [81 43 92 5 86 94 77 75 18 71 29 6 11 83 70 45 20 3 76 67 63 56];
gpDisappears = [29 39]; % in DIsappear colorfull
gpShadowy = [ 41 40 13 ];
gpSame = [ 40 101 13 102 ];
gpSlovak = [52];
gpBwingBad = [1 6 24 38 43 47 51 52 56 70 76 82 89 91 98 21 44 64 73];
gpBwingGood = [40 17 79 37 74 2 27 33 49 54 60 61 71 92 100];
gpLpt = [67 41 40 61];

% gpLpt = cat(2,gpSame );
gpLpt = cat(2,gpBwingGood );
% gpLpt = cat(2,gpShadowy, gpNotBwingRight);
% gpLpt = cat(2,gpShadowy );
% gpLpt = cat(2,gpDisappears );
% gpLpt = cat(2,gpDots);
% gpLpt = cat(2,gpNoDots);
% gpLpt = cat(2,gpTilted);
% gpLpt = cat(2,gpSmallBlue);
if whichLpt  == 2
    sumLpt = numel(gpLpt);
end
% traditional = [l->r] -> [u->d]
% FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = sumLpt; SX = nSubplots;

% better for lpt = [u->d] -> [l->r] 
FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = nSubplots; SX = sumLpt;
set(gcf,'units','normalized','outerposition',[0 0 1 1])

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN FOR LOOP
for iLpt = 1:sumLpt % MAIN FOR LOOP START
tic()
%% picture aquisition

    numLpt = iLpt;
    if whichLpt  == 1
%         if isempty
        while numel(was)<100
            numLpt = ceil((nLptAll-1)*rand(1) + 1); % random from <1;100>
            if isempty(was(was==numLpt))
                % for the first time
                was = cat(2,numLpt);           
                break;                
            end
        end
    elseif whichLpt  == 2
        numLpt = gpLpt(iLpt);
    end
    imgPath = sprintf('SPZ_%03d.bmp', numLpt);
    lptRgb = imread(imgPath);

% ____________________________________________________
% original plot
im = lptRgb;
aux_imprint(im, strcat('orig',num2str(numLpt),']]') );
% ____________________________________________________
draw = 0;
% lpt = F30_getCleanText(lpt, innerDraw);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rotate
lptRgb = rotate(lptRgb,draw);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% remove frame
% lptGray = REMOVE_frame(lptRgb,draw);

%% remove horizontal margin = vertical left/right-strips
lptRgb = REMOVE_horizontalMargins(lptRgb, draw);
% im = lptRgb;
% aux_imprint(im, strcat('hmargin') );

%% Split lpt image into 2 parts
[lRgb,rRgb] = SPLIT_lpt(lptRgb, draw);
    
    L = GET_whiteLineVRgb(lRgb);
    im = cat(2,lRgb,L,rRgb);
    aux_imprint(im, strcat('left|right') );
    
%% Clean splitted text images
draw = 0;
lRgb = F30_GET_cleanText(lRgb,draw);
rRgb = F30_GET_cleanText(rRgb,draw);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% separate chars = imchars  

nChL = 3;
nChR = 4;
%returns cell array of char images
lchim = F40_getCharIms(lRgb, nChL, draw); 
rchim = F40_getCharIms(rRgb, nChR, draw); 

chim = cat(2,lchim, rchim);
% imfuse

imPulp = [chim{1}];
for iChar=2:7
    im = [chim{iChar}];
    % imPulp = blkdiag(imPulp,im);        
    ih = size(im,1);
    ip = size(imPulp,1);
    if ih>ip
        iw = size(imPulp,2);
        imPulp = cat(1,imPulp,ones(ih-ip,iw));
    elseif ih<ip
        iw = size(im,2);
        im = cat(1,im,ones(ip-ih,iw));
    end
    L = GET_whiteLineVBw(imPulp);
    imPulp = cat(2,imPulp,L,im);
    % imPulp = imfuse(imPulp,im,'montage');
end

% image
% hi = size(inRgb,1);
% % wi = size(in,2);
% wL = 2;
% chL = repmat(255*ones(hi,1),1,wL); %=imLineChannel
% L = cat(3,chL, chL, chL); %=imLineRgb


aux_imprintS(imPulp, strcat('all chims') );

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F50____________________________________________________
draw = 1;

% individual region properties

% ____________________________________________________
% horizontal and vertical projection


% xprjC,yprjC - projections of [lptC]
% norma = 0;
% xprjC = aux_projectDown(lptBw,               norma);
% yprjC = aux_projectDown(imrotate(lptBw,-90), norma);
% xprjCN = aux_projNorm(xprjC);
% yprjCN = aux_projNorm(yprjC);
% 
% % plot'em
% aux_plotRgbs(xprjC, strcat('xprjC'), 0);
% aux_plotRgbs(xprjC, strcat('xprjC'), 3);
% aux_plotRgbs(yprjC, strcat('yprjC'), 0); camroll(90);
% aux_plotRgbs(yprjC, strcat('yprjC'), 2); camroll(90);

% % do morph erosion
% R = ceil(ih / 80);
% SE = strel('disk',R,4);
% lptBw = imerode(lptBw, SE);
%     im = lptBw;
%     aux_imprintS(im,'erosion')
%     
% % do morph opening
% R = ceil(ih / 40);
% SE = strel('disk',R,4);
% lptBw = imopen(lptBw, SE);
%     im = lptBw;
%     aux_imprintS(im,'opening')
% 
% % do morph closing
% R = ceil(ih / 40);
% SE = strel('disk',R,4);
% lptBw = imclose(lptBw, SE);
%     im = lptBw;
%     aux_imprintS(im,'closed')

% for iChar=1:7
%     %returns cell array of feature vectors of inidividual characters
%     features{iChar} = F50_getFeaturesOfChar(chim{iChar}, iChar, draw); 
% end
% F60____________________________________________________
draw = 1;

char = '       ';
for iChar=1:7
    %returns array of characters
    char(iChar) = F60_whichChar( features{iChar}, iChar, draw); 
end

tim(iLpt)=toc();
endIn = mean(tim(1:iLpt)) * (sumLpt - iLpt);
timSum = sum(tim);
timEnd = endIn + timSum;
% disp(sprintf('This lpt took [%.2f]s, estimated end in [%.2f]s',...
%     tim(iLpt),endIn));
disp(sprintf('#%3i [%.2f]s, passed [%.2f]s = [%.1f]%%, end in [%.2f]s',...
    numLpt, tim(iLpt),timSum, timSum/timEnd*100, endIn));
disp(sprintf('LPTstr = [%s]',char));
title(char);
% ____________________________________________________

% ____________________________________________________
% F70_check_strLpt.m
for iChar=1:7
    %returns array of characters
%     char[iChar] = F60_assume_char(features{iChar}, iChar, innerDraw); 
% porovnani se spravnou hodnotou a vypsani uspìl neuspìl popøípadì pøidání
% do statistiky a výpoèet bodù za projekt..
end

% if(SI~=SX)&&(iLpt==1) % if one subplot row is not wide enaugh
if(SI~=SY)&&(iLpt==1) % if one subplot row is not wide enaugh
   clc;
   disp(sprintf('YOU should change [nSubplots] value to [%i]', SI ));
   
%    break;
    nSubplots = SI;
    SY = nSubplots; 
    continue;
end

end % MAIN FOR LOOP END

totTim = sum(tim);
timMeanLpt = mean(tim);
disp(sprintf('Total time of [%i]lpts is [%.2f]s, mean is [%.2f]s',...
    sumLpt, totTim, timMeanLpt ));

% END OF OCR





%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% not used yet?
% ____________________________________________________
% lower the number of colors in palette
% mapCols = hsv(3);
% mapCols = cat(1, mapCols, [0 0 0]);
% colOfLpt = imsharpen(colOfLpt);
% lpt4cols = rgb2ind(colOfLpt_contrasted ,mapCols,'nodither');
% ____________________________________________________
% REMOVE_frame and 3 inside 
% - adaptive hist..
% ____________________________________________________
% % % % % % % % % % % % % % activecontour!!!!!!!!!!!!!!!!!!!!!!

%% may not use at all
% ____________________________________________________
% Make colors disappear into white
% lRgb = DISAPPEAR_colors(lRgb,draw);
% ____________________________________________________
% aux_rgb2grayMax
% ____________________________________________________
% lptRgb = DISAPPEAR_colorfullPixels(lptRgb,draw);
% ____________________________________________________
% edges
% % F = 'sobel';
% % F = 'log';
% % F = 'prewitt';
% % F = 'zerocross';
% F = 'canny';
% im = edge(bw, F);
% ____________________________________________________
% make 5 horiz lines -> find edges
% ____________________________________________________
% sumLpt = imfuse(sumLpt,lpt(:,:,3),'blend');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

