% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
% \date		  15-04-2014
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [chims] = F40_getCharIms(lpt, draw)
% returns cell array of images containging individual char images in bw
% \param lpt - bw image with only the text
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
F0_defines();


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

