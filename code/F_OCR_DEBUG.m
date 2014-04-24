% /***********
% \project    MAPV - Projekt 2 - Separace a rozpozn�n� znak� SPZ
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
F0_defines();
FI = 0; % initialization - only on one place - delete when OCR_LPT works

ft = struct( ...
    'point', 1, ...
    'areaSumRel', 1,...
    'areaSumAbs', 1,...
    'circumfrnc', 1,...
    'eulerNum', 1 ...
);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN OCR FCNS CALLING

% for debug reasons is the main for loop here - afterwards in F_OCR_all.m

nLptAll = 100; % database count

randLpt = 1;    % if try on different LPTs each time
sumLpt = 3;     % number of lpts to try
nSubplots = 9;  % number of subplots for each lpt

FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = sumLpt; SX = nSubplots;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN FOR LOOP
for iLpt = 1:sumLpt % MAIN FOR LOOP START
tic()
%% picture aquisition
    if(randLpt == 1)
        numLpt = ceil((nLptAll-1)*rand(1) + 1); % random from <1;100>
    else
        numLpt = iLpt;
    end
    imgPath = sprintf('SPZ_%03d.bmp', numLpt);
    lptRgb = imread(imgPath);

% ____________________________________________________
% original plot
im = lptRgb;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('orig',num2str(numLpt),']]')); axis tight

% ____________________________________________________
innerDraw = 0;
% lpt = F30_getCleanText(lpt, innerDraw);

lptRgb = rotate(lptRgb,innerDraw);
innerDraw = 1;


%% del color thingy - euro and signs - low frame should be removed already
% sumLpt(:,:) = lpt(:,:,1)+lpt(:,:,2)+lpt(:,:,3);
% sumLpt = imfuse(lpt(:,:,1),lpt(:,:,2),'blend');
% sumLpt = imfuse(sumLpt,lpt(:,:,3),'blend');

colOfLpt = aux_colorOfIm(lptRgb);

% hsvCol = rgb2hsv(colOfLpt);
% in some interval of hue -> create a mask

im = colOfLpt ;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('colOfLpt')); axis tight

inv_colOfLpt = imcomplement(colOfLpt);

% find_color(colOfLpt,[],0.2, []);
col = color('red');
col = imcomplement(col);
maskR = find_color(inv_colOfLpt,[],0.2, col');

col = color('green');
col = imcomplement(col);
maskG = find_color(inv_colOfLpt,[],0.2, col');

col = color('blue');
col = imcomplement(col);
maskB = find_color(inv_colOfLpt,[],0.2, col');
% maskR = zeros(size(colOfLpt));
% maskB = maskR;
% maskG = maskB;
% 
% for y=1:size(colOfLpt,1)
%     for x=1:size(colOfLpt,2)
%         meanCol(y,x) = mean([colOfLpt(y,x,1),colOfLpt(y,x,2),colOfLpt(y,x,3)]);
%         maskR(y,x) = colOfLpt(y,x,1)-meanCol(y,x);
%         maskG(y,x) = colOfLpt(y,x,2)-meanCol(y,x);
%         maskB(y,x) = colOfLpt(y,x,3)-meanCol(y,x);
%     end
% end
% maskR(maskR<0) = 0;
% maskG(maskG<0) = 0;
% maskB(maskB<0) = 0;
% 
% maskR(1,1) = 255;
% maskG(1,1) = 255;
% maskB(1,1) = 255;
% maskR = colOfLpt( 255 > colOfLpt(:,:,1) > 200);


im = maskR ;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('maskR')); axis tight

im = maskG ;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('maskG')); axis tight
im = maskB ;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('maskB')); axis tight
% apply black / white through the mask
% if red or green --> white
% if blue --> black


%% remove frame
% try to find transformation of char first?? <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
lptGray = rgb2gray(lptRgb);
lptGray = imadjust(lptGray);
im = lptGray ;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('lptGray')); axis tight

% lower the number of colors in palette
 lptGrayRgb = repmat(lptGray(:,:),[1,1,3]);
 
 mapCols = gray(5);
 
lptGrayRgbFew = rgb2ind(lptGrayRgb,mapCols,'nodither');

im = lptGrayRgbFew;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('lptGray')); axis tight
% utilise edison wrapper = mean-shift? but long compute time?

% lptRgb = contrastFrame;

%% separate chars? 



% thin margin

im = lptRgb;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('bw preprocessed text only]]')); axis tight

% imfuse


% ____________________________________________________
innerDraw = 1;
chims = F40_getCharIms(lptRgb, innerDraw); %returns cell array of char images

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
    SI=SI+1; subplot2(SY,SX,SI); 
    imshow(imPulp,[]); title(strcat('im of char[',num2str(iChar),']')); axis tight

% F50____________________________________________________
innerDraw = 1;
for iChar=1:7
    %returns cell array of feature vectors of inidividual characters
    features{iChar} = F50_getFeaturesOfChar(chims{iChar}, iChar, innerDraw); 
end
% F60____________________________________________________
innerDraw = 1;

char = '       ';
for iChar=1:7
    %returns array of characters
    char(iChar) = F60_whichChar( features{iChar}, iChar, innerDraw); 
end

toc()
disp(strcat('LPTstr = [',char,']'));
title(char);
% ____________________________________________________

% ____________________________________________________
% F70_check_strLpt.m
for iChar=1:7
    %returns array of characters
%     char[iChar] = F60_assume_char(features{iChar}, iChar, innerDraw); 
% porovnani se spravnou hodnotou a vypsani usp�l neusp�l pop��pad� p�id�n�
% do statistiky a v�po�et bod� za projekt..
end


if(SI~=SX)&&(iLpt==1) % if one subplot row is not wide enaugh
   clc;
   disp(strcat('YOU should change [nSubplots] value to [', num2str(SI),']'));
   break;
end

end % MAIN FOR LOOP END





