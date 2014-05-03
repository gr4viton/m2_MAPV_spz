function framed = FRAME_image(lptRgb,draw);

ih = size(lptRgb,1);
iw = size(lptRgb,2);

nCh = size(lptRgb,3);
maxx = max(max(max(lptRgb)));

to = ceil(iw/4);
strip = maxx*ones(ih,to);
strip = repmat(strip,[1,1,nCh]);
lptRgb = cat(2,strip,lptRgb,strip);

ih = size(lptRgb,1);
iw = size(lptRgb,2);

to = ceil(ih/4);
strip = zeros(to,iw);
strip = repmat(strip,[1,1,nCh]);
lptRgb = cat(1,strip,lptRgb,strip);
    
framed=lptRgb;

if draw==1
    im = lptRgb;
    aux_imprint(im,'framed')
end
    