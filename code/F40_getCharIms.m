function [chims] = F40_getCharIms(lpt, draw)
% returns cell array of images containging individual char images in bw
% \param lpt - bw image with only the text
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
% F0_defines();

% remove hyphens - morphologycaly

ih = size(lpt,1);
iw = size(lpt,2);

chims = cell(1,7);
for i=1:7
    wFrom = ceil( (i-1) * iw/7 );
    if(i==1) wFrom = 1; end
    wTo = ceil( i * iw/7 );
    chims{i} = lpt(:, wFrom:wTo);
end

    
%% end of function
end

