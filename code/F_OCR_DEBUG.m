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

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN OCR FCNS CALLING

% for debug reasons is the main for loop here - afterwards in F_OCR_all.m

nLptAll = 100; % database count

whichLpt = 2;    % if try on different LPTs each time
% [1] - random, [2] - group
sumLpt = 5;     % number of lpts to try
nSubplots = 11;  % number of subplots for each lpt
was = [-1];      % indexes of OCRed lpts

gpTilted = [9,14,24,25,33,43,46,48,50,55];
gpBadHalves = [21];
gpSmallBlue = [43,70];
gpNoDots = [80,16,66,69,40,66,33,96,39,80,41,31];
gpDots = [81,43,92,5,86,94,77,75,18,71,29,6,11,83,70,45,20,3,76,67,63,56];
gpDisappears = [29,39]; % in DIsappear colorfull
gpShadowy = [ 41,40, 13 ];
gpSame = [ 40,101, 13,102 ];
gpLpt = [67,41,40,61];

gpLpt = cat(2,gpSame );
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

% ____________________________________________________
% preprocess

% (stretch contrast)
% (stretch hsv)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rotate
lptRgb = rotate(lptRgb,draw);
% im = lptRgb;
% aux_imprint(im, strcat('rotated') );

draw = 0;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% remove frame
% lptGray = REMOVE_frame(lptRgb,draw);

%% remove horizontal margin = vertical left/right-strips
lptRgb = REMOVE_horizontalMargins(lptRgb, draw);
im = lptRgb;
aux_imprint(im, strcat('hmargin') );

%% Split lpt image into 2 parts
[lRgb,rRgb] = SPLIT_lpt(lptRgb, draw);

im = lRgb;
aux_imprint(im, strcat('left') );
% im = rRgb;
% aux_imprint(im, strcat('right') );
    
%% Make colors disappear into white
% lRgb = DISAPPEAR_colors(lRgb,draw);

lptRgb = lRgb;


% % creates color only im
% % lptC = aux_colorOfIm(lptRgb,draw);
% lptC = MAKE_lptC(lptRgb,draw);
% 
% im = lptC;
% aux_imprint(im,'lptC')
% 
% % lptRgb = lptRgb - lptC;
% % im = lptRgb;
% % aux_imprint(im,'colorless')

%% filter background through saturation
% make black areas blackier and compact
draw=0;
lptRgb = aux_rgb2grayMax(lptRgb,draw);
    im = lptRgb;
    aux_imprint(im,'lptRgb')
%% find frame by morph closing    

% thresh
lptG = rgb2gray(lptRgb);
lptG = imadjust(lptG);
    im = lptG;
    aux_imprint(im,'adjusted')

% level from hsv(val)??
lptHsv = rgb2hsv(lptRgb);
level = graythresh(lptHsv(:,:,2));
%     im = lptHsv(:,:,3);
%     aux_imprintS(im,'hsv3')
% bw = im2bw(lptG,level);
%     im = bw;
%     aux_imprintS(im,'bwHsv')
coef = 1.2;
level=level*coef;
bw = im2bw(lptG,level);
    im = bw;
    aux_imprintS(im,'bwHsvCoef')
    
% % or not
% level = graythresh(lptG);
% 
% 
% bw = im2bw(lptG,level);
%     im = bw;
%     aux_imprintS(im,'bw')

% add black frame around
lptBw = FRAME_image(bw,draw);
    im = lptBw;
    aux_imprintS(im,'bw')

% morph - open then close better
ih = size(lptRgb,1);
iw = size(lptRgb,2);

    
% do morph opening
R = ceil(ih / 40);
SE = strel('disk',R,4);
lptBw = imopen(lptBw, SE);
    lptBwO=lptBw;
% do morph closing
R = ceil(ih / 40);
SE = strel('disk',R,4);
lptBw = imclose(lptBw, SE);

    im = lptBwO;
    aux_imprintS(im,'opening')
    im = lptBw;
    aux_imprintS(im,'closed')
    
% find biggest (pxs) object
% delet it

%% find frame by projections   

% ____________________________________________________
% horizontal and vertical projection


% xprjC,yprjC - projections of [lptC]
norma = 0;
xprjC = aux_projectDown(lptBw,               norma);
yprjC = aux_projectDown(imrotate(lptBw,-90), norma);
xprjCN = aux_projNorm(xprjC);
yprjCN = aux_projNorm(yprjC);

% plot'em
aux_plotRgbs(xprjC, strcat('xprjC'), 0);
aux_plotRgbs(xprjC, strcat('xprjC'), 3);
aux_plotRgbs(yprjC, strcat('yprjC'), 0); camroll(90);
aux_plotRgbs(yprjC, strcat('yprjC'), 2); camroll(90);


