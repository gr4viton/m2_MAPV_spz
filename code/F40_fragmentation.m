% /***********
% \project    MAPV - Projekt 2 - Separace a rozpozn�n� znak� SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10, xnovac10, xsauer01, xvlada00 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
%             Bc. NOVACEK Petr   <xnovac10@stud.feec.vutbr.cz>
%             Bc. SAUER Petr     <xsauer01@stud.feec.vutbr.cz>
%             Bc. VLADAR Martin  <xvlada00@stud.feec.vutbr.cz>
% \date		  15-04-2014
% \license    ?
% ***********/
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [SPZ_final] = F40_fragmentation(SPZ_raw, draw)

% picture fragmentation function?what does it fragment?lpt to indiv chars?
% input grayscale image
% \param draw - whether to subplot informative data [1=yes]
% output binary file (0, 255)

%% BODY
    
    pixel_count_x = 30;
    pixel_count_y = 150;
    
    div_x = floor(size(SPZ_raw, 1) / pixel_count_x);
    div_y = floor(size(SPZ_raw, 2) / pixel_count_y);
%     size_x = floor(size(SPZ_raw, 1) / div_x);
%     size_y = floor(size(SPZ_raw, 2) / div_y);
    
    SPZ_final = zeros(size(SPZ_raw, 1), size(SPZ_raw, 2));
    
%% counts sizes array for X axis
    
    sizes_x = 1;
    for i = 1:div_x-1
        sizes_x(i+1) = pixel_count_x*i;
    end
    sizes_x(div_x + 1) = size(SPZ_raw, 1);
    
%% counts sizes array for Y axis
    
    sizes_y = 1;
    for i = 1:div_y-1
        sizes_y(i+1) = pixel_count_y*i;
    end
    sizes_y(div_y + 1) = size(SPZ_raw, 2);
    
%% go through all segments of SPZ using segment_thresholding
    
    for i = 1:div_x
        for j = 1:div_y
            x1 = sizes_x(i);
            x2 = sizes_x(i+1);
            y1 = sizes_y(j);
            y2 = sizes_y(j+1);
            SPZ_final(x1:x2, y1:y2) = F43_segment_thresholding(SPZ_raw(x1:x2, y1:y2));
        end % for j
    end %for i
    
%% end of function
end

