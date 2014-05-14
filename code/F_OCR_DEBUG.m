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

disp2_level = 3; % how deep to display on console
nLptAll = 100; % database count

whichLpt = 2;    % if try on different LPTs each time
% [1] - random, [2] - group
sumLpt = 5;     % number of lpts to try
nSubplots = 11;  % number of subplots for each lpt
was = [-1];      % indexes of OCRed lpts
ft = [];         % feature vector - rows=features, cols=chars
iChAll = 1;     % index through all the lpt characters


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% groups of lpts
gpLpt = [];
gpIgnoreDef = [101];
%% informative
gpTilted = [9 14 24 25 33 43 46 48 50 55];
gpSlovak = [52]; % ignore
% gpSmallBlue = [43 70];
% gpNoDots = [80 16 66 69 40 66 33 96 39 80 41 31];
% gpDots = [81 43 92 5 86 94 77 75 18 71 29 6 11 83 70 45 20 3 76 67 63 56];
% gpSame = [ 40 101 13 102 ];
% gpLpt = [67 41 40 61];

%  gpLpt = [ 38 63 79 10 94 ]
gpBadHalves = [21];
gpRotateBad = [6];

%% get better
gbSegmentBad = [5]
gpShadowy = [ 41 40 43 ];
gpDisappears = [29 39]; % in DIsappear colorfull

gpLeftBad = [21];
gpFramingBad = [56];


gpBwingVeryBad = [ 43 ];
gpBwingBad = [ 6 52 56 91 98 21  ];
gpBwingMed = [ 1 24 38 51 76 82 ];
gpBwingGood = [ 41 44 64 89 70 47 40 73 ];
gpBwingGoodBoth = [ 17 79 37 74 2 27 33 49 54 60 61 71 92 100];

% gpLpt = cat(2,gpBwingBad, gpShadowy );
gpLpt = cat(2,gbSegmentBad,gpShadowy,gpDisappears);
% gpIgnoreDef = cat(2,gpFramingBad, gpBwingVeryBad, gpLeftBad, gpRotateBad, gpSlovak);

% gpLpt = cat(2,gpSame );
% gpLpt = cat(2,gpBwingGood );
% gpLpt = cat(2,gpBwingBad );
% gpLpt = cat(2,gpBwingBad, gpShadowy );

