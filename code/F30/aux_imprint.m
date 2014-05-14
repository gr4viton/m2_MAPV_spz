function out = aux_imprint(im,tit)
%% prints to next subplot with axis tight and title
% the colormap is not-normalized -> values are from 0:255
% \param draw - whether to subplot informative data [1=yes]
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% aux_nextSubplot();
rng = [0,255];
aux_imprintRange(im,tit,rng);

end
