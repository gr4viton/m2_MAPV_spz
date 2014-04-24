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
function [char] = F60_whichChar(ft, iChar, draw)
% returns array of characters
% \param features - feature vector of one character
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();

% apriory syntax =  #X# #### ?? => # number; X alfa-character

% the definition should be in F0_defines.m
% ft = struct( ...
%     'areaSumRel', 1,...
%     'areaSumAbs', 1,...
%     'circumfrnc', 1,...
%     'eulerNum', 1 ...
% );

% pravdepodobnosti jednotlivých písmen
% dat na nulu pro ty ktere ze syntaxe nemozou byt na iChar

if(iChar == 4:7)
    if(ft.point == 1)
        char = '6';
    else
        char = '9';
    end
%     if(ft.areaSumRel == 0.5)
else
    char = 'K'; 
end
%% end of function
end

