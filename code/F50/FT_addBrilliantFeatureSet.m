function [ftCh, ftNs] = FT_addBrilliantFeatureSet(chim,ftCh,ftNs);
% many features to add - which are brilliant!

%% subimages
ih = size(chim,1);
iw = size(chim,2);
aux_subimagesAnonymous()
% st = regionprops(im, 'EulerNumber','Centroid','Solidity',...
%     'Perimeter','Orientation','MajorAxisLength','MinorAxisLength',...
%     'Extent','Extrema','Eccentricity','EquivDiameter','Area',...
%     'FilledImage','ConvexImage' );
    
st = regionprops(chim, 'Centroid',...
    'Perimeter','Orientation','MajorAxisLength','MinorAxisLength',...
    'Extent','Extrema','Eccentricity','EquivDiameter','Area' );

%% 'Centroid' 
% [position of centroid] to size
ftVal = st.Centroid(1) / iw;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'XCentroidToW');
ftVal = st.Centroid(2) / ih;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'YCentroidToH');

%% Perimeter
ftVal = st.Perimeter/st.Area;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Perimeter/sumpx');

%% EquivDiameter
ftVal = st.EquivDiameter;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'EquivDiameter');

%% Eccentricity
% Scalar that specifies the eccentricity of the ellipse that has the same second-moments as the region.
ftVal = st.Eccentricity;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Eccentricity');

%% Extent
% ratio "black to white pixels"
ftVal = st.Extent;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Extent');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% mirroring
% should be rotated straight
% count of pixels in part of image compared to one another


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOR next features -->
% ROTATE THEM BY ITS ORIENTATION FIRST!

%% 'Orientation' = major axis tilt
% should be rotated straightalready
ftVal = st.Orientation;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Orientation');

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
chim = chimCent(5);
ftVal = sumToNum(chim);
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'S2N_c5');

%% maj2minAxisLength
ftVal = st.MajorAxisLength/st.MinorAxisLength;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'maj2minAxisLength');

%% extrema creates duplicities 
% -> makes training matrix not positive definite
% = bad thing
% bad 4?,7!,6!,5!
% for q=[1,2,4,6]
% % [top-left top-right right-top right-bottom bottom-right bottom-left left-bottom left-top]
% % [top-left top-right           right-bottom              bottom-left                     ]
%     ftVal = st.Extrema(q);
%     tit = sprintf('Extrema%i',q);
%     [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,tit);
% end