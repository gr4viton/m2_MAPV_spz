function [ off ] = GET_frameEuroOffset ( lptC,sLptC, draw);
% create || subimage - from xinteg

% work in blue channel
im = sLptC.area_euro(:,:,3); 
ih = size(im,1);
iw = size(im,2);
px = ih*iw;
% find the biggest object = eurostrip

im = imadjust(im);
level = graythresh(im);
bw = im2bw(im,level);

pxTresh = ceil(px / 20);
bw = bwareaopen(bw, pxTresh);

% get biggest object
[bw_biggest, cc] = GET_biggest(bw);
euro = bw_biggest;

% take only uppar part - ignore lower blue strip
euro = euro(1:ceil(end/2),:);

%% individual region properties
s_ori = regionprops(euro,'Orientation');
ori = s_ori.Orientation;
s_bb = regionprops(euro,'BoundingBox');
bb = s_bb.BoundingBox;
% bb== x,y,w,h
% to cut
plus = sLptC.iw/50;
euroRight = ceil(bb(1) + bb(3))+ plus;

% if( abs( abs(ori) - 90 ) <= 7 )
% % if abs( orientation ) in interval +- 7deg around 90
% % ignore skewness
%     % x + width
%     euroRight = ceil(bb(1) + bb(3))+ plus;
% else
% % too skewed to ignore it
% % cut it between upper and lower right corners
% s_ex = regionprops(euro,'Extrema');
%     % top right edge and right bottom corner
%     euroRight = ceil(mean([s_ex.Extrema(2), s_ex.Extrema(4)]));
% end

if draw==1
    im = bw;
    aux_imprintS(im,'opened bw');

    im = euro;
    tit = sprintf('euro, ori=%.2f', ori);
    aux_imprintS(im,tit);
end
off = ceil(euroRight);
end
