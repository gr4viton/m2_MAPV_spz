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
% \brief      Basic definitions needed in almost all scripts
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXTERNAL PATHS
addpath(genpath('.\subtightplot'));
addpath(genpath('..\SPZ_100'));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION BINDING
% subtightplot
subplot2 = @(m,n,p) subtightplot (m, n, p, [0.05 0.01], [0.05 0.01], [0.01 0.01]);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLOBAL VARIABLES
global FI; % for storing of global figure index counter
global SI;
global SY;
global SX;
