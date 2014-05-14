% aux_nextSubplot

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
F0_defPlot();

global SI;
global SY;
global SX;

SI=SI+1; 
% traditional = [l->r] -> [u->d]
% subplot2(SY,SX,SI);

% better for lpt = [u->d] -> [l->r] 
SI2 = mod(SI-1,SY)*SX + ceil(SI/SY);

subplot2(SY,SX,SI2);