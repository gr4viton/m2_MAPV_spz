function lptRgb = REMOVE_horizontalMargins( lptRgb, draw)
%% remove horizontal margin = vertical left/right-strips

% creates color only im
lptC = MAKE_lptC(lptRgb,draw);
% morph - del noise in channels only for euro seek
lptC = morph_open(lptC,draw);


sLptC = struct( ...
    'ih', size(lptRgb,1),...
    'iw', size(lptRgb,2),...
    'off_euroTo_div', 7,...
    'off_euroTo', 0,...
    'off_euroFrom_div', 100,...
    'off_euroFrom', 0,...
    'area_euro', 0,...
    'area_euroEd', 0,...
    'found_euro', 0,...
    'eulerNum', 1 ...
);

sLptC = SEEK_euroStrip(lptC, sLptC, draw);

if sLptC.found_euro == 1 
% found blue eurostrip
    % get the offset
    euroRight = GET_frameEuroOffset(lptC, sLptC, draw);
    % cut the euroStrip
    lptRgb = lptRgb(:,euroRight:end,:);

    % % % find lower line - cut of
    % % % find upper line - cut of 
    % % % now we have eurostrip-high-lpt
    % % % % in case of low blue frame - it can be under eurostrip to
    % % % % % from yinteg of eurostrip-high-lpt find lower-blue-strip = peaks
    % % % % % cut lower-blue-strip from eurostrip-high-lpt 

else % no blue eurostrip

% % from yinteg of eurostrip-high-image find lower-r/g/b-strip = peaks
% % if - found lower-r/g/b-strip 
% % % cut lower-r/g/b-strip from lpt
% % else - no lower-r/g/b-strip = hardest
% % % if - found g/r-disc --> not sure if to try 
% % % % --> maybe get stderr from rotation section and then decide
% % % else - no g/r-disc / do not try to find g/r-disc 
% % % % if found houghlines = 0deg, long enaught
% % % % 
end


% % % % % % % this would bee better than from bw -> threshing..
% next to find left/right-strips
% % try it from xintegColorless(4) = sum of r,g,b channels
% % % try it from xintegColorless(4) but not from whole image 
% % % --> but from first/last rows - as vertical margin shoud be zero
% % % diff of xintegCL(4)-f/l-rows through different rows
% % % % find first and last peaks with most repeatitions

if draw==1
    im = lptRgb ;
    tit = sprintf('remove left');
    aux_imprintS(im,tit);
end

%% remove right margin
lptRgb = REMOVE_rightMargin(lptRgb);


if draw==1
    im = lptRgb ;
    tit = sprintf('& remove right');
    aux_imprintS(im,tit);
end

