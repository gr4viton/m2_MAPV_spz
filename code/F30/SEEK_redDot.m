function [found, areaWanna, areaOffset] = SEEK_redDot( lptC, draw)
%% searches for red dot


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create area wher to search for red dot
ih = size(lptC,1);
iw = size(lptC,2);
iCh = 1; % channel red

%% bounds
% w - 
tenth = iw/10;
from = ceil(tenth*3) ;
to = ceil(tenth*6);
% h - higher half
toW = ceil(ih/2);

areaOffset = from;

%% cut
areaWanna = lptC(1:toW, from:to, :);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find out if there is a red spot was found

%% sum of blue channel related to sum of g and red
maxRgb = max(max(areaWanna));
minRed = 40;
condMaxRgb = (maxRgb(iCh) > minRed);

%% if(sum of red) in different strip is not the same as in this strip
% different strip should probably not contain any red color
sumWanna = sum(sum(areaWanna(:,:,iCh)));
% different (void) strip 
% % w - <4;5>/5
width = to-from;
from = to;
to = from + width;
% % h - <0;1>/2
toW = ceil(ih/2);
areaNot = lptC(1:toW, from:to, :);
sumNot = sum(sum(areaNot));

% [coef] = times greaterThanNotPresent
coef = 3; 
condNotNoise = sumWanna > coef*sumNot ;

%% infere 
found = 0;
if or(condNotNoise, condMaxRgb)
   found = 1;
end

%% print'em
if draw == 1
    im = areaWanna;
    tit = vif( found == 1, 42, 0) ;
    aux_imprint4ch(im,tit);
end

end