% remove from a those from b
a = gpLpt;
no = cat(2,gpIgnoreDef);
[r c]=find(bsxfun(@eq,a,no')');
[~,ia,~]=unique(c,'first');
gpLpt(r(ia)) = [];


% gpLpt = cat(2,gpBwingGood(1:5) );
% gpLpt = cat(2,gpShadowy, gpNotBwingRight);
% gpLpt = cat(2,gpShadowy );
% gpLpt = cat(2,gpDisappears );
% gpLpt = cat(2,gpDots);
% gpLpt = cat(2,gpNoDots);
% gpLpt = cat(2,gpTilted);
% gpLpt = cat(2,gpSmallBlue);
nml = numel(gpLpt);
num = 6;
if num>nml
    num = nml;
end
gpLpt = cat(2,gpLpt(1:num));

if whichLpt  == 2
    sumLpt = numel(gpLpt);
end
% traditional = [l->r] -> [u->d]
% FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = sumLpt; SX = nSubplots;

% all the [chim]s of processed lpts
chimzy = [];

% better for lpt = [u->d] -> [l->r] 
F_I=F_I+1; FI_here=F_I; figure(FI_here); SI = 0; SY = nSubplots; SX = sumLpt;
set(gcf,'units','normalized','outerposition',[0 0 1 1])


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load feature vector from samples for classification
global traAN;
global grpAN;
global traA;
global grpA;
global traN;
global grpN;
nam = 'classifier.mat';
if exist(nam,'file') == 0
    toSave = 1;
    draw =0;
    FT_getChimsFeatures(toSave,draw);
    load('features.mat')
    meas = ftv;
    species = charv;
    %% create training data and its group selectors
    [traAN, grpAN, traA , grpA, traN , grpN] = CREATE_trainingDataSets( meas, species);
end
load(nam);


% load font examples for feature creation
global font_chim;
global font_ch;
[font_chim, font_ch] = FT50_loadFontExamples();

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
tit = strcat('orig',num2str(numLpt),']]');
aux_imprint(im, tit );
ylabel(num2str(numLpt));
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
% draw = 1;
lRgb = F30_GET_cleanText(lRgb,draw);
rRgb = F30_GET_cleanText(rRgb,draw);



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% separate chars = imchars  

nChL = 3;
nChR = 4;
%returns cell array of char images
lchim = F40_getCharIms(lRgb, nChL, draw); 
rchim = F40_getCharIms(rRgb, nChR, draw); 

% get cell arrays of both halfs after one another
chim = cat(2,lchim, rchim);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% here save all the individual chims to one directory with incrementing
% index over all lpts
% % % % % % % for iCh = 1:7
% % % % % % %     nam = sprintf('chim\\ch_%03i.png',iChAll);
% % % % % % %     im = chim{iCh};
% % % % % % %     imwrite(im,nam,'png');
% % % % % % %     iChAll = iChAll+1;
% % % % % % % end
% that is all

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F50____________________________________________________
draw = 1;

char = '       ';
for iCh=1:7
    %returns cell array of feature vectors of inidividual characters
    [ftCh,ftNs] = F50_getFeaturesOfChar(chim{iCh}, iCh, draw); 
%     imshow(chim{iCh})
% % add this chim feature vector [ftCh] into next column in feature vector of
% % all chims [ft]
% ft = cat(2,ft,ftCh)
% % ftNs should be the same for all the chims..
% aux_imprintS(chim, iCh);

% F60____________________________________________________
% chimzy = cat(2,chimzy,chim);
% draw = 1;
% disp2(1,sprintf('#%3i Fatures:',numLpt));


    %returns array of characters
%     [char(iCh)] = F60_whichChar( iCh, ftCh, ftNs, meas, species); 
    [char(iCh)] = F60_whichChar( iCh, ftCh); 
end
% 
% print all char images in one pulp image
aux_imprintPulp(chim);
title(sprintf('%i=[%s]',numLpt,char));

%% ____________________________________________________
% time measurement
tim(iLpt)=toc();
endIn = mean(tim(1:iLpt)) * (sumLpt - iLpt);
timSum = sum(tim);
timEnd = endIn + timSum;

% disp(sprintf('This lpt took [%.2f]s, estimated end in [%.2f]s',...
%     tim(iLpt),endIn));
% disp(sprintf('#%3i [%.2f]s, passed [%.2f]s = [%.1f]%%, end in [%.2f]s',...
%     numLpt, tim(iLpt),timSum, timSum/timEnd*100, endIn));
disp2(1,sprintf('#%3i took [%.2f]s, [%.2f/%.2f]s == [%.1f]%% | endin''[%.2f]s',...
    numLpt, tim(iLpt),timSum, timEnd, timSum/timEnd*100, -endIn));
disp2(1,sprintf('LPTstr = >>>[%s]<<<',char));
pause(0.05)
% ____________________________________________________

% ____________________________________________________
% F70_check_strLpt.m
for iCh=1:7
    %returns array of characters
%     char[iChar] = F60_assume_char(features{iChar}, iChar, innerDraw); 
% porovnani se spravnou hodnotou a vypsani uspìl neuspìl popøípadì pøidání
% do statistiky a výpoèet bodù za projekt..
end

% if(SI~=SX)&&(iLpt==1) % if one subplot row is not wide enaugh
if(SI~=SY)&&(iLpt==1) % if one subplot row is not wide enaugh
%    clc;
   disp2(1,sprintf('YOU should change [nSubplots] value to [%i]', SI ));
%    break;

    nSubplots = SI;
    SY = nSubplots; 
    continue;
end

end % MAIN FOR LOOP END

totTim = sum(tim);
timMeanLpt = mean(tim);
disp2(1,sprintf('Total time of [%i]lpts is [%.2f]s, mean is [%.2f]s',...
    sumLpt, totTim, timMeanLpt ));

% save('chimzy.dat', chimzy, -mat)
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

