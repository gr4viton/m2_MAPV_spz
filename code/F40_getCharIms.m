function [chim] = F40_getCharIms(lptBw, nCh, draw)
% returns cell array of images containging individual char images in bw
% \param lptBw - bw image with only the text
% \param nCh - probable number of chars in the image
% \param draw - whether to subplot informative data [1=yes]

%% separate chars = imchars  
chim = GET_orderedChims(lptBw, nCh, draw);
% (removes hyphens) as it takes only the biggest objects

 
%% try positioning
% try if centroids ar at right positions? in ih/2 and around q*iw/4 (after
% margin remove)
% try to find out the tilt - min square root y=a*centOfConvexPolyg(2,:)
%% make all numbers better
% make convex polygon of nums objects
% and than dilate
% maybe try erosion
% un-skew
% rotate

%% apriory - sides ratio is known -> rotate!!

%% remove margins = make clean chims
for q=1:nCh
    s = regionprops(chim{q},'BoundingBox');
    bb = s.BoundingBox;
    % bb== x,y,w,h
    % to cut
    x = bb(1);
    y = bb(2);
    w = bb(3);
    h = bb(4);
    fromW = floor(x);
    toW = ceil(x+w);
    fromH = floor(y);
    toH = ceil(y+h);
    chim{q} = chim{q}(fromH:toH, fromW:toW);
end

%% try to close numbers first
% find peaks in imtext vertical projection
% in more levels (hights)
% - i know how many
% make convex polygon and than dilate - as numbers could easily disappear
% dilate and try again 
% dilate and try again
% found peaks -> use them on not-dilated not-closed imtext

% thin margin




%% print'em
if draw==1
    for q=1:nCh
        im = chim{q};
        aux_imprintS(im,sprintf('chim[%i]',q));
    end
end

    
%% end of function
end



%% only slicing
% ih = size(lpt,1);
% iw = size(lpt,2);
% 
% chims = cell(1,7);
% for i=1:7
%     wFrom = ceil( (i-1) * iw/7 );
%     if(i==1) wFrom = 1; end
%     wTo = ceil( i * iw/7 );
%     chims{i} = lpt(:, wFrom:wTo);
% end

