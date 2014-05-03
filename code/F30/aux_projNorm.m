function [ prjNorm ] = aux_projNorm ( prj )
%% normalize all channels of [proj] projection

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nChan = size(prj,3);
% size(prj)
for q=1:nChan
    prjNorm(:,:,q) = prj(:,:,q) ./ max(prj(:,:,q));
end

% theoretically good overview would be with normalization 
% % - not each channel to its channel max
% % + but each channel to sum channel max
% NOPE % % + or  each channel indiv values to sum channel indiv val = noisy