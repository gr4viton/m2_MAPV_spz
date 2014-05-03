function lptRgb = REMOVE_rightMargin(lptRgb)
%% remove right margin

% statisticly - sufficient for our database
% only slovak spz is not good with it
ih = size(lptRgb,1);
iw = size(lptRgb,2);
sc = 12;
to = ceil((sc-1)*iw/sc);
lptRgb = lptRgb(:, 1:to, :);
