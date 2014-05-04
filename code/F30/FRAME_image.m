function [framedBw, voffs] = FRAME_image(lptRgb,draw);
% inject (add) black and white frame around image
% voffs = [toH, toW, ih, iw] 
% - toW is aplicated 1st to sides, toH second to up,dn

ih = size(lptRgb,1);
iw = size(lptRgb,2);

voffs(3:4) = [ih,iw];

nCh = size(lptRgb,3);
maxx = max(max(max(lptRgb)));

to = ceil(iw/4);
strip = maxx*ones(ih,to);
strip = repmat(strip,[1,1,nCh]);
lptRgb = cat(2,strip,lptRgb,strip);

voffs(2) = to;

ih = size(lptRgb,1);
iw = size(lptRgb,2);

to = ceil(ih/4);
strip = zeros(to,iw);
strip = repmat(strip,[1,1,nCh]);
lptRgb = cat(1,strip,lptRgb,strip);
    
framedBw=lptRgb;

voffs(1) = to;

if draw==1
    im = lptRgb;
    aux_imprint(im,'framed')
end
    