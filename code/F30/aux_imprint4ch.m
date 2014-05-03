function out = aux_imprint4ch(in,tit)
%% prints 4 channels next to each other to one image into next subplot 
% inserts white line between channels
% the colormap is not-normalized -> values are from 0:255
% \param draw - whether to subplot informative data [1=yes]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux_nextSubplot();
% create rgb from individual channels

ch = @(q) cat(3,in(:,:,q),in(:,:,q),in(:,:,q));

% q = 1;
% im(:,:,1:3) = ch(q)
% add individual channels next to each other 

hi = size(in,1);
% wi = size(in,2);
wL = 2;
chL = repmat(255*ones(hi,1),1,wL); %=imLineChannel
L = cat(3,chL, chL, chL); %=imLineRgb
im = cat(2,ch(1),L,ch(2),L,ch(3),L,in);

% add rgb channel to the end
imshow(im,[0,255]); title(tit); axis tight
end
