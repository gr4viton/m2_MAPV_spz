function [lptBw, voffs] = PREPARE_bwFrame(lptRgb,draw)
% voffs = [toH, toW, ih, iw] 
% - toW is aplicated 1st to sides, toH second to up,dn

% thresh
lptG = rgb2gray(lptRgb );
lptG = imadjust(lptG);

% level from hsv(val)??
lptHsv = rgb2hsv(lptRgb);
level = graythresh(lptHsv(:,:,2));

level = graythresh(lptG); % or otherwise
% coef = 1.2;
% level=level*coef;
bw = im2bw(lptG,level);
    
% add black and white frame around
[lptBw, voffs] = FRAME_image(bw,0);
    lptBw1=lptBw;
% morph - open then close better
ih = size(lptRgb,1);
iw = size(lptRgb,2);

%% adjust frame by morph ops
% 
% % do morph opening
% R = ceil(ih / 40);
% SE = strel('disk',R,4);
% lptBw = imopen(lptBw, SE);
%     lptBw2=lptBw;
%     
% % do morph closing
% R = ceil(ih / 40);
% SE = strel('disk',R,4);
% lptBw = imclose(lptBw, SE);

if draw==1
    im = lptG;
    aux_imprint(im,'adjusted')
    
    im = bw;
    aux_imprintS(im,'bwFreshlyThresholded')
    
    im = lptBw1;
    aux_imprintS(im,'framed')
% 
%     im = lptBw2;
%     aux_imprintS(im,'opening')
%     im = lptBw;
%     aux_imprintS(im,'closed')
end


end