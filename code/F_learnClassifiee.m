
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEANING - delete when it works
close all; clear; clc;

global F_I
F_I = 0;
global disp2_level;
disp2_level = 10;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F0_initials();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% function FT_learnClassifiee()
getChFts = 0
if getChFts==1
    disp2(1,'getChims Features');
    toSave = 1;
    draw = 1;
    draw = 0;
    FT_getChimsFeatures(toSave,draw);
end

load('features.mat')
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cut the meas..
from = 1;
to = length(ftv);
% to = 80;
meas = ftv(from:to,:);
species = charv(from:to);

% meas = cat(2,meas, rand(to,1));
% ftNames = cat(1,ftNames,'rand');

disp2(1,'Preproces measures');

nMeas = size(meas,1);
nFts = length(ftNames);
disp2(2,sprintf('%3d features', nFts));
disp2(2,sprintf('%3d measurements',nMeas));

%% remove duplicities (where did they came from?)
% disp2(1,'Remove duplicities');
% 
% [meas, ia, ic] = unique(meas,'rows');
% species = species(ia) ;
% 
% doubled = nMeas - length(meas);
% disp2(2, sprintf('%i doubled measurements',doubled));
% 
% frm = 2;
% frm = 1;
% ftNames = ftNames(frm:end) ;
% meas = meas(:,frm:end);
% 
% nMeas = size(meas,1);
% nFts = length(ftNames);
% disp2(2,sprintf('%3d features', nFts));
% disp2(2,sprintf('%3d measurements',nMeas));

% species = 
% meas = meas(:,[1 2   ]);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% nFeatures = size(meas,2)
% nExamples = size(meas,1)
% nClassified = size(species,1)
% nNames = size(ftNames,1)
% 
% % method = 'directlda';
% method = 'pcalda';
% % siz = size(meas,2);
% siz = size(meas,2);
% % newSiz = ceil(siz / 4);
% newSiz = nFeatures;
% examples = meas;
% classLabels = species;
% [newMeas,T] = directlda(examples,classLabels,newSiz,method);
% meas = newMeas;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ignore some features
% m12=meas(:,1:2);
meas = meas(:,1:end);
% meas = sortrows(meas,19)

nMeas = size(meas,1);


%% create training data and its group selectors

disp2(1,sprintf('Create training data and its group selectors = classifiers'));
chN = '1234567890';
% DELETE THOSE WHO ARE NOT PRESENT IN DATABASE??
% chA = 'ABCDEFGSTUVWXYZ'; 
chA = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 

%% alphanumeric
chs = cat(2,chA,chN);
[traAN , grpAN] = aux_createTrainingGroup(chs, meas, species);

%% alpha
chs = chA;
[traA , grpA] = aux_createTrainingGroup(chs, meas, species);

%% numeric
chs = chA;
[traN , grpN] = aux_createTrainingGroup(chs, meas, species);

%% save train groups
disp2(1,sprintf('Save ''learnt classifiers'' in ''classifier.mat'''));
save('classifier','traAN','grpAN','traA','grpA','traN','grpN');


%% Linear and Quadratic Discriminant Analysis
disp2(1,sprintf('Linear Discriminant Analysis'));

disp2(2,sprintf('they see me classifiin'''));
% learn alphanumeric classifier
sample = meas;
training = traAN;
group = grpAN;
% training = meas;
% group = species;
ldaClass = classify(sample, training, group);

%% Find out how good the classification went
bad = ~strcmp(ldaClass,species);
bads = sum(bad);
ldaResubErr = bads / nMeas;

disp2(2,sprintf('missclassified'));
disp2(3,sprintf('[%d] samples = %f[%%] of all samples', bads, ldaResubErr*100));

%% confusion - which measurements were badly classified
if ldaResubErr ~= 0
% if there were any missclassification
    disp2(2,sprintf('showing confusionmat '));
    [ldaResubCM,grpOrder] = confusionmat(species,ldaClass);
