function out = aux_rgb2grayMax(lptRgb, draw)
% returns grayscale image 


% each pixell channel max value is copied into all channels
% for efective thresholding of colorfull pixels

ih = size(lptRgb,1);
iw = size(lptRgb,2);

for x = 1:iw
    for y = 1:ih
        rgbMax = max(lptRgb(y,x,:));
        im(y,x,1:3) = repmat(rgbMax, [1,1,3]);
    end
end