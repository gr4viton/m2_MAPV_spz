function [feat] = F50_getFeaturesOfChar(im, iChar, draw)
% Returns feature vector for inputed character
% \param ft - feature vector
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
% F0_defines();
global ft;

% apriory syntax =  #X# #### ?? => # number; X alfa-character

% the definition should be in F0_defines.m

%% B vs 8
% mirroring
% left half center px count vs right..

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

