function [SPZ_final] = segment_thresholding(SPZ_raw)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% for debugging only, comment when complete
    
%     SPZ_original = imread('./SPZ_100/SPZ_001.bmp');
%     SPZ_raw = rotation_settlement(SPZ_original);
%     SPZ_raw = rgb2gray(SPZ_raw);
%     SPZ_raw_original = SPZ_raw;
    
%% BODY

    SPZ_final = zeros(size(SPZ_raw, 1), size(SPZ_raw, 2));

    segment_hist = imhist(SPZ_raw);
    for i = 1:1:size(segment_hist, 1)
        if segment_hist(i) >= 10
            border(2) = i;
            
        end
    end
    
    for i = size(segment_hist, 1):-1:1
        if segment_hist(i) >= 10
            border(1) = i;
        end
    end
    
    middle = border(1) + ((border(2) - border(1)) / 2) - 20;
    
    for i = 1:size(SPZ_raw, 1)
        for j = 1:size(SPZ_raw, 2)
            if SPZ_raw(i,j) < middle-1
                SPZ_final(i,j) = 0;
            else
                SPZ_final(i,j) = 255;
            end
        end
    end
%% end of function    
end

