% aux_subimagesAnonymous();

%% subimages
% auxilary anonnymous functions
sh = @(s) ih/s;
sw = @(s) iw/s;
shF = @(s) floor(sh(s));
swF = @(s) floor(sw(s));
shC = @(s) ceil(sh(s));
swC = @(s) ceil(sw(s));

shSub = @(y,s) ((y-1)*shF(s)+1):(y)*shF(s) ;
swSub = @(x,s) ((x-1)*swF(s)+1):(x)*swF(s) ;

chimSub = @(y,x,s) chim(shSub(y,s), swSub(x,s));
chimSub2 = @(y,sy,x,sx) chim(shSub(y,sy), swSub(x,sx));
chimCent = @(s) chimSub(ceil(s/2),ceil(s/2),s);
maxVal = 255;
sum2 = @(m) double(sum(sum(m))) / maxVal;

difSumToNum = @(im1,im2) (sum2(im1) - sum2(im2)) / double(numel(im2));
sumToNum = @(im) double(sum2(im)) / double(numel(im));

%% LEGEND
% DS - diffSumToNum - difference of sum of pixels / numpx
% % - most often the subimage is divided only in one axe -->
% % ud - up to down where image is divided into halves
% % lr - left to right where image is divided into halves
% % 1u7d7 - first seventh of image to last seventh - in vertical
% % 1l7r7 - first seventh of image to last seventh - in horizontal
% S2N - sumToNum - sum of pixels / numpx
% % ABCD = i.e 1911 
% % % 19 take first ninth in height 
% % % 11 take first 'oneth' in width - whole width
% % AyB = i.e 1y9
% % % take first ninth in height - y axe
% % % this is the same as 1911
% % cyAcxB = center of division by A in y, and center of div by B in x
% % cA = center after division by A in both axes