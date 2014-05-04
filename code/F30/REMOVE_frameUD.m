function lptBw = REMOVE_frameUD(lptBw,draw)
%% remove frame upper and lower, by finding biggest objects in inverse

% FRAME 1
% inversion - frame become white
lptBwI = imcomplement(lptBw);

% get biggest object
[bw_biggest, cc] = GET_biggest(lptBwI);
blackFrameInv = bw_biggest;
blackFrameInv1 =blackFrameInv;
% remove frame 1
lptBw = lptBw + blackFrameInv;
lptBwF1 = lptBw;

% FRAME 2
% inversion - frame become white
lptBwI = imcomplement(lptBw);

% get biggest object
[bw_biggest, cc] = GET_biggest(lptBwI);
blackFrameInv = bw_biggest;
% remove frame 1
lptBw = lptBw + blackFrameInv;

if draw ==1
    im = blackFrameInv1 ;
    aux_imprintS(im,'white frame1')
    im = lptBwF1;
    aux_imprintS(im,'w/o frame1')
    im = blackFrameInv;
    aux_imprintS(im,'white frame2')
    im = lptBw;
    aux_imprintS(im,'w/o frame2')
end