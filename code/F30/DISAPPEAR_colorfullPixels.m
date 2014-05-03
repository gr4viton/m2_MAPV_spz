function lptRgb = DISAPPEAR_colorfullPixels(lptRgb,draw)
% sets colorfull pixels to white color

ih = size(lptRgb,1);
iw = size(lptRgb,2);

% lptC = MAKE_lptC(lptRgb,draw)

%% SEEK in lptRgb
% scan the image for colorfull pixels
for x = 1:iw
    for y = 1:ih
        rgb = lptRgb(y,x,:);
        % error of composite colors        
        ycmMax = 6;
        Y = abs(rgb(1) - rgb(2));
        C = abs(rgb(3) - rgb(2));
        M = abs(rgb(1) - rgb(3));
%         if (Y > ycmMax) | (C > ycmMax) | (M > ycmMax)
%             % pixel is colorfull - make it white
%             lptRgb(y,x,1:3) = 255*ones(1,3);
% %         else
% %             % pixel is not colorfull - leave it be
%         end

        if (Y < ycmMax) & (C < ycmMax) & (M < ycmMax)
            % pixel is not colorfull - leave it be
        else
            % pixel is colorfull - make it white
            lptRgb(y,x,1:3) = 255*ones(1,3);
        end
    end
end

if draw==1
    im = lptRgb;
    aux_imprint(im,'even more colorless')
end
end