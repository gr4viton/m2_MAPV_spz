% SKEW_font()
close all
clear all
clc;
fld = '..\chim_sorted\font\';
% dir = 

dCell = dir(strcat(fld,'*.png'));    

maxChim = length(dCell);
tryNchim = maxChim;

figure
for q = 1:tryNchim
    nam = dCell(q).name;
    chim = imread(strcat(fld, nam)); 
    ch = nam(1);
    
%     imshow(chim);
%     title(ch)
    
    a = deg2rad(10);
    mat = eye(3);
    mat(2) = -tan(a);
    frm = maketform('affine',mat);
    chimR = imtransform(chim,frm);
    
    mat(2) = -mat(2);
    frm = maketform('affine',mat);
    chimL = imtransform(chim,frm);
    
    
    fldr = '..\chim_sorted\fontSkew\';
    path = strcat(fldr,ch,'fontSkew');
    frm = 'png';
    imwrite(chimR, strcat(path,'R.',frm),frm);
    imwrite(chimL, strcat(path,'L.',frm),frm);
end
