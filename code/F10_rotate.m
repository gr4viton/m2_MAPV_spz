function [ SPZ_OK ] = F10_rotate( SPZ_raw, draw )
%% function for SPZ rotation correction
% input - RGB picture of cutted SPZ in RGB format (SPZ_raw)
% \param draw - whether to subplot informative data [1=yes]
% returns - RGB rotation corrected picture of SPZ (SPZ_OK)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();

SPZ_OK = rotation_settlement(SPZ_raw, draw);

%% end of function
end
