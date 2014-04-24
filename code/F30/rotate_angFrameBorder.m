%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
% \date		  15-04-2014
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ outAngle ] = rotate_angFrameBorder ( lptRgb, draw )
%% find angle by detection of frame-border horizontal lines
% \param draw - whether to subplot informative data [1=yes]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to find border horizontal line

% contrast very much ?? -> no because of shadows

ih = size(lptRgb,1);
iw = size(lptRgb,2);
minL = ceil(iw/10);
fillGap = ceil(iw/10);
num_peaks = 5;
angMax = 10; %[°]
    %% pre processin'
    glpt = imfilter(lptRgb, fspecial('gauss',10,0.4));
    %% edge detection
    % sobel,log, !canny!
    E = edge(rgb2gray(glpt),'canny');
    %% hough abscissas
    [H,T,R] = hough(E);
    % peaks in accumulator
    P  = houghpeaks(H,num_peaks);
    % get abscissas
    L = houghlines(E,T,R,P,'FillGap',fillGap,'MinLength',minL);

    %% count angle
    tit = 'a=';
    for i=1:numel(L)
        Y = L(i).point2(2) - L(i).point1(2);
        X = L(i).point2(1) - L(i).point1(1);
        ang(i) = rad2deg(atan2(Y,X));
        len(i) = sqrt(X.^2+Y.^2);
        tit = strcat(tit,num2str(ang(i)),'|');
    end;
    angle = median(ang(:));
%     a = [0.5 0.6 0.9];
%     b = [1 10 1];
%     (0.5*1 + 0.6*10 + 0.9*1) / (1+10+1)
    angleWeighted = sum(ang.*len)/sum(len);
%     tit = strcat(tit,num2str(angleWeighted),'|');
%     angle = mean(ang(:)');
%     tit = strcat(tit,num2str(angle),'|');
%     angle = median(ang(:)');
%     tit = strcat(tit,num2str(angle),'==');
    
    wow = 5; % weight of weighted angle
    angle = (angleWeighted*wow + median(ang(:)') ) / sum(wow,1);    
    tit = strcat(tit,'=',num2str(angle),'|');

%% counted angle
    outAngle = angle;
    
%% drawin'   

if draw==1 % DRAW START
% gaussian    
    im = glpt;
    SI=SI+1; subplot2(SY,SX,SI);
    imshow(im,[]); title(strcat('gaussian')); axis tight
% edge
    im = E;
    SI=SI+1; subplot2(SY,SX,SI);
    imshow(im,[]); title(strcat('edges')); axis tight
% houghlines abscissas
    for i=1:length(L)
       cols = hsv(length(L));
       line([L(i).point1(1) L(i).point2(1)],[L(i).point1(2) L(i).point2(2)],'Color',cols(i,:),'LineWidth',2);
    end;
    title(tit);
end
end % DRAW END