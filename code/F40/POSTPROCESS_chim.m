function [out] = POSTPROCESS_chim(chim)
% postprocess chim

%% remove margins = make clean chims
s = regionprops(chim,'BoundingBox');
bb = s.BoundingBox;
% bb== x,y,w,h
% to cut
x = bb(1);
y = bb(2);
w = bb(3);
h = bb(4);
fromW = ceil(x);
toW = floor(x+w);
fromH = ceil(y);
toH = floor(y+h);
chim = chim(fromH:toH, fromW:toW);

%     chim{q} = imcrop(chim{q});


ih = size(chim,1);

%% morphological


coef = 60;
R = ceil(ih / coef);
SE = strel('disk',R,4);

chim = imclose(chim, SE);
chim = imopen(chim, SE);

out = chim;


%% apriory - sides ratio is known -> rotate!!

%% try positioning
% try if centroids ar at right positions? in ih/2 and around q*iw/4 (after
% margin remove)
% try to find out the tilt - min square root y=a*centOfConvexPolyg(2,:)
%% make all numbers better
% make convex polygon of nums objects
% and than dilate
% maybe try erosion
% un-skew
% rotate
%% try to close numbers first
% find peaks in imtext vertical projection
% in more levels (hights)
% - i know how many
% make convex polygon and than dilate - as numbers could easily disappear
% dilate and try again 
% dilate and try again
% found peaks -> use them on not-dilated not-closed imtext

% thin margin

