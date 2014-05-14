function [bw_biggest, cc] = GET_convexBiggest(bw)
% returns object with biggest convex area from bw-image, and conncomposite of bw

cc = bwconncomp(bw, 4);
st = regionprops(cc,'Area','ConvexArea');


% indexes of the biggest convex area object
[biggest, idxConv] = max([st.ConvexArea]);

% indexes of the biggest area object
[biggest, idxBig] = max([st.Area]);


idx = idxConv;
%% if indexes of convexBiggest & biggest are not the same -> take the biggest
if numel(idxConv) ~= numel(idxBig)
%    if idxConv ~= idxBig
     idx = idxBig;
%    end
end

%% try if the centroid is near center vertical

bw_notBiggest = bw;
% delete the biggest
bw_notBiggest(cc.PixelIdxList{idx}) = 0;

% cc now have only object with most pixels
bw_biggest = bw - bw_notBiggest;

%% add everything in bounding box of the biggest
% 
% st = regionprops(bw_biggest,'BoundingBox');
% bb = ceil(st.BoundingBox);
% % black
% bw_biggest_BBarea = zeros(size(bw));
% bw_biggest_BBarea(bb(1):bb(3), bb(2):bb(4)) = bw( bb(1):bb(3), bb(2):bb(4) );
% 
% bw_biggest = bw_biggest + bw_biggest_BBarea;