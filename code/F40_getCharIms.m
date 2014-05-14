function [chim] = F40_getCharIms(lptBw, nCh, draw)
% returns cell array of images containging individual char images in bw
% \param lptBw - bw image with only the text
% \param nCh - probable number of chars in the image
% \param draw - whether to subplot informative data [1=yes]

%% separate chars = imchars  
chim = GET_orderedChims(lptBw, nCh, draw);
% (removes hyphens) as it takes only the biggest objects

if draw==1 
    aux_imprintPulp(chim);
end

nml = numel(chim);
for q=1:nml
    chim{q} = POSTPROCESS_chim(chim{q});
end


%% print'em
if draw==1
    
    aux_imprintPulp(chim);
%     for q=1:nCh
%         im = chim{q};
%         aux_imprintS(im,sprintf('chim[%i]',q));
%     end
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

