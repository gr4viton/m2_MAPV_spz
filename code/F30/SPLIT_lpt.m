function [lRgb,rRgb] = SPLIT_lpt(lptRgb,draw)
% returns two halfs of lpt text images

% creates color only im
lptC = MAKE_lptC(lptRgb,draw);
[found, areaWanna, areaOffset] = SEEK_redDot(lptC, draw);

% llptRgb = lptRgb;
% rlptRgb = lptRgb;
if found == 1
% redDot found
    voff = GET_offsetRedDot(areaWanna, draw);
    voff = voff + areaOffset;
else
% try to find through projections
    voff = GET_offsetCenterVoid(lptRgb,draw);
end

% split lpt
lRgb = lptRgb(:, 1:voff(1), :);
rRgb = lptRgb(:, voff(2):end, :);
    
if draw==1
    L = GET_whiteLineVRgb(lRgb);
    im = cat(2,lRgb,L,rRgb);
    aux_imprint(im, strcat('left|right') );
end