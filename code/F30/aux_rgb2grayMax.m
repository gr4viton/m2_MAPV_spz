function out = aux_rgb2grayMax(lptRgb, draw)
% returns grayscale image 

ih = size(lptRgb,1);
iw = size(lptRgb,2);
px = ih*iw;

lptHsv = rgb2hsv(lptRgb);

sat = lptHsv(:,:,2);
satO = sat;

R = ceil(ih / 30);
SE = strel('disk',R,4);
sat(:,:,1) = imclose(sat, SE);


% normalize
sat3 = 255*sat/ max(max(sat));
sat3 = uint8( repmat(sat3,[1 1 3]) );

% best
out = 2*lptRgb - sat3;

if draw==1
    im = satO;
    aux_imprintS(im,'sat')
    im = sat;
    aux_imprintS(im,'sat closed')
    im = sat3;
    aux_imprintS(im,'sat3')
    im = out;
    aux_imprint(im,'2rgb-sat3') 
end 

% im = lptRgb - sat3;
% aux_imprint(im,'rgb-sat3')
% 
% im = 2*(lptRgb - sat3);
% aux_imprint(im,'rgb-sat3')
% 
% 
% 
% im = lptRgb + sat3;
% aux_imprint(im,'rgb+sat3')
% 
% im = 2*lptRgb + sat3;
% aux_imprint(im,'2rgb+sat3')


% % each pixell channel max value is copied into all channels
% % for efective thresholding of colorfull pixels
% 
% ih = size(lptRgb,1);
% iw = size(lptRgb,2);
% 
% for x = 1:iw
%     for y = 1:ih
%         rgbMax = max(lptRgb(y,x,:));
%         im(y,x,1:3) = repmat(rgbMax, [1,1,3]);
%     end
% end