function lptBw = REMOVE_frameUD(lptBw,draw)
%% remove frame upper and lower, by finding biggest objects in inverse

%% FRAME 1
% inversion - frame become white
lptBwI = imcomplement(lptBw);

% get biggest object
[bw_biggest, cc] = GET_biggest(lptBwI);
blackFrameInv = bw_biggest;
blackFrameInv1 =blackFrameInv;
% remove frame 1
lptBw = lptBw + blackFrameInv;
lptBwF1 = lptBw;

if draw ==1
    im = blackFrameInv1 ;
    aux_imprintS(im,'white frame1')
    im = lptBwF1;
    aux_imprintS(im,'w/o frame1')
    im = blackFrameInv;
end
%%
% if frames were connected
s = regionprops(blackFrameInv,'Centroid');
fh = s.Centroid(2); % y-coord
ih = size(lptBw,1);
coef = 0.3;
minh = ih*coef;
maxh = ih-minh;
% fh
% maxh
% minh
if and( fh < maxh , fh > minh)
%    both frames were probably connected 
% and so now are probably removed 
% -> do not remove next biggest object as it would be character
    
    if draw ==1
        im = blackFrameInv1 ;
        aux_imprintS(im,'frame1 connected w/frame2')
        im = lptBwF1;
        aux_imprintS(im,'w/o frame1 & frame2 ')
        im = blackFrameInv;
    end
    return
else
%% FRAME 2
% inversion - frame become white
lptBwI = imcomplement(lptBw);

% get biggest object
[bw_biggest, cc] = GET_biggest(lptBwI);
blackFrameInv = bw_biggest;
% remove frame 1
lptBw = lptBw + blackFrameInv;

if draw ==1
    aux_imprintS(im,'white frame2')
    im = lptBw;
    aux_imprintS(im,'w/o frame2')
end

end