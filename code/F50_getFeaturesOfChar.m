function [ftCh, ftNs] = F50_getFeaturesOfChar(chim, iCh, draw)
% % Returns feature vector for inputed character image
% \param ftCh - feature vector
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

global font_chim;
global font_ch;

str_iCh = sprintf('[%i]',iCh);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% auxilary annonymous functions
% dispFt = @(name,val) disp2(3,sprintf('%s [%0.2f]', name, val));
% dispFtP = @(name,val) disp2(3,sprintf('%s [%0.2f]%%', name, val*100));
%% subimages
ih = size(chim,1);
iw = size(chim,2);
aux_subimagesAnonymous()

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEATURES REQUISITION START

tit = strcat(str_iCh,'START');
% vertical vector of indiidual feature values for this chim
ftCh = []; 
% vertical cell array of string for names of individual features
ftNs = {}; 


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THESE ARE NOT GOOD

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THESE ARE GOOD ENAUGHT


%% porovnání se vzorem
siz = numel(font_chim);
for q=1:siz
    c = chim;
    f = font_chim{q};
% resize on same size
    nml = numel(f);
    if nml > numel(c)
        % f is bigger -> make c bigger
        c = imresize(c, size(f));
    else
        f = imresize(f, size(c));
    end
% count error    
    err = 0;
    for e=1:nml
        err = err + abs(f(e) - c(e));
    end
    err = err / nml;
    ftVal = err;
    tit = sprintf('err_pattern:%c',font_ch{q});
    [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,tit);
end

%% horizontal and vertical projection

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% needed features for distinguishing 
% need 0/9, 4/5, 6/9 6/0 3/2 8/5 3/4 3/5  
% very strong 4/5
% NEED some strong bfeatures for - 2,1,3,7

st = regionprops(chim, 'EulerNumber','Centroid','Solidity',...
    'Perimeter','Orientation','MajorAxisLength','MinorAxisLength',...
    'Extent','Extrema','Eccentricity','EquivDiameter','Area',...
    'FilledImage','ConvexImage' );

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% general features of character image
% = all those fts which would differ for normal vs filled vs convex image
% put them in separate function returning its features!
[ftCh, ftNs] = FT_addBrilliantFeatureSet(chim,ftCh,ftNs);


    
%% 'ConvexImage' 
% chimConv = st.ConvexImage;

%% 'FilledImage' 
% chimFill = st.FilledImage;

%% 'Centroid' 
% [position of centroid] vs [pos of centroid 'ConvexImage'/ closed char]
% stConv = regionprops('Centroid');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% other features of character image

%% Solidity
% ratio pixels of char vs convex 
ftVal = st.Solidity;
[ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'Solidity');

%% 'EulerNumber'
%  the total number of objects in the image minus the total number of holes in those objects
% ftVal = st.EulerNumber;
% [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'EulerNumber');
% ftVal = st.EulerNumber+10;
% [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,'EulerNumberP10');
% WHY IT IS BAD FOR CLASSIFIER?



%% houghlines
%% freeman code of skelet

%% projections

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


%% momenty i vyssich radu

%%
%% vykreslit prubeh po jednotlivych featurach

% individual region properties
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




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% from now on we do not need the original proportions 

% make a square from chim
% if ih > iw
%     siz = [ih,ih];
% else
%     siz = [iw,iw];
% end
% 
% chim = imresize(chim, siz);

