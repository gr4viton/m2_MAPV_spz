function [feat] = F50_getFeaturesOfChar(im, iChar, draw)
% Returns feature vector for inputed character
% \param ft - feature vector
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% BASIC DEFINITIONS
% F0_defines();
global ft;
function [newP] = GET_numberProb(chim, gpChars, P, iCh)
% returns probabilities of individual numbers - characters form gpChars

ih = size(chim,1);
iw = size(chim,2);
px = ih*iw;
% str_iCh = sprintf('[%i]',iCh);
str_iCh = sprintf('[%s]',iCh);
% bayessian addition?

% [pow] = Power of individual features = [mu, std]

%% note
% sd = std
% - smaller values of std means higher peaks of normal distribution
% mu = mean 
% - around 0 = not this char
% - around 1 = probably this char
% - around 0.5 = we do not know


% I did not use often as not all features negatively influences gpNOT group
%     pow = (powIS, powNOT);

% ftChars - each feature influences some of the chars
% % if we are searching for number we may safely insert numbers 
% % (not chars of numbers) into ftChars
% % as it is converted in GET_groups to right indexes anyways

% decide which of these to count - according to num/alpha searching
s = regionprops(chim, 'EulerNumber','Centroid','Solidity',...
    'Perimeter','Orientation');


%% auxilary annonymous functions
dispFt = @(name,val) disp2(3,sprintf('%s [%0.2f]', name, val));
dispFtP = @(name,val) disp2(3,sprintf('%s [%0.2f]%%', name, val*100));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEATURES REQUISITION START

tit = strcat(str_iCh,'START');
aux_printProb(P,gpChars); title(tit);
ftCh = []; % 
ftNames = {}; % vector of string for names of individual features

%% 'EulerNumber'
%  the total number of objects in the image 
% minus the total number of holes in those objects
ftVal = s.EulerNumber;
[ftCh, ftNames] = FT_addFeature(ftCh,'EulerNumber',ftVal);

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

%% 'Orientation' = major axis tilt
% should be rotated straightalready
ftVal = s.Orientation;
ftCh = FT_addFeature(ftCh,'Orientation',ftVal);

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

difSumToNum = @(im1,im2) (sum2(im1) - sum2(im2)) / numel(im2);
sumToNum = @(im) sum2(im) / numel(im);


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
ftCh = FT_addFeature(ftCh,'S2N_1y9',ftVal);

%% x halves
im1 = chimSub2(1,1,1,2); 
im2 = chimSub2(1,1,2,2); 
ftVal = difSumToNum(im1,im2);
ftCh = FT_addFeature(ftCh,'DS_lr',ftVal);
%% y halves
im1 = chimSub2(1,2,1,1); 
im2 = chimSub2(2,2,1,1); 
ftVal = difSumToNum(im1,im2);
ftCh = FT_addFeature(ftCh,'DS_ud',ftVal);

%% center 0,8
im = chimCent(5);
ftVal = sumToNum(im);
ftCh = FT_addFeature(ftCh,'S2N_c5',ftVal);
S2Ncent

%% up to down strip scale 
s = 7;
im1 = chimSub2(1,s,1,1);
im2 = chimSub2(s,s,1,1);
ftVal = difSumToNum(im1,im2);
ftCh = FT_addFeature(ftCh,'DS_1u7d7',ftVal);

%% 2/3 - euler + 6/9

%% r y quaters + 6

%% l y quaters + 9


%% rotation

%% houghlines
%% freeman code of skelet

%% projections

%% B vs 8
% mirroring
% left half center px count vs right..
% but it should be straight

% okraj
% hlavn� poloosa - nato�it
% majoritni uhel hlavn� (jenom mo�n�)

% ft.point = im(1,1);
% features.areaSumRel = ..
% calls individual functions for computation of features


% ota�et jednotliv�
% majoritn� �hly �ar v znaku - ty co sou v nule neberu
% freeman code
% 
% prvni nato�it v�echny podle hlavn� osy- 
% sice jsou oto�en� r�zn� ale to je ti jedno

newP = P;

%% vykreslit prubeh po jednotlivych featurach


ft = cat(1,ft,ftCh)
aux_imprintS(chim, iCh);
end


%% not used
% %% predefined pows
% % probably is
% pIS = [1, 0.1];
% pIs = [1, 0.5];
% pis = [1, 1];
% 
% % probably is not
% pNOT = [0, 0.1];
% pNot = [0, 0.5];
% pnot = [0, 1];
% 
% % encourage not knowing
% pVOID = [0.5, 0.1]
% pVoid = [0.5, 1]
% pvoid = [0.5, 100];



% powIS / powNOT
% - adition of [1, 0.1] = very probable is this char 
%   - significant feature for this char
% - adition of [0, 0.1] = very probable is not this char
%   - significant feature for this char
% - adition of [0.9, 2] = probable is this char 
%   - not so significant feature for this char
% - adition of [0.8, 2] = probable is not this char 
%   - not so significant feature for this char



feat = ft;

% feat = 1;
%% end of function
end

