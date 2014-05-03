function [ lptRgb ] = REMOVE_frame ( lptRgb, draw )
% not used yet?

%% brief..
% \param draw - whether to subplot informative data [1=yes]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lptRgb = lptRgb;

%% DELETE THIS IF YOU DO NOT NEED IT

% FI=FI+1; figure(FI); SI = 0; SY = 1; SX = 3;
% FI=FI+1; FI_here=FI; figure(FI_here); SI = 0; SY = 1; SX = 3;

% im = some_image;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('im_title')); axis tight


% if draw==1 % DRAW START
% im = SPZ_raw;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('Raw spz')); axis tight
% 
% end % DRAW END


%% not used

%% sharpening techniques
% 
% im = imsharpen(colOfLpt); 
% aux_imprint(im, strcat('imsharpen'), 1);
% 
% mask = [0:255];
% for i=1:3
%     hi(:,:) = colOfLpt(:,:,i);
%     im(:,:,i) = histeq(hi,mask);
% end
% aux_imprint(im, strcat('histeq'), 1);
% 
% for i=1:3
%     hi(:,:) = colOfLpt(:,:,i);
%     im(:,:,i) = adapthisteq(hi,'Distribution','exponential');
% end
% aux_imprint(im, strcat('adapthisteq'), 1);


%% some masking
% im = colOfLpt ;
% SI=SI+1; subplot2(SY,SX,SI);
% imshow(im,[]); title(strcat('colOfLpt')); axis tight
% 
% inv_colOfLpt = imcomplement(colOfLpt);

% find_color(colOfLpt,[],0.2, []);
% col = color('red');
% % col = imcomplement(col);
% [maskR, ind] = find_color(lptRgb,[],20, []);
% 
% col = color('green');
% col = imcomplement(col);
% maskG = find_color(inv_colOfLpt,[],0.2, col');
% 
% col = color('blue');
% col = imcomplement(col);
% maskB = find_color(inv_colOfLpt,[],0.2, col');


%% another masking

% maskR = zeros(size(colOfLpt));
% maskB = maskR;
% maskG = maskB;
% 
% for y=1:size(colOfLpt,1)
%     for x=1:size(colOfLpt,2)
%         meanCol(y,x) = mean([colOfLpt(y,x,1),colOfLpt(y,x,2),colOfLpt(y,x,3)]);
%         maskR(y,x) = colOfLpt(y,x,1)-meanCol(y,x);
%         maskG(y,x) = colOfLpt(y,x,2)-meanCol(y,x);
%         maskB(y,x) = colOfLpt(y,x,3)-meanCol(y,x);
%     end
% end
% maskR(maskR<0) = 0;
% maskG(maskG<0) = 0;
% maskB(maskB<0) = 0;
% 
% maskR(1,1) = 255;
% maskG(1,1) = 255;
% maskB(1,1) = 255;
% maskR = colOfLpt( 255 > colOfLpt(:,:,1) > 200);

