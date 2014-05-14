function out = aux_imprintRange(im,tit,rng)
%% prints to next subplot with axis tight and title
% the colormap is scaled = normalized -> values are from min(im):max(im)
% \param draw - whether to subplot informative data [1=yes]
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux_nextSubplot();
if(numel(im) >= 1)
    imshow(im,rng); title(tit); 
%     axis tight
ywanna = 100;
mag = ywanna / size(im,1);
 imshow(im,rng,'InitialMagnification',mag); title(tit); axis tight
pause(0.03)
% yy = [0 100];
%   imshow(im,rng,'Ydata',yy); title(tit); axis tight
end
end
