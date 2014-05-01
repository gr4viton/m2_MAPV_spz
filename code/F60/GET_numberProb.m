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


% NaiveBayes??
%% predefined sysAB
% pred_sysAB(:,1:2) = ([0.5, 1];
% sysAB_strong = [0.5, 1];
% sysAB_mild = [0.5, 0.5];
% sysAB_weak = [0.5, 0.1];
A = 0.4;

% sysAB_strong = [A, 0.1];
% sysAB_mild = [A, 0.3];
% sysAB_weak = [A, 0.6];

A = 0.4;
% sysAB_STRONG = [A, 0.1];
% sysAB_strong = [A, 0.2];
% sysAB_mild = [A, 0.3];
% sysAB_weak = [A, 0.4];

% sysAB_STRONG = [A, 3];
% sysAB_strong = [A, 2];
% sysAB_mild = [A, 1];
% sysAB_weak = [A, 0.1];

% A = 0.4;
% sysAB_STRONG = [A, 0.7];
% sysAB_strong = [A, 0.6];
% sysAB_mild = [A, 0.55];
% sysAB_weak = [A, 0.5];


syst = @(A) [A, 1-A];
% syst = @(A) [1-A, A];
sysAB_STRONG = syst(0.7);
sysAB_strong = syst(0.6);
sysAB_mild = syst(0.5);
sysAB_weak = syst(0.4);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEATURES REQUISITION START

tit = strcat(str_iCh,'START');
aux_printProb(P,gpChars); title(tit);

%% 'EulerNumber'
%  the total number of objects in the image 
% minus the total number of holes in those objects

en = s.EulerNumber;
if en == 1 % [1] = 1,2,3,4,5,7
    P = PROB_addToChars(sysAB_STRONG, P, gpChars, [1:5,7]);
elseif en == 0 % [0] = 6,0,9
    P = PROB_addToChars(sysAB_STRONG, P, gpChars, [0,6,9]);
elseif en == -1 % [-1] = 8
    P = PROB_addToChars(sysAB_STRONG, P, gpChars, 8);
else
% should not ever happen on numbers
end

tit = strcat(str_iCh,'Euler number');
dispFt(tit,en);
aux_printProb(P,gpChars); title(tit);

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
o = s.Orientation;

% very right
% 7
% straight = 8,0
% 5
% 6
% 1, 4
% very left

tit = strcat(str_iCh,'Orientation');
dispFt(tit,o);
aux_printProb(P,gpChars); title(tit);

%% needed features for distinguishing 
% need 0/9, 4/5, 6/9 6/0 3/2 8/5 3/4 3/5  
% very strong 4/5
% NEED some strong bfeatures for - 2,1,3,7

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% mirroring
% should be rotated straight
% count of pixels in part of image compared to one another

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

%% 7
im1 = chimSub2(1,9,1,1);
subVal = sumToNum(im1);
if subVal > 0.85 % 7
    P = PROB_addToChars(sysAB_STRONG, P, gpChars, [7]);
end

tit = strcat(str_iCh,'S2N u9');
dispFtP(tit,subVal);
aux_printProb(P,gpChars); title(tit);
%% x halves
im1 = chimSub2(1,1,1,2); 
im2 = chimSub2(1,1,2,2); 
subVal = difSumToNum(im1,im2);

% left-right
if abs(subVal) < 0.07 % 0 8F
% it is left right pixel count symetric
    P = PROB_addToChars(sysAB_strong, P, gpChars, [0,8]);
end
if subVal < 0.1 % 3 9
    P = PROB_addToChars(sysAB_mild, P, gpChars, [3,9]);
end
if subVal > 0.1 % 6
    P = PROB_addToChars(sysAB_mild, P, gpChars, 6);
end

tit = strcat(str_iCh,'DS xhalf');
dispFtP(tit,subVal);
aux_printProb(P,gpChars); title(tit);
%% y halves
im1 = chimSub2(1,2,1,1); 
im2 = chimSub2(2,2,1,1); 
subVal = difSumToNum(im1,im2);
% aux_imprintS(im1,'im1');
% aux_imprintS(im2,'im2');

% up - down
if subVal < 0.10
% it is up down pixel count symetric
    P = PROB_addToChars(sysAB_strong, P, gpChars, [0,8,3]);
end
if subVal < 0.2 % 4
    P = PROB_addToChars(sysAB_weak, P, gpChars, 4);
end
if subVal > 0.2 % 1
    P = PROB_addToChars(sysAB_weak, P, gpChars, 1);
end
if subVal > 0 % 9 
    P = PROB_addToChars(sysAB_weak, P, gpChars, 9);
end
if subVal < 0 % 6
    P = PROB_addToChars(sysAB_weak, P, gpChars, 6);
end

tit = strcat(str_iCh,'DS yhalf');
dispFtP(tit,subVal);
aux_printProb(P,gpChars); title(tit);
%% center 0,8
im = chimCent(5);
subVal = sumToNum(im);

if subVal < 0.01 % [<0.01] = 0 
    P = PROB_addToChars(sysAB_strong, P, gpChars, 0);
end
if subVal < 0.1 % [<0.10] = 1
    P = PROB_addToChars(sysAB_mild, P, gpChars, 1);
end    
if subVal > 0.5 % [>0.6] = 6 8 9
    P = PROB_addToChars(sysAB_strong, P, gpChars, [6,8,9]);
end    
% if and(subVal >= 0.4, subVal <= 0.6) % [0.40<x<0.6] = 5
%     P = PROB_addToChars(sysAB_mild, P, gpChars, 5);
% end    

tit = strcat(str_iCh,'cent');
dispFtP(tit,subVal);
aux_printProb(P,gpChars); title(tit);
%% up to down strip scale 
s = 7;
im1 = chimSub2(1,s,1,1);
im2 = chimSub2(s,s,1,1);
subVal = difSumToNum(im1,im2);

if subVal > 0.4 % [u-d>0] = 7
    P = PROB_addToChars(sysAB_strong, P, gpChars, 7);
end
if subVal < 0.1 % [u-d<0] = 4
    P = PROB_addToChars(sysAB_mild, P, gpChars, 4);
end    
if abs(subVal) < 0.2  % [u=d] = 0,6,8
    P = PROB_addToChars(sysAB_strong, P, gpChars, [0,6,8]);
end    

tit = strcat(str_iCh,'DS ud strip');
dispFtP(tit,subVal);
aux_printProb(P,gpChars); title(tit);
% aux_imprintS(uim,'uim');
% aux_imprintS(dim,'dim');

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

newP = P;

%% vykreslit prubeh po jednotlivych featurach


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