function [ off ] = GET_offsetRedDot ( areaWanna, draw);
% create || subimage - from xinteg

% work in red channel
ch = 1;
im = areaWanna(:,:,ch); 
ih = size(im,1);
iw = size(im,2);
px = ih*iw;

% find the biggest object = red dot

im = imadjust(im);
level = graythresh(im);
bw = im2bw(im,level);

pxTresh = ceil(px / 50);
bw = bwareaopen(bw, pxTresh);

cc = bwconncomp(bw, 4);
numPixels = cellfun(@numel, cc.PixelIdxList);
[biggest, idx] = max(numPixels);
bw_notBiggest = bw;
bw_notBiggest(cc.PixelIdxList{idx}) = 0;

% cc now have only object with most pixels
redDot = bw - bw_notBiggest;

s_cent = regionprops(redDot,'Centroid');
cent = s_cent.Centroid;
% cent = x,y

s_bb = regionprops(redDot,'BoundingBox');
bb = s_bb.BoundingBox;
% bb== x,y,w,h
% to cut
x = bb(1);
w = bb(3);
off = [ceil(x), ceil(x + w)] ;

if draw==1
    im = bw;
    aux_imprintS(im,'opened bw');

    im = redDot;
    tit = sprintf('redDot');
    aux_imprintS(im,tit);
    hold on
    scatter(cent(1),cent(2), 'x');
end

end
