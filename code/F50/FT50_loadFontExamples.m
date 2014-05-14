function [font_chim, font_ch] = FT50_loadFontExamples()
% returns individual character image examples with group of its character
% names
dirfont = 'font\chims\';
dCell = dir(strcat(dirfont,'*.png'));    

maxChim = length(dCell);
tryNchim = maxChim;
for q = 1:tryNchim
    nam = dCell(q).name;
    font_chim{q} = imread(strcat(dirfont, nam)); 
    font_ch{q} = nam(1);
end
