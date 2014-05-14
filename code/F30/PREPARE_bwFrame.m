function [lptBw, voffs] = PREPARE_bwFrame(lptRgb,draw)
% voffs = [toH, toW, ih, iw] 
% - toW is aplicated 1st to sides, toH second to up,dn


%% adjust
lptG = rgb2gray(lptRgb );
lptG = imadjust(lptG);

%% gauss

flt = fspecial('gauss',2,2);
lptG = imfilter(lptG,flt);

% imdilate(
%% median / average filtering
% coef = 4;
% 
% C = 1.3;
% coef = 2;
% ws = ceil(size(lptG,1) / coef);
% back = imfilter(lptG,fspecial('disk',ws),'replicate');
% % im = back;
% % aux_imprintS(im,'back');
% 
% coef = 40;
% ws = ceil(size(lptG,1) / coef);
% averg = imfilter(lptG,fspecial('disk',ws),'replicate');
% % im = averg;
% % aux_imprintS(im,'averg');
% 
% avg = imcomplement(back - averg - C);
% % im = avg;
% % aux_imprintS(im,'avg');
% 
% lptG = avg;
% % oblast 11x11px - stø hodnota + 1 pokud malý rozptyl??
% % med = medfilt2(im,[ws ws]);??


%% thershold
% level from hsv(val)??
% lptHsv = rgb2hsv(lptRgb);
% level = graythresh(lptHsv(:,:,2));

level = graythresh(lptG); % or otherwise
% coef = 1.2;
% level=level*coef;
bw = im2bw(lptG,level);
% im = bw;
% aux_imprintS(im,'graylevel');

%% add black and white frame around
[lptBw, voffs] = FRAME_image(bw,0);
    lptBw1=lptBw;
    
%% morph - open then close better
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
    aux_imprintS(im,'graylevel')
    
    im = lptBw1;
    aux_imprintS(im,'framed')
% 
%     im = lptBw2;
%     aux_imprintS(im,'opening')
%     im = lptBw;
%     aux_imprintS(im,'closed')
end


end