function [ftCh, ftNs] = F50_getFeaturesOfChar(chim, iCh, draw)
% % Returns feature vector for inputed character image
% \param ftCh - feature vector
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

global font_chim;
global font_ch;

ih = size(chim,1);
iw = size(chim,2);
px = ih*iw;
str_iCh = sprintf('[%i]',iCh);
% str_iCh = sprintf('[%s]',iCh);

% decide which of these to count - according to num/alpha searching
st = regionprops(chim, 'EulerNumber','Centroid','Solidity',...
    'Perimeter','Orientation','MajorAxisLength','MinorAxisLength',...
    'Extent','Extrema','Eccentricity','EquivDiameter','Area'  );

%% auxilary annonymous functions
dispFt = @(name,val) disp2(3,sprintf('%s [%0.2f]', name, val));
dispFtP = @(name,val) disp2(3,sprintf('%s [%0.2f]%%', name, val*100));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEATURES REQUISITION START

tit = strcat(str_iCh,'START');
% vertical vector of indiidual feature values for this chim
ftCh = []; 
% vertical cell array of string for names of individual features
ftNs = {}; 

pxs = st.Area;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THESE ARE NOT GOOD

%% 'Centroid'
% ftVal = s.Centroid(1);
% [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'CentroidX');
% ftVal = s.Centroid(2);
% [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'CentroidY');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THESE ARE GOOD ENAUGHT
%% 'EulerNumber'
%  the total number of objects in the image minus the total number of holes in those objects
% % ftVal = st.EulerNumber;
% % [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'EulerNumber');
% WHY IT IS BAD FOR CLASSIFIER?

%% Perimeter
ftVal = st.Perimeter/pxs;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Perimeter/sumpx');
%% EquivDiameter
ftVal = st.EquivDiameter;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'EquivDiameter');

%% Eccentricity
ftVal = st.Eccentricity;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Eccentricity');
%% Extent
ftVal = st.Extent;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Extent');
%% Solidity
ftVal = st.Solidity;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Solidity');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% needed features for distinguishing 
% need 0/9, 4/5, 6/9 6/0 3/2 8/5 3/4 3/5  
% very strong 4/5
% NEED some strong bfeatures for - 2,1,3,7

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% mirroring
% should be rotated straight
% count of pixels in part of image compared to one another
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% subimages
% auxilary anonnymous functions
sh = @(s) ih/s;
sw = @(s) iw/s;
shF = @(s) floor(sh(s));
swF = @(s) floor(sw(s));
shC = @(s) ceil(sh(s));
swC = @(s) ceil(sw(s));

shSub = @(y,s) ((y-1)*shF(s)+1):(y)*shF(s) ;
swSub = @(x,s) ((x-1)*swF(s)+1):(x)*swF(s) ;

chimSub = @(y,x,s) chim(shSub(y,s), swSub(x,s));
chimSub2 = @(y,sy,x,sx) chim(shSub(y,sy), swSub(x,sx));
chimCent = @(s) chimSub(ceil(s/2),ceil(s/2),s);
maxVal = 255;
sum2 = @(m) double(sum(sum(m))) / maxVal;

difSumToNum = @(im1,im2) (sum2(im1) - sum2(im2)) / double(numel(im2));
sumToNum = @(im) double(sum2(im)) / double(numel(im));


%% LEGEND
% DS - diffSumToNum - difference of sum of pixels / numpx
% % - most often the subimage is divided only in one axe -->
% % ud - up to down where image is divided into halves
% % lr - left to right where image is divided into halves
% % 1u7d7 - first seventh of image to last seventh - in vertical
% % 1l7r7 - first seventh of image to last seventh - in horizontal
% S2N - sumToNum - sum of pixels / numpx
% % ABCD = i.e 1911 
% % % 19 take first ninth in height 
% % % 11 take first 'oneth' in width - whole width
% % AyB = i.e 1y9
% % % take first ninth in height - y axe
% % % this is the same as 1911
% % cyAcxB = center of division by A in y, and center of div by B in x
% % cA = center after division by A in both axes
%% ninths
im1 = chimSub2(1,9,1,1);
ftVal = sumToNum(im1);
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'S2N_1y9');

%% up to down strip scale 
im1 = chimSub2(1,7,1,1);
im2 = chimSub2(7,7,1,1);
ftVal = difSumToNum(im1,im2);
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'DS_1u7d7');

%% 2/3 - euler + 6/9

%% r y quaters + 6

%% l y quaters + 9


