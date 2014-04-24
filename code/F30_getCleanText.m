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
function [imTextBw] = F30_getCleanText(lpt, draw)
%% function returns LPT plate without anything else then text in bw
% \param lpt - rgb image
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();

% rotation
% del frame
% thin margin
imTextBw = lpt;

%% end of function
end