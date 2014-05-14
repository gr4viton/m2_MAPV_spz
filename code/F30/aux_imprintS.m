function out = aux_imprintS(im,tit)
%% prints to next subplot with axis tight and title
% the colormap is scaled = normalized -> values are from min(im):max(im)
% \param draw - whether to subplot informative data [1=yes]
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux_nextSubplot();
if(numel(im) >= 1)
    imshow(im,[]); title(tit); axis tight
end
end
