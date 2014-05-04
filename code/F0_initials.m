% F0_initials
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIAL DEFINITIONS

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXTERNAL PATHS
F0_defines();
F0_defPlot();
addpath('..\SPZ_100');

addpath('.\F30');
addpath('.\F40');

FI = 0; % initialization - only on one place - delete when OCR_LPT works
ft = struct( ...
    'point', 1, ...
    'areaSumRel', 1,...
    'areaSumAbs', 1,...
    'circumfrnc', 1,...
    'eulerNum', 1 ...
);

set(0,'defaultLineLineWidth',2)
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1]);

