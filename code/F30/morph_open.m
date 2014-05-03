function [ out ] = morph_open ( in, draw )
% morphological operations - open - on channels r,g
% optimalized for noise reduction during eurostrip 
% NOT for rdot search

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hi = size(in,1);
wi = size(in,2);
MN = [ ceil(hi/10), ceil(wi/10)];
SE = strel('rectangle',MN);

in(:,:,1) = imopen(in(:,:,1), SE);
in(:,:,2) = imopen(in(:,:,2), SE);
in(:,:,3) = imopen(in(:,:,3), SE);

out = in;
if draw==1 % DRAW START
    im = out; 
    aux_imprint(im, strcat('closed'));
end % DRAW END
