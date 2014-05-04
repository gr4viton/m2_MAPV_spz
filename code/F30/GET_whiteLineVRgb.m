function [L] = GET_whiteLineVRgb(lptRgb)
% returns vertical white line of the same height as lptRgb
ih = size(lptRgb,1);
wL = 2;
chL = repmat(255*ones(ih,1),1,wL); 
L = cat(3,chL, chL, chL);