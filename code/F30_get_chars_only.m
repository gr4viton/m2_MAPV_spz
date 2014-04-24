function [SPZ_final] = F30_get_chars_only(SPZ_raw,draw)
%% function returns LPT plate without anything else then 
% grayscale? / bw? characters
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();

rgb_separation(SPZ_raw, draw);

%% end of function
end