%% rotation

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROTATE THEM BY ITS ORIENTATION FIRST
%% 'Orientation' = major axis tilt
% should be rotated straightalready
ftVal = st.Orientation;
% [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Orientation');
chim = imresize(chim,2);
chim = imrotate(chim, -ftVal);


%% x halves
im1 = chimSub2(1,1,1,2); 
im2 = chimSub2(1,1,2,2); 
ftVal = difSumToNum(im1,im2);

[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'DS_lr');
%% y halves
im1 = chimSub2(1,2,1,1); 
im2 = chimSub2(2,2,1,1); 
ftVal = difSumToNum(im1,im2);
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'DS_ud');

%% center 0,8
im = chimCent(5);
ftVal = sumToNum(im);
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'S2N_c5');

%% maj2minAxisLength
ftVal = st.MajorAxisLength/st.MinorAxisLength;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'maj2minAxisLength');

% bad 4?,7!,6!,5!
for q=[1,2,4,6]
% [top-left top-right right-top right-bottom bottom-right bottom-left left-bottom left-top]
% [top-left top-right           right-bottom              bottom-left                     ]
    ftVal = st.Extrema(q);
    tit = sprintf('Extrema%i',q);
    [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,tit);
end


%% houghlines
%% freeman code of skelet

%% projections

%% 'Centroid' 
% [position of centroid] vs [pos of centroid of convex / closed char]
% !!!

%% 'Perimeter' 

%% 'Extent' 
% ratio pixels of char vs bb
% ratio "black to white pixels"

%% 'Solidity' 
% ratio pixels of char vs convex 
% ../ closed

%% 'MinorAxisLength' vs 'MajorAxisLength'
% small
% 1
% ...
% big

%% B vs 8
% mirroring
% left half center px count vs right..
% but it should be straight

% okraj
% hlavní poloosa - natoèit
% majoritni uhel hlavní (jenom možná)

% ft.point = im(1,1);
% features.areaSumRel = ..
% calls individual functions for computation of features


% otaèet jednotlivá
% majoritní úhly èar v znaku - ty co sou v nule neberu
% freeman code
% 
% prvni natoèit všechny podle hlavní osy- 
% sice jsou otoèené rùznì ale to je ti jedno


%% porovnání se vzorem
siz = numel(font_chim);
for q=1:siz
    c = chim;
    f = font_chim{q};
    nml = numel(f);
    
    
    if nml > numel(c)
        % f is bigger -> make c bigger
        c = imresize(c, size(f));
    else
        f = imresize(f, size(c));
    end
    
    err = 0;
    for e=1:nml
        err = err + abs(f(e) - c(e));
    end
    err = err / nml;
    ftVal = err;
    tit = sprintf('err_pattern:%c',font_ch{q});
    [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,tit);
end

%% momenty i vyssich radu

%%
%% vykreslit prubeh po jednotlivych featurach

% individual region properties

% ____________________________________________________
% horizontal and vertical projection


% xprjC,yprjC - projections of [lptC]
norma = 0;
xprjC = aux_projectDown(chim,               norma);
yprjC = aux_projectDown(imrotate(chim,-90), norma);
xprjCN = aux_projNorm(xprjC);
yprjCN = aux_projNorm(yprjC);

ftVal = median(xprjCN(:,:,1));
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'xprojCN_med');
ftVal = median(yprjCN(:,:,1));
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'yprjCN_med');

ftVal = max(xprjC(:,:,1)) / sum2(xprjC(:,:,1));
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'xprojC_max');
ftVal = max(yprjC(:,:,1)) / sum2(yprjC(:,:,1));
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'yprojC_max');
% 
% % plot'em
% aux_plotRgbs(xprjC, strcat('xprjC'), 0);
% aux_plotRgbs(xprjC, strcat('xprjC'), 3);
% aux_plotRgbs(yprjC, strcat('yprjC'), 0); camroll(90);
% aux_plotRgbs(yprjC, strcat('yprjC'), 2); camroll(90);

% % do morph erosion
% R = ceil(ih / 80);
% SE = strel('disk',R,4);
% lptBw = imerode(lptBw, SE);
%     im = lptBw;
%     aux_imprintS(im,'erosion')
%     
% % do morph opening
% R = ceil(ih / 40);
% SE = strel('disk',R,4);
% lptBw = imopen(lptBw, SE);
%     im = lptBw;
%     aux_imprintS(im,'opening')
% 
% % do morph closing
% R = ceil(ih / 40);
% SE = strel('disk',R,4);
% lptBw = imclose(lptBw, SE);
%     im = lptBw;
%     aux_imprintS(im,'closed')

%% end of function
end


