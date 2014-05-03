function [ outLpt ] = rotate ( lptRgb, draw )
%% Counts the probable lpt angle of rotation and reverse it 
% in future maybe: try to reduce skeweness
% \retval - straight horizontal lpt image
% \param draw - whether to subplot informative data [1=yes]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% problem makers lpt number
% 6, 45

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to find left blue strip 
% ========= could have better results 
% -->higher priority in mixing

% make blue color contrast 
% show edges
% try to find its border x 
% cut 1.5 * x column of lpt
% find long vertical hough lines 
% count the angle

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to find center green and red dot

% try to find green dot
% get its center
% try to find red dot
% get its center
% count the angle
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to find border horizontal line
ang = rotate_angFrameBorder(lptRgb,draw);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to reduce skeweness
% finding the frame border -> more transformations


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% count the final angle from individual rotate_angXXX subfunctions

% count the angle
ang = mean(ang);

% dont take angles if are not in some interval? <-10; 10>[°]
%  and low angles under 1° do not rotate to-> it only disturbs the image (maybe..)

% rotate picture
if(abs(ang) >= 1)
%     'crop' ?????????????????
    lptRgb = imrotate(lptRgb,ang,'bilinear','crop');
end

if draw==1 % DRAW START
    im = lptRgb;
    aux_imprint(im, strcat('rotated lpt'));
end % DRAW END

outLpt = lptRgb;
