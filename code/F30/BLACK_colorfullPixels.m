function lptBlackedRgb = BLACK_colorfullPixels(lptRgb,draw)
% returns rgb image with all the colorfull pixels darken - or black 

ih = size(lptRgb,1);
iw = size(lptRgb,2);
px = ih*iw;

lptHsv = rgb2hsv(lptRgb);

% use saturation channel
sat = lptHsv(:,:,2);
satO = sat;

% morph over sat
R = ceil(ih / 30);
% SE = strel('disk',R,4);
SE = strel('disk',R,8);
sat(:,:,1) = imclose(sat, SE);


% normalize
sat3 = 255*sat/ max(max(sat));
sat3 = uint8( repmat(sat3,[1 1 3]) );

% best
lptBlackedRgb = 2*lptRgb - sat3;

if draw==1
    im = satO;
    aux_imprintS(im,'sat')
    im = sat;
    aux_imprintS(im,'sat closed')
    im = sat3;
    aux_imprintS(im,'sat3')
    im = lptBlackedRgb;
    aux_imprint(im,'2rgb-sat3 = Blacked') 
end 

%% not as good as the used
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
