% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10, xnovac10, xsauer01, xvlada00 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
% \date		  15-04-2014
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [strLpt] = F_OCR_LPT ( lptRgb , draw )
% Calls individual functions to OCR the LPT string from image [im]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEANING - delete when it works
% close all; clear; clc;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_initials();

% on start of every function draw=draw-1;
% if draw>0
% -> than it means how many levels will it draw

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN OCR FCNS CALLING

% for debug reasons is the main for loop here - afterwards in F_OCR_all.m
numLpt = 1;

nSubplots = 4;  % number of subplots for each lpt
ft = [];         % feature vector - rows=features, cols=char

if draw==1
    % better for lpt = [u->d] -> [l->r] 
    F_I=F_I+1; FI_here=F_I; figure(FI_here); SI = 0; SY = nSubplots; SX = 1;
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN OCR FCNS CALLING

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
if exist('grpA','var') == 0
    load(nam);
end


% load font examples for feature creation
global font_chim;
global font_ch;
if isempty('font_chim') 
    [font_chim, font_ch] = FT50_loadFontExamples();
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN FOR LOOP

tic()
% ____________________________________________________
% original plot
if draw==1;
im = lptRgb;
tit = strcat('orig]]');
aux_imprint(im, tit );
% ylabel(num2str(numLpt));
end
% ____________________________________________________
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
    
if draw==1;
    L = GET_whiteLineVRgb(lRgb);
    im = cat(2,lRgb,L,rRgb);
    aux_imprint(im, strcat('left|right') );
end
    
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
% F50____________________________________________________

strLpt = '       ';
nml = numel(chim);
for iCh=1:nml
    %returns cell array of feature vectors of inidividual characters
    [ftCh,ftNs] = F50_getFeaturesOfChar(chim{iCh}, iCh, draw); 
% F60____________________________________________________
% chimzy = cat(2,chimzy,chim);
% draw = 1;
% disp2(1,sprintf('#%3i Fatures:',numLpt));


    %returns array of characters
%     [char(iCh)] = F60_whichChar( iCh, ftCh, ftNs, meas, species); 
    [strLpt(iCh)] = F60_whichChar( iCh, ftCh); 
end


% print all char images in one pulp image

if draw==1
aux_imprintPulp(chim);
title(sprintf('%i=[%s]',numLpt,strLpt));
end
%% ____________________________________________________
% time measurement
iLpt = 1;
tim(iLpt)=toc();
timSum = sum(tim);


% ____________________________________________________

% ____________________________________________________
% F70_check_strLpt.m
for iCh=1:7
    %returns array of characters
%     char[iChar] = F60_assume_char(features{iChar}, iChar, innerDraw); 
% porovnani se spravnou hodnotou a vypsani uspìl neuspìl popøípadì pøidání
% do statistiky a výpoèet bodù za projekt..
end

if draw==1
% if(SI~=SX)&&(iLpt==1) % if one subplot row is not wide enaugh
if(SI~=SY)&&(iLpt==1) % if one subplot row is not wide enaugh
%    clc;
   disp2(1,sprintf('YOU should change [nSubplots] value to [%i]', SI ));
end
%    break;
end


end % function




