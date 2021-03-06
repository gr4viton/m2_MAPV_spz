function chim = GET_orderedChims(lptBw,nCh,draw)
% returns [nNum] ordered biggest object in inverted lptBw

%% find nNum biggest objects
lptWb = imcomplement(lptBw);
% [chimNO] - not ordered
for q=1:nCh
    [chimNO{q}, cc] = GET_convexBiggest(lptWb);
%     [chimNO{q}, cc] = GET_biggest(lptWb);
    lptWb = lptWb - chimNO{q};
end

%% order the numbers
% individual region properties
for q=1:nCh
    s = regionprops(chimNO{q},'Centroid');
%     s.Centroid
    if isempty(s)
        break
    end
    cent(1:2,q) = s.Centroid;
    cent(3,q) = q;
    % cent = x,y
end

col = 1; %=x
sorted = sortrows(cent',col);
sortIs = sorted(:,3);

nml = numel(sortIs);
for q=1:nml
    chim{q} = chimNO{sortIs(q)};
end

%% print'em
if draw == 1; 
    for q=1:nCh
        aux_imprintS(chimNO{q},sprintf('chimNO[%i]',q));
        aux_imprintS(chim{q},sprintf('chim[%i]',q));
    end
end