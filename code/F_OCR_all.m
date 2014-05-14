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

%% load right strings if exists
nam = 'strLptGood.mat';
if exist(nam, 'file');
    load(nam);
end

%% OCR
sumLpt = 100; % number of lpts to try
% Calls OCR function on individual plates
RECOGNIZED_LPTS = {};
timSum = 0;
nGood = 0;
nBad = 0;
for iLpt = 1:sumLpt
    tic();
    %% picture acquisition
    imgPath = sprintf('SPZ_%03d.bmp', iLpt);
    lptRgb = imread(imgPath);
    
    %% ocr function
    draw = 0;
    stringLpt = F_OCR_LPT(lptRgb, draw);
    RECOGNIZED_LPTS{iLpt} = stringLpt;
%% time measurement and display
    timAct = toc();
    timSum = timSum+timAct;
    if strcmpi(stringLpt,strLptGood{iLpt})
        nGood = nGood+1;
        add = 'OK';
    else
        nBad = nBad+1;
        add = 'WRONG!';
    end
    endIn = timSum/iLpt * (sumLpt-iLpt);
    disp(sprintf('#%03i/%03i|endIn[%.1f]s >>>[%s]<<< ?= [%s] =(%.0f%%)=> %s',...
        iLpt,sumLpt,endIn,stringLpt,strLptGood{iLpt},nGood/iLpt*100,add));
end

disp(sprintf('Total time: [%.2f]s => mean: [%.2f]s',timSum, timSum/sumLpt));
disp(sprintf('[%i] good | [%i] bad = [%.2f]pts',...
    nGood, nBad, nGood/sumLpt*16));






