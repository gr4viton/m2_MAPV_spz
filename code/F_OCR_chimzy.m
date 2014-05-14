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
addpath('.\debug');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp2_level = 3; % how deep to display on console
nLptAll = 100; % database count

whichLpt = 2;    % if try on different LPTs each time
% [1] - random, [2] - group
sumLpt = 5;     % number of lpts to try
nSubplots = 11;  % number of subplots for each lpt
was = [-1];      % indexes of OCRed lpts

gpLpt = [67 41 40 61];
if whichLpt  == 2
    sumLpt = numel(gpLpt);
end
% traditional = [l->r] -> [u->d]
% FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = sumLpt; SX = nSubplots;

% all the [chim]s of processed lpts
chimzy = [];


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% chimzy = cat(2,chimzy,chim);

% load('chimzy.mat')
%% load images from chimzy dir
done = 0;
    imgPath = 'chimzy\'; 
    dCell = dir(strcat(imgPath,'*.png'));    
for iA = 1:length(dCell) 
    chimzy{iA} = imread(strcat(imgPath, dCell(iA).name)); 
    should{iA} = dCell(iA).name(1);
end
chim = chimzy;


numAll = numel(chimzy);
% numAll = 15;

sh = @(s) numAll/s;
shF = @(s) floor(sh(s));
shC = @(s) ceil(sh(s));

shSub = @(y,s) ((y-1)*shF(s)+1):(y)*shF(s) ;

draw = 1;
% char = '       ';
s = 3;


% better for lpt = [u->d] -> [l->r] 
FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = 1; SX = 1;
set(gcf,'units','normalized','outerposition',[0 0 1 1])

SY = ceil(numAll/(s)) + 1;

SX = 4;

for iChim = 1:ceil(numAll/s)
    a = 1;
    char = '?';
    intv = shSub(iChim,s);
    for iCh = intv
        %returns array of characters
        [char(a), P(:,1:2,iCh)] = F60_whichChar( chim{iCh}, should{iCh}, draw); 
        a=a+1;
%         nam = sprintf('chim\\num_%02i.png',iCh);
%         im = chim{iCh};
%         imwrite(im,nam,'png');
    end
    % print all char images in one pulp image
    aux_imprintPulpX(chim,[intv(1),intv(end)]);
    title(sprintf('[%i:%i] = %s',intv(1),intv(end),char));
    disp2(1,sprintf('LPTstr = >>>[%s]<<<',char));    
    
    SY = floor(numAll/s)+1; 
end

% save('chimzy.mat','chim')

%% ____________________________________________________
% time measurement
% tim(iLpt)=toc();
% endIn = mean(tim(1:iLpt)) * (sumLpt - iLpt);
% timSum = sum(tim);
% timEnd = endIn + timSum;

% disp(sprintf('This lpt took [%.2f]s, estimated end in [%.2f]s',...
%     tim(iLpt),endIn));
% disp(sprintf('#%3i [%.2f]s, passed [%.2f]s = [%.1f]%%, end in [%.2f]s',...
%     numLpt, tim(iLpt),timSum, timSum/timEnd*100, endIn));
% disp2(1,sprintf('#%3i took [%.2f]s, [%.2f/%.2f]s == [%.1f]%% | endin''[%.2f]s',...
%     numLpt, tim(iLpt),timSum, timEnd, timSum/timEnd*100, -endIn));
% disp2(1,sprintf('LPTstr = >>>[%s]<<<',char));

% end