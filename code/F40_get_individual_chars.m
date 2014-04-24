function [chims] = F40_get_individual_chars(SPZ_raw, draw)
% returns cell array of images containging individual chars
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();

chims = fragmentation(SPZ_raw, draw);
    
%% end of function
end

