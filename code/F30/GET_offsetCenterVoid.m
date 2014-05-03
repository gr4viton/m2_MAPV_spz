function voff = GET_offsetCenterVoid(lptRgb, draw)
% voff = [right border of left part, left border of right part]

% lol it is sufficient to split it in half 
% -> it always suits the purpose on our database.. afaik

ih = size(lptRgb,1);
iw = size(lptRgb,2);

half = iw/2;
voff = [floor(half), ceil(half)];