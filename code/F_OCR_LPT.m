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
function [stringLPT] = F_OCR_LPT ( lpt, iLpt )
% Calls individual functions to OCR the LPT string from image [im]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN OCR FCNS CALLING

innerDraw = 0;
% ____________________________________________________
lpt = F10_rotation_settlement(lpt, innerDraw); figure(FI_here);
% ____________________________________________________
lpt = F20_cut_off_bg(lpt, innerDraw); 
% ____________________________________________________
lpt = F30_rgb_separation(lpt, innerDraw);
% ____________________________________________________
imchs = F40_fragmentation(lpt);
% ____________________________________________________
% ...
% ____________________________________________________
chars = F50_GUESS_charFromImage(imchs);
% ____________________________________________________
stringLPT = chars;

end % function




