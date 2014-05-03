function lptC = MAKE_lptC(lptRgb,draw)
% creates and preprocess image of colors only from lptRgb 
% gray would be black


% white balance
lptRgb = whitebalance(lptRgb);

% get colors of the picture only - 50 shades of gray will be black
% [lptC] = only color from lpt 
lptC = aux_colorOfIm(lptRgb,draw);

% ____________________________________________________
% morphological operations 
% close - grdots and eurostrip
lptC = morph_close(lptC,draw);