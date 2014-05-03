function out = aux_imhistprint(im,tit)
%% brief..

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();
F0_defPlot();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SI=SI+1; subplot2(SY,SX,SI);

for q=1:3
    hi(q,:) = imhist(im(:,:,q));
end
%     hi
%     size(hi)
%     hi = repmat(
%     aux_plotRgb(hi',strcat('h[',tit,']'));

end
