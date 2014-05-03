function [ colOfIm ] = aux_colorOfIm( lptRgb, draw )
%% \retval only color of the image - grayscale part would be black

lptGray = rgb2gray(lptRgb);
rgbGrayLpt = repmat(lptGray(:,:),[1,1,3]);
colOfIm = lptRgb - rgbGrayLpt;

if draw==1
    im = colOfIm; 
    aux_imprint(im, strcat('colOfLpt'));
end