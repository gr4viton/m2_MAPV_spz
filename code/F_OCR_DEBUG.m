% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10, xnovac10, xsauer01, xvlada00 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
%             Bc. NOVACEK Petr   <xnovac10@stud.feec.vutbr.cz>
%             Bc. SAUER Petr     <xsauer01@stud.feec.vutbr.cz>
%             Bc. VLADAR Martin  <xvlada00@stud.feec.vutbr.cz>
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

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN OCR FCNS CALLING

% for debug reasons is the main for loop here - afterwards in F_OCR_all.m

nLptAll = 100; % database count

randLpt = 1; % if try on different LPTs each time
sumLpt = 5; % number of lpts to try
nSubplots = 5; % number of subplots for each lpt

FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = sumLpt; SX = nSubplots;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN FOR LOOP
for iLpt = 1:sumLpt % MAIN FOR LOOP START
%% picture aquisition
    if(randLpt == 1)
        numLpt = ceil((nLptAll-1)*rand(1) + 1); % random from <1;100>
    else
        numLpt = iLpt;
    end
    imgPath = sprintf('SPZ_%03d.bmp', numLpt);
    lpt = imread(imgPath);
% ____________________________________________________
% original plot
im = lpt;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('orig]]')); axis tight

% ____________________________________________________
% rotation
innerDraw = 0;
lpt = F10_rotate(lpt, innerDraw); figure(FI_here);

im = lpt;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('rotated]]')); axis tight

% ____________________________________________________
% background
innerDraw = 1;
lpt = F20_cut_off_bg(lpt, innerDraw); d

im = lpt;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('bg cutted]]')); axis tight

% ____________________________________________________
% F30_get_chars_only
innerDraw = 1;
lpt = F30_get_chars_only(lpt, innerDraw);

im = lpt;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('chars only]]')); axis tight

% ____________________________________________________
% F40_get_individual_chars
innerDraw = 1;
chims = F40_get_individual_chars(lpt, innerDraw); %returns cell array of char images

for iChar=1:7
    im = chims{iChar};
    SI=SI+1; subplot2(SY,SX,SI); %rewrite to write all chars in one image
    imshow(im,[]); title(strcat('im of char[',num2str(iChar),']')); axis tight
end

% ____________________________________________________
% F50_create_feature_vector_for_char
innerDraw = 1;

for iChar=1:7
    %returns cell array of feature vectors of inidividual characters
    features{iChar} = F50_create_feature_vector_for_char(chims{iChar}, iChar, innerDraw); 
end
% ____________________________________________________
% F60_assume_char.m
innerDraw = 1;

for iChar=1:7
    %returns array of characters
    char[iChar] = F60_assume_char(features{iChar}, iChar, innerDraw); 
end


% ____________________________________________________
% F70_check_strLpt.m
for iChar=1:7
    %returns array of characters
%     char[iChar] = F60_assume_char(features{iChar}, iChar, innerDraw); 
% porovnani se spravnou hodnotou a vypsani uspìl neuspìl popøípadì pøidání
% do statistiky a výpoèet bodù za projekt..
end


if(SI~=SX)&&(iLpt==1) % if one subplot row is not wide enaugh
   clc;
   disp(strcat('YOU should change [nSubplots] value to [', num2str(SI),']'));
   break;
end

end % MAIN FOR LOOP END





