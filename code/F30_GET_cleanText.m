function [lptCleanBw] = F30_getCleanText(lptRgb, draw)
%% function returns LPT plate without anything else then text in bw
% \param lpt - rgb image
% \param draw - whether to subplot informative data [1=yes]

% del frame
% thin margin

%% filter background through saturation
% ? make black areas blackier and compact
draw=0;
lptBlackedRgb = BLACK_colorfullPixels(lptRgb,draw);

%% thresh and frame the lpt part
[lptWFrameBw, voffs] = PREPARE_bwFrame(lptBlackedRgb,draw);
% voffs = [toH, toW] - toW is aplicated 1st to sides, toH second to up,dn
    
%% remove frame Up, Dn
lptNoUDMarginBw = REMOVE_frameUD(lptWFrameBw,draw);

%% remove injected frame
lptBw = REMOVE_marginsFrame(lptNoUDMarginBw, voffs, draw);
lptCleanBw = lptBw;

if draw==1
    im = lptWFrameBw;
    aux_imprintS(im,'with frame')
    im = lptNoUDMarginBw;
    aux_imprintS(im,'no margins up,down')
    im = lptCleanBw;
    aux_imprintS(im,'margins removed - clean')
end

%% end of function
end