function lptBwWOframe = REMOVE_marginsFrame(lptBw, voffs, draw)
% voffs = [toH, toW, ih, iw] 
% - toW is aplicated 1st to sides, toH second to up,dn

% remove up down
from = voffs(1)+1;
to = voffs(1)+voffs(3);
lptBwWOframe = lptBw(from:to,:);

% remove left right
from = voffs(2);
to = voffs(2)+voffs(4);
lptBwWOframe = lptBw(:,from:to);