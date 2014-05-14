function [ prj ] = aux_projectDown ( im, normalize )
%% projects in down direction = sum of pixels of columns
% prj - projection with [r],[g],[b] and [s] sum of [rgb] channels channel

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();


prj = sum(im,1); % rgb channels
prj(:,:,4) = sum(prj,3); % sum channel

if normalize==1
    prj = aux_projNorm(prj);
end