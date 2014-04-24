function [features] = F50_create_feature_vector_for_char(im, iChar, draw)
% Returns feature vector for inputed character
% \param im - image of one character
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();

% apriory syntax =  #X# #### ?? => # number; X alfa-character

% the definition should be in F0_defines.m
features = struct( ...
    'areaSumRel', 1,...
    'areaSumAbs', 1,...
    'circumfrnc', 1,...
    'eulerNum', 1 ...
);

% features.areaSumRel = ..
% calls individual functions for computation of features

%% end of function
end

