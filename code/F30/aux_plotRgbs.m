function [ out ] = aux_plotRgbs ( projRgbs, tit, normalize )
%% plots r g b and sum channels of projection 
% size(projRgbs) = [:, :, 4]
% projection = sum of pixels in one direction
% \normalize 
% [>1] individual channels can be normalized to <0; 1>
% [2] each channel will be offsetted in y for better recognition
% [3] each channel will be offsetted in x for better recognition

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
% F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

in = projRgbs;

nChan = 4;
% normalize & offset
yoffset(1:nChan) = 0;
times = 1;
if normalize>0
    in = aux_projNorm(in);
    tit = sprintf('n[%s]',tit);
end
if normalize ==2
    yoffset(1:nChan) = (1:nChan) - 1;
elseif normalize ==3
    times = nChan;
end

% preprocessing
for q=1:(nChan)
    rgb(q,:) = in(:,:,q) + yoffset(q);
end

% siz = (numel(in)/size(in,3));
siz = size(rgb,2);
t = 1:(times*siz);

% do the xoffsetting
if normalize ==3
    zers = zeros( 1, siz );
    rgb_long = repmat(zers,[1,nChan]);
    for q=1:(nChan)
        from = (q-1)*siz + 1;
        to = (q)*siz ;
%         to-from+1;
%         size(rgb(q,:));
        rgb_long(q,from:to) = rgb(q,:);
    end
    rgb = rgb_long;
%     t = q:(nChan*(siz+1)-1);


%     rgb(2:3,1:(1*nChan)) = 0;

%     for q=1:(nChan)
% %         zers = zeros( 1, siz );
% %         zer0 = repmat(zers,[1,q ]);
% %         zer1 = repmat(zers,[1,nChan-q]);
% %         size(zer0)
% %         size(zer1)
% %         size(rgb(q,:))
% %         rgb(q,:) = cat(2, zer0, rgb(q,:), zer1)
%         rgb2(q,:) = repmat(rgb(q,:),[1,nChan]);
%         rgb(q,:) = rgb2(q,:)
%     end
end
% plot coloring
prevCO = get(0,'DefaultAxesColorOrder');
% prevCO = get(0,'DefaultAxesLineStyleOrder');
% 'DefaultAxesLineStyleOrder','-|--|:|-.')

g = 0.42; % gray
% set(0,'DefaultAxesColorOrder',[g g g; 1 0 0; 0 1 0; 0 0 1]);
set(0,'DefaultAxesColorOrder',[1 0 0; 0 1 0; 0 0 1; g g g]);

% plotting
aux_nextSubplot();
% plot(t,rgb(1:3),t,rgb(4),'--');
plot(t,rgb,'--');
if normalize==2
    hold on;
    offsetLines = repmat( (1:nChan)', [1,size(t,2)]) - 1;
    plot(t, offsetLines,'LineWidth',1);
end

% lw = linspace(2,1,nChan);
% lw(1:4) = 2;
% for q=1:nChan
% %     plot(t,rgb(q),'--', 'LineWidth', lw(q)); hold on
% %     plot(t,rgb(q,:),'--'); hold on
% end
% plot(t,rgb,'--');

% hold on;
% stairs(t,rgb)

title(tit); axis tight

set(0,'DefaultAxesColorOrder',prevCO);

out=1;

end