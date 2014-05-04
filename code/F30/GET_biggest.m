function [bw_biggest, cc] = GET_biggest(bw)
% returns biggest object bw-image, and conncomposite of bw

cc = bwconncomp(bw, 4);
numPixels = cellfun(@numel, cc.PixelIdxList);
[biggest, idx] = max(numPixels);
bw_notBiggest = bw;
bw_notBiggest(cc.PixelIdxList{idx}) = 0;

% cc now have only object with most pixels
bw_biggest = bw - bw_notBiggest;
