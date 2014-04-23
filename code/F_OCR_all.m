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
% \brief      This script executes our OCR function over all LPTs
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();
FI = 0; % initialization - only on one place

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEANING
close all; clear; clc;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumLpt = 10; % number of lpts to try
nRowImages = 7; % number of subplots for each lpt

FI=FI+1; figure(FI); SI = 0; SY = 1; SX = nRowImages;

% Calls OCR function on individual plates
for iLpt = 1:sumLpt
    imgPath = sprintf('SPZ_%03d.bmp', iLpt);
    lpt = imread(imgPath);
    stringLpt = F0_OCR_LPT(lpt, iLpt);
    
    im = lpt;
    SI=SI+1; subplot2(SY,SX,SI);
    imshow(im,[]); title(strcat(stringLpt)); axis tight
end







