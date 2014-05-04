function out = aux_imprint4ch(inRgb,tit)
%% prints 4 channels next to each other to one image into next subplot 
% inserts white line between channels
% the colormap is not-normalized -> values are from 0:255
% \param draw - whether to subplot informative data [1=yes]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux_nextSubplot();
% create rgb from individual channels

ch = @(q) cat(3,inRgb(:,:,q),inRgb(:,:,q),inRgb(:,:,q));

% q = 1;
% im(:,:,1:3) = ch(q)
% add individual channels next to each other 

% line
L = GET_whiteLineVRgb(inRgb);

% add rgb channel to the end
im = cat(2,ch(1),L,ch(2),L,ch(3),L,inRgb);

aux_imprintS(im,tit)
end
