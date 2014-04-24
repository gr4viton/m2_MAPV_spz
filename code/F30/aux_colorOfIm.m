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
function [ colOfIm ] = aux_colorOfIm( lptRgb )
%% \retval only color of the image - grayscale part would be black

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lptGray = rgb2gray(lptRgb);
rgbGrayLpt = repmat(lptGray(:,:),[1,1,3]);
colOfIm = lptRgb - rgbGrayLpt;