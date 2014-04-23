function [ SPZ_cut_off ] = F20_cutt_off_bg( SPZ_raw, draw )
% Cuts of backround?
% \param draw - whether to subplot informative data [1=yes]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();

%% for debugging only, comment when complete
    
%     SPZ_original = imread('./SPZ_100/SPZ_001.bmp');
%     SPZ_raw = rotation_settlement(SPZ_original);
%     SPZ_raw = rgb2gray(SPZ_raw);
    
%% BODY
    SPZ_raw_original = SPZ_raw; % for draw==1
    
%% vertical and horizontal histogram obtaining
    
    hist_x = zeros(size(SPZ_raw, 1));
    hist_y = zeros(size(SPZ_raw, 2));
    
    for x = 1:size(SPZ_raw, 1)
        
        hist_x(x) = sum(SPZ_raw(x,:));
    end
    
    for y = 1:size(SPZ_raw, 2)
        
        hist_y(y) = sum(SPZ_raw(:,y));
    end

%% right cut-off border finding
    
%     maximum_Y = max(hist_y(:,1));
    cut_off_border = round(max(hist_y(:,1)) * 0.5);
    
    for i = 1:size(SPZ_raw, 2)
        if hist_y(i) >= cut_off_border
            border_Y(2) = i;
        end
    end
    
%% left cut-off border finding
    
    for i = size(SPZ_raw, 2):-1:1
        if hist_y(i) >= cut_off_border
            border_Y(1) = i;
        end
    end
    
    
    %% top cut-off border finding
    
%     maximum_X = max(hist_x(:,1));
    cut_off_border = round(max(hist_x(:,1)) * 0.8);
    
    for i = 1:size(SPZ_raw, 1)
        if hist_x(i) >= cut_off_border
            border_X(2) = i;
        end
    end
    
%% bottom cut-off border finding
    
    for i = size(SPZ_raw, 1):-1:1
        if hist_x(i) >= cut_off_border
            border_X(1) = i;
        end
    end

%% new SPZ generation

    SPZ_raw = SPZ_raw(border_X(1):border_X(2), border_Y(1):border_Y(2));
    SPZ_cut_off = SPZ_raw;
    
%% peak finding
    
    % local_peaks_x(peak_value,
    %               peak_index,
    %               peak_lower_value,
    %               peak_lower_indexes)
    
    local_peaks_x(1,1) = max(hist_x(1:round(size(SPZ_raw, 1)/2)));
    local_peaks_x(1,2) = max(hist_x(round(size(SPZ_raw, 1)/2):size(SPZ_raw, 1)));
    local_peaks_x(2,1) = find(hist_x==local_peaks_x(1,1));
    local_peaks_x(2,2) = find(hist_x==local_peaks_x(1,2));
    local_peaks_x(3,1:2) = local_peaks_x(1,1:2)-10000;
    for x = 1:round(size(SPZ_raw, 1)/2)
        if hist_x(x) >= local_peaks_x(3,1)
            local_peaks_x(4,1) = x;
        end
        if hist_x(x+round(size(SPZ_raw, 1)/2)-1) >= local_peaks_x(3,2)
            local_peaks_x(4,3) = x + round(size(SPZ_raw, 1)/2)-1;
        end
    end
    for x = round(size(SPZ_raw, 1)/2):-1:1
        if hist_x(x) >= local_peaks_x(3,1)
            local_peaks_x(4,2) = x;
        end
        if hist_x(x+round(size(SPZ_raw, 1)/2)-1) >= local_peaks_x(3,2)
            local_peaks_x(4,4) = x + round(size(SPZ_raw, 1)/2)-1;
        end
    end
    local_peaks_x

%% plots

if draw==1 % DRAW START
% im=hist
SI=SI+1; subplot2(SY,SX,SI);
plot(hist_x, 1:size(SPZ_raw_original, 1));
title(strcat('row hist')); axis tight

SI=SI+1; subplot2(SY,SX,SI);
plot(1:size(SPZ_raw_original, 2), hist_y);
title(strcat('col hist')); axis tight

end % DRAW END

%     plot(hist_x, 1:size(SPZ_raw_original, 1))
%     subplot(223)
%     plot(1:size(SPZ_raw_original, 2), hist_y)
%     subplot(224)
%     imshow(SPZ_raw);
%     
%     
%     figure(2)
%     imshow(SPZ_raw);
% %     line([1 size(SPZ_raw, 2)], [local_peaks_x(4,1) local_peaks_x(4,1)])
% %     line([1 size(SPZ_raw, 2)], [local_peaks_x(4,4) local_peaks_x(4,4)])
%     line([border_Y(1) border_Y(1)], [1 size(SPZ_raw, 1)])
%     line([border_Y(2) border_Y(2)], [1 size(SPZ_raw, 1)])
    
    
    
end

