function [ out ] = aux_plotRgb ( projRgb, tit )
%% plots r g b channels of projection 
% size(projRgbs) = [:, :, 3]
% projection = sum of pixels in one direction
% individual channels can be normalized to <0; 1>

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

in = projRgb;

% preprocessing
siz = (numel(in)/3);
t = 1:siz;
for q=1:3
    r_g_b(q,:) = in(:,:,q);
end

% plot coloring
prev = get(0,'DefaultAxesColorOrder');
g = 0.42; % gray
set(0,'DefaultAxesColorOrder',[1 0 0; 0 1 0; 0 0 1]);

% plotting
aux_nextSubplot();
plot(t,r_g_b);

% hold on;
% stairs(t,rgb)

xlabel(tit); axis tight

set(0,'DefaultAxesColorOrder',prev);

out=1;