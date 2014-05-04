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

% get biggest object
[bw_biggest, cc] = GET_biggest(bw);
redDot = bw_biggest;

%% individual region properties
s_cent = regionprops(redDot,'Centroid');
cent = s_cent.Centroid;
% cent = x,y

s_bb = regionprops(redDot,'BoundingBox');
bb = s_bb.BoundingBox;
% bb== x,y,w,h
% to cut
xoff = 3; % empirical 
x = bb(1);
w = bb(3);
off = [floor(x-xoff), ceil(x + w)] ;

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
