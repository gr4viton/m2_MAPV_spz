function [ out ] = morph_close ( in, draw )
% morphological operations - close
% optimalized for eurostrip and g,r dots

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hi = size(in,1);
wi = size(in,2);
R = ceil(hi / 10);
SE = strel('disk',R,4);
in(:,:,1) = imclose(in(:,:,1), SE);
in(:,:,2) = imclose(in(:,:,2), SE);

MN = [ ceil(hi/10), ceil(wi/10)];
SE = strel('rectangle',MN);
in(:,:,3) = imclose(in(:,:,3), SE);

out = in;
if draw==1 % DRAW START
    im = out; 
    aux_imprint(im, strcat('closed'));
end % DRAW END
