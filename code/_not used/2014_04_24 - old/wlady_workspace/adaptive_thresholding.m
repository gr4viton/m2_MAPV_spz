function [SPZ_final] = adaptive_thresholding(SPZ_raw)
%% thresholding function
%% input - grayscale image
%% output - binary image (0, 255)

%% BODY
%% result matrix preparation
    SPZ_final = zeros(size(SPZ_raw, 1), size(SPZ_raw, 2));
    
%% histogram

    histogram = imhist(SPZ_raw);

%% smoothing of hist to reduce count of peaks
    
    g = gausswin(50);
    g = g/sum(g);
    hist_smooth = conv(histogram, g, 'same');
    
%% find peaks in smoothened hist
    
    [pks,locs] = findpeaks(hist_smooth, 'minpeakdistance', 20, 'minpeakheight', 3);
    
%% find minimum between most important peaks -> promote to threshold
    
    [minimum, border] = min(histogram(locs(size(locs, 1)):-1:locs(1)));
    border = border-50;
    border = 255;
%% thresholding
    
    for i = 1:size(SPZ_raw, 1)
        for j = 1:size(SPZ_raw, 2)
            
            if SPZ_raw(i,j) < border
                SPZ_final(i,j) = 0;
            else
                SPZ_final(i,j) = 255;
            end % if
        end % for j
    end % for i
%% end of function
    
end