%% disappear
draw = 1;
% 
% lptC = aux_colorOfIm(lptRgb,draw);
% lptRgb = lptRgb - lptC;
% lptRgb = DISAPPEAR_colorfullPixels(lptRgb,draw);




%% remove vertical margins = horizontal upper/lower-strips

% %% remove horizontal margins = vertical left/right-strips
% % ____________________________________________________
% % horizontal and vertical projection
% 
% % color only after cutting
% lptC = aux_colorOfIm( lptRgb, 0 );
% 
% % xprjC,yprjC - projections of [lptC]
% norma = 0;
% xprjC = aux_projectDown(lptC,               norma);
% yprjC = aux_projectDown(imrotate(lptC,-90), norma);
% xprjCN = aux_projNorm(xprjC);
% yprjCN = aux_projNorm(yprjC);
% 
% % plot'em
% aux_plotRgbs(xprjC, strcat('xprjC'), 0);
% aux_plotRgbs(xprjC, strcat('yprjC'), 3);
% aux_plotRgbs(yprjC, strcat('xprjC'), 0); camroll(90);
% aux_plotRgbs(yprjC, strcat('yprjC'), 2); camroll(90);

% ____________________________________________________
% skew lpt??
% ____________________________________________________
% edges
% % F = 'sobel';
% % F = 'log';
% % F = 'prewitt';
% % F = 'zerocross';
% F = 'canny';
% im = edge(bw, F);
% 
% aux_imprintS(im,'edge');
% xprjEE = aux_projectDown(sLptC.area_euro,0);

% % % make 5 horiz lines -> find edges
% im = sLptC.area_euroEd;
% aux_imprintS(im,[]);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make two parts
% do not try to find green dot 
% if - found r-disc - in previous section (or try to find for the first time)

% % highest peak left and righ border (from center of lpt)
% % % = diff of peak from center
% % % - cut it from the picture
% % % on the left is one part, on the right is the second -> +flag= 2parts
% else - no g/r-disc
% % try it from xintegColorless(4) = sum of r,g,b channels
% % % = diff of peak from center 
% % % searching for edge down and up not so close togeather as others!


%% del color thingy - euro and signs - low frame should be removed already
% sumLpt(:,:) = lpt(:,:,1)+lpt(:,:,2)+lpt(:,:,3);
% sumLpt = imfuse(lpt(:,:,1),lpt(:,:,2),'blend');
% sumLpt = imfuse(sumLpt,lpt(:,:,3),'blend');


% hsvCol = rgb2hsv(colOfLpt);
% in some interval of hue -> create a mask


% lower the number of colors in palette
% mapCols = hsv(3);
% mapCols = cat(1, mapCols, [0 0 0]);
% colOfLpt = imsharpen(colOfLpt);

% lpt4cols = rgb2ind(colOfLpt_contrasted ,mapCols,'nodither');

% apply black / white through the mask
% if red or green --> white
% if blue --> black


%% remove frame or precolor gray?
% % try to find transformation of char first?? <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
% lptGray = rgb2gray(lptRgb);
% lptGray = imadjust(lptGray);
% im = lptGray ;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('lptGray')); axis tight
% 
% % lower the number of colors in palette
%  lptGrayRgb = repmat(lptGray(:,:),[1,1,3]);
%  
%  mapCols = gray(5);
%  
% lptGrayRgbFew = rgb2ind(lptGrayRgb,mapCols,'nodither');
% 
% im = lptGrayRgbFew;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('lptGray')); axis tight
% % utilise edison wrapper = mean-shift? but long compute time?
% 
% % lptRgb = contrastFrame;

%% separate chars? 

% thin margin

im = lptRgb;
aux_imprint(im , strcat('bw preprocessed text only]]') );

% imfuse

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

% ____________________________________________________
draw = 1;
chims = F40_getCharIms(lptRgb, draw); %returns cell array of char images

imPulp = 0;
for iChar=1:7
    im = chims{iChar};
    if(iChar == 1)
        imPulp = im;
    else
        imPulp = cat(2,imPulp,im);
%         imPulp = imfuse(imPulp,im,'montage');
    end
end
aux_imprint(imPulp, strcat('im of char[',num2str(iChar),']') );

% F50____________________________________________________
draw = 1;
for iChar=1:7
    %returns cell array of feature vectors of inidividual characters
    features{iChar} = F50_getFeaturesOfChar(chims{iChar}, iChar, draw); 
end
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
   disp(sprintf('YOU should change [nSubplots] value to [%i]', ...
       SI ));
   
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




