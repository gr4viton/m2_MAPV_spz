function voff = GET_offsetCenterVoid(lptRgb, draw)
% voff = [right border of left part, left border of right part]

% lol it is sufficient to split it in half 
% -> it always suits the purpose on our database.. afaik

ih = size(lptRgb,1);
iw = size(lptRgb,2);

half = iw/2;
voff = [floor(half), ceil(half)];


%% if not sufficient
% try it from xintegColorless(4) = sum of r,g,b channels
% % = diff of peak from center 
% % searching for edge down and up not so close togeather as others!
