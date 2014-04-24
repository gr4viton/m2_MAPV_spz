function [char] = F60_assume_char(features, iChar, draw)
% returns array of characters
% \param features - feature vector of one character
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();

% apriory syntax =  #X# #### ?? => # number; X alfa-character

% the definition should be in F0_defines.m
% features = struct( ...
%     'areaSumRel', 1,...
%     'areaSumAbs', 1,...
%     'circumfrnc', 1,...
%     'eulerNum', 1 ...
% );

if(iChar == 4:7)
    if(features.areaSumRel == 0.5)

        char = '6';
    end
end
%% end of function
end

