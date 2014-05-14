% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10, xnovac10, xsauer01, xvlada00 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
% \date		  15-04-2014
% \brief      This script executes our OCR function over all LPTs
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEANING
close all; clear; clc;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALIZATION
global disp2_level ;
disp2_level = 1; % how deep to display on console

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumLpt = 10; % number of lpts to try
% Calls OCR function on individual plates
RECOGNIZED_LPTS = {};
for iLpt = 1:sumLpt
    imgPath = sprintf('SPZ_%03d.bmp', iLpt);
    lptRgb = imread(imgPath);
    
    draw = 0;
    stringLpt = F_OCR_LPT(lptRgb, draw);
    RECOGNIZED_LPTS{iLpt} = stringLpt;
    disp(sprintf('#%i = >>>[%s]<<<',iLpt,stringLpt));
end







