function [L] = GET_whiteLineVBw(lptRgb)
% returns vertical white line of the same height as lptRgb
ih = size(lptRgb,1);
wL = 2;
L = repmat(ones(ih,1),1,wL); 