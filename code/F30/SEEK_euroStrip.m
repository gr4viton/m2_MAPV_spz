function out_sLptC = SEEK_euroStrip(lptC, sLptC, draw)
%% searches for euro strip

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lptRgb = lptC;

ih = sLptC.ih;
iw = sLptC.iw;
% pxs = ih*iw;
ch = 3; % channel

sLptC.off_euroTo = ceil(iw/sLptC.off_euroTo_div);
sLptC.off_euroFrom = ceil(sLptC.off_euroTo / sLptC.off_euroFrom_div) ;
% search for blue eurostrip

sLptC.area_euro = lptC(:, sLptC.off_euroFrom:sLptC.off_euroTo, :);
% find out if eurostrip was found

% % sum of blue channel related to sum of g and red
maxRgb = max(max(sLptC.area_euro));
sLptC.minValBlue_euro = 40;
condMaxRgb = (maxRgb(3) > sLptC.minValBlue_euro);

% if(sum of blue) in different strip is not the same as in this strip
sumEuro = sum(sum(sLptC.area_euro(:,:,ch)));
% which strip
from = 2*sLptC.off_euroTo;
to = 3*sLptC.off_euroTo;
area_nEuro = lptC(:, from:to, ch);
sumNEuro = sum(sum(area_nEuro));

% [coef] = times greaterThanNotPresent
coef = 3; 
condNEuro = sumEuro > coef*sumNEuro;

sLptC.found_euro = 0;
if or(condNEuro,condMaxRgb)
% it's not noise
%     sumRgb = sum(sum(sLptC.area_euro))/pxs
%     if sumRgb(3) > coef*sumRgb(2) && sumRgb(3) > coef*sumRgb(1)
%     % there are more blue than other colors 
        % % --> bad what about blue-lower-strip but no eurostrip
%         if maxRgb(3) > maxRgb(2) && maxRgb(3) > maxRgb(1)
    sLptC.found_euro = 1;
%         end
%     end
end
% disp(num2str(sLptC.found_euro ));

% print'em
if draw == 1
    im = sLptC.area_euro;
    % tit = sprintf('%0.2f|%0.2f|%0.2f',maxRgb);
    tit = vif( sLptC.found_euro == 1, 42, 0) ;
    aux_imprint4ch(im,tit);
end

out_sLptC = sLptC;
end


