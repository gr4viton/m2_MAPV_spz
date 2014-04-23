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
for iLpt = 1:sumLpt % MAIN FOR START
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
lpt = F10_rotation_settlement(lpt, innerDraw); figure(FI_here);

im = lpt;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('rotated]]')); axis tight

% ____________________________________________________
% background
innerDraw = 1;
lpt = F20_cut_off_bg(lpt, innerDraw); % cutting-off background

im = lpt;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('bg cutted]]')); axis tight

% ____________________________________________________
% rgb separation
% innerDraw = 1;
% lpt = F30_rgb_separation(lpt, innerDraw);
% 
% im = lpt;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('rgb separated]]')); axis tight
% % ____________________________________________________
% imchs = F40_fragmentation(lpt);
% 
% 
% 

if(SI~=SX)&&(iLpt==1) % if one subplot row is not wide enaugh
   clc;
   disp(strcat('YOU should change [nSubplots] value to [', num2str(SI),']'));
   break;
end

end % MAIN FOR END





