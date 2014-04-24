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
function [ out ] = fcn_name ( in, draw )
%% brief..
% \param draw - whether to subplot informative data [1=yes]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This file is a template for new scripts
% write your code here 
% and brief of this script function in header



%% DELETE THIS IF YOU DO NOT NEED IT

% FI=FI+1; figure(FI); SI = 0; SY = 1; SX = 3;
% FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = 1; SX = 3;

% im = some_image;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('im_title')); axis tight


% if draw==1 % DRAW START
% im = SPZ_raw;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('Raw spz')); axis tight
% 
% end % DRAW END