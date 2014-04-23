% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10, xnovac10, xsauer01, xvlada00 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
%             Bc. NOVACEK Petr   <xnovac10@stud.feec.vutbr.cz>
%             Bc. SAUER Petr     <xsauer01@stud.feec.vutbr.cz>
%             Bc. VLADAR Martin  <xvlada00@stud.feec.vutbr.cz>
% \date		  15-04-2014
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ SPZ_OK ] = rotation_settlement( SPZ_raw, draw )
%% function for SPZ rotation correction
% input - RGB picture of cutted SPZ in RGB format (SPZ_raw)
% \param draw - whether to subplot informative data [1=yes]
% returns - RGB rotation corrected picture of SPZ (SPZ_OK)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY

%% load and obtaining alternative versions of SPZ

    SPZ_gray = rgb2gray(SPZ_raw);
    SPZ_canny = edge(SPZ_gray, 'canny');

%% hough transform on edged picture (canny)

    SPZ_hough = hough(SPZ_canny,'Theta',-90:89);
    
%% houghpeaks rotation degree obtaining
    
    rot_offset = houghpeaks(SPZ_hough);
    rot_degree = rot_offset(2) - 181;

%% different degree value correction
    if rot_offset(2) >= 0 && rot_offset(2) < 90
        
        rot_degree = rot_degree - 180;
    end

%% pure rotation of RGB picture
    
    SPZ_OK(:,:,1) = imrotate(SPZ_raw(:,:,1), rot_degree);
    SPZ_OK(:,:,2) = imrotate(SPZ_raw(:,:,2), rot_degree);
    SPZ_OK(:,:,3) = imrotate(SPZ_raw(:,:,3), rot_degree);

%% debug figures, keep commented
    
% FI=FI+1; figure(FI); SI = 0; SY = 1; SX = 2;
if draw==1 % DRAW START
im = SPZ_raw;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('Raw spz')); axis tight
    X = [1 size(SPZ_raw, 2)];
    Y = [55 55];
    line(X,Y);
    
im = SPZ_OK;
SI=SI+1; subplot2(SY,SX,SI);
imshow(im,[]); title(strcat('Rot cor [°]',num2str(rot_degree))); axis tight
    X = [1 size(SPZ_raw, 2)];
    Y = [55 55];
    line(X,Y);
end % DRAW END

%% end of function
end