%     gscatter(ldaResubCM
F_I=F_I+1; FI_here=F_I; figure(FI_here);
    mag = 400;
    imshow(ldaResubCM,'InitialMagnification',mag);
    xlabel(grpOrder');
    ylabel(fliplr(grpOrder)');
    title('diagonal - properly classified')

% show those which were miss-classified
%     ...
end

visualize = 0;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plane separation as an image 
% with scattered real values
if visualize == 1
disp2(2,sprintf('Visualize'));
disp2(3,sprintf('2 feature planes separation as an image '));
disp2(3,sprintf('with scattered real values of features'));
disp2(3,sprintf('printing bi-featural planes:'));

%%
% The function has separated the plane into regions divided by lines, and assigned different regions to different species.  One way to visualize these regions is to create a grid of (x,y) values and apply the classification function to that grid.

% j = classify([x y],X_testing(:,iftSI),species);

cols = 'rgbcmyk';
shps = 'osdosd';
nStep = 200;

nMeas = size(meas,2);
% F_I=F_I+1; FI_here=F_I; figure(FI_here); SI = 0; SY = 2; SX = floor(nMeas/4);
F_I=F_I+1; FI_here=F_I; figure(FI_here); SI = 0; SY = 4; SX = floor(nMeas/8);
set(gcf,'units','normalized','outerposition',[0 0 1 1])

for a=1:2:nMeas
    b = a+1;
    if(a+1>nMeas) 
        b=1;
    end
    disp2(4,sprintf('%s & %s',ftNames{a},ftNames{b}));
    
%% plane separation as an image
    ix = a;
    iy = b;
    xmm=[ min(meas(:,ix)), max(meas(:,ix)) ];
    ymm=[ min(meas(:,iy)), max(meas(:,iy)) ];
    xint = linspace(xmm(1),xmm(2),nStep);
    yint = linspace(ymm(1),ymm(2),nStep);
    [x,y] = meshgrid(xint,yint);
    x = x(:);
    y = y(:);
    mxy = meas(:,[ix,iy]);
    j = classify([x y],mxy,species);
    
    im = zeros(length(xint),length(yint));
    im(:) = j;
    tit = sprintf('x = %d; y = %d',a,b);
    aux_imprintS(im,tit)
    colormap('hsv')
    
    hold on;
    
    
    %% scatter actual values
    hold on
%   transfer measure from actual values to image position
    coef = (nStep -1) / (xmm(2)-xmm(1)) ;
    ma = (meas(:,a) - xmm(1)) * coef + 0.5;
    
    coef = (nStep -1) / (ymm(2)-ymm(1)) ;
    mb = (meas(:,b) - ymm(1)) * coef + 0.5;
%   scat
    gscatter(ma, mb, species, cols,shps);
    legend('hide');
    
%     aux_nextSubplot();
%     gscatter(x,y,j,cols,shps)
%%
    xlabel(ftNames(a));
    ylabel(ftNames(b));
    
    axis tight
end
legend('show');

% colorbar
colorbar('YTickLabel',...
    {'Freezing','Cold','Cool','Neutral',...
     'Warm','Hot','Burning','Nuclear'})

% chftv = meas(5,:)
% classify(chftv,meas,species,'linear')
end

%%
% For some data sets, the regions for the various classes are not well
% separated by lines. When that is the case, linear discriminant analysis
% is not appropriate. Instead, you can try quadratic discriminant analysis
% (QDA) for our data.
%
% Compute the resubstitution error for quadratic discriminant analysis.
% from = 4;
% to = from+1;
% qdaClass = classify(m12,m12,species,'quadratic');
% bad = ~strcmp(qdaClass,species);
% qdaResubErr = sum(bad) / N


%% ...
% naive bayes
% rng(0,'twister');
% First use cvpartition to generate 10 disjoint stratified subsets.
% meas
% cp = cvpartition(species,'k',10)
% 
% % nbGau= NaiveBayes.fit(meas(:,1:2), species);
% nbGau= NaiveBayes.fit(meas(:,1:2), species, 'Distribution', 'mn');
% nbGauClass= nbGau.predict(meas(:,1:2));
% bad = ~strcmp(nbGauClass,species);
% nbGauResubErr = sum(bad) / N
% nbGauClassFun = @(xtrain,ytrain,xtest)...
%                (predict(NaiveBayes.fit(xtrain,ytrain), xtest));
% nbGauCVErr  = crossval('mcr',meas(:,1:2),species,...
%               'predfun', nbGauClassFun,'partition',cp)



% % % % % H = fspecial('laplacian');
% % % % % L = imfilter(image,H,'replicate');
% % % % % M=image-L;
% % % % % se = strel('square',3); %making the window
% % % % % 
% % % % % 
% % % % % my_image = imerode(M, se);
% % % % % my_image = imdilate(my_image, se);
% % % % % my_image = imerode(my_image, se);
% % % % % my_image = imdilate(my_image, se);
% % % % % my_image = imdilate(my_image, se);
% % % % % my_image = imerode(my_image, se);
% % % % % my_image = imdilate(my_image, se);
% % % % % my_image = imdilate(my_image, se);
% % % % % my_image = imdilate(my_image, se);
% % % % % my_image = imerode(my_image, se);
% % % % % lo_image=medfilt2(my_image,[3 3]); %Median filtering the image to remove noise%
% % % % % BW = edge(lo_image,'sobel'); %finding edges 
% % % % % [imx,imy]=size(BW);
% % % % % L = bwlabel(BW);% Calculating connected components
% % % % % %disp(L);
% % % % % [r,c] = find(L==11); 
% % % % % rc = [r c];
% % % % % %disp(rc);
% % % % % [sx sy]=size(rc);
% % % % % n1=zeros(imx,imy); 
% % % % % for i=1:sx
% % % % %     x1=rc(i,1);
% % % % %     y1=rc(i,2);
% % % % %     n1(x1,y1)=210;
% % % % % end % Storing the extracted image in an array
% % % % % figure,imshow(I);
% % % % % figure,imshow(my_image);
% % % % % figure,imshow(BW);
% % % % % figure,imshow(n1,[]);
% % % % % %G = fspecial('sobel');
% % % % % %L= imfilter(L,G,'replicate');
% % % % % %imshow(my_image);





















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOT USED



%% ??
% 
% hold on;
% plot(meas(bad,1), meas(bad,2), 'kx');
% % plot(meas(bad,iftS(1)), meas(bad,iftS(2)), 'kx');
% hold off;

%% index of features showed
% iftS = [1,2];
% ft1 = meas(:,iftS(1));
% ft2 = meas(:,iftS(2));
% gscatter(ft1, ft2, species,'rgbcmyk','osdosd');
% 
% xlabel(ftNames(iftS(1)));
% ylabel(ftNames(iftS(2)));
% 
% N = size(meas,1);

% 
% coeff = pca(meas)

%% scatter values 
% cols = 'rgbcmyk';
% shps = 'osdosd';
% 
% nFeatures = size(meas,2)
% nExamples = size(meas,1)
% nClassified = size(species,1)
% nNames = size(ftNames,1)
% 
% % species = species(1:size(meas,2));
% 
% nMeas=size(meas,2)
% F_I=F_I+1; FI_here=F_I; figure(FI_here); SI = 0; SY = 2; SX = floor(nMeas/4);
% 
% set(gcf,'units','normalized','outerposition',[0 0 1 1])
% for a=1:2:nMeas
%     aux_nextSubplot();
%     b = a+1;
%     if(a+1>nMeas) 
%         b=1;
%     end
% %     size(meas(:,a))
% %     size(meas(:,b))
% %     size(species)
%     gscatter(meas(:,a), meas(:,b), species, cols,shps);
%     xlabel(ftNames(a));
%     ylabel(ftNames(b));
%     hold on
%     plot(meas(bad,a), meas(bad,b), 'kx');
%     axis tight
% end