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
function [feat] = F50_getFeaturesOfChar(im, iChar, draw)
% Returns feature vector for inputed character
% \param ft - feature vector
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();
global ft;

% apriory syntax =  #X# #### ?? => # number; X alfa-character

% the definition should be in F0_defines.m


% okraj
% hlavní poloosa - natoèit
% majoritni uhel hlavní (jenom možná)

% ft.point = im(1,1);
% features.areaSumRel = ..
% calls individual functions for computation of features

feat = ft;

% feat = 1;
%% end of function
end

