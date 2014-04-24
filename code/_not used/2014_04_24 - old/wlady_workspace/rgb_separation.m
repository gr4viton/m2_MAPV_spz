function [SPZ_final] = rgb_separation(SPZ_raw)

%% function separates red, green and blue parts of picture SPZ_raw
%% input - RGB picture
%% output - grayscale picture RGB separated

%% BODY

%% invert colours
    
    SPZ_gray = rgb2gray(SPZ_raw);
    SPZ_gray_inv = SPZ_gray;
    SPZ_raw_inv = SPZ_raw;
    SPZ_gray_inv_final = SPZ_gray_inv;
    SPZ_final = SPZ_gray_inv;

    for i = 1: size(SPZ_gray, 1)
        for j = 1: size(SPZ_gray, 2)
            SPZ_gray_inv(i,j) = 256-SPZ_gray(i,j);
            SPZ_raw_inv(i,j,1) = 256 - SPZ_raw(i,j,1);
            SPZ_raw_inv(i,j,2) = 256 - SPZ_raw(i,j,2);
            SPZ_raw_inv(i,j,3) = 256 - SPZ_raw(i,j,3);
        end
    end
    
%% 
    
%     figure(1)
%     
%     subplot(221)
%     imshow(SPZ_gray_inv)
%     title('gray inverted');
%     
%     subplot(222)
%     imshow(SPZ_raw_inv(:,:,1)-SPZ_gray_inv)
%     title('red inverted');
%     
%     subplot(223)
%     imshow(SPZ_raw_inv(:,:,2)-SPZ_gray_inv)
%     title('green inverted');
%     
%     subplot(224)
%     imshow(SPZ_raw_inv(:,:,3)-SPZ_gray_inv)
%     title('blue inverted');
    
    for i = 1: size(SPZ_raw, 1)
        for j = 1: size(SPZ_raw, 2)
            
            SPZ_gray_inv_final(i,j) = SPZ_gray_inv(i,j) - (4*(SPZ_raw_inv(i,j,1) - SPZ_gray_inv(i,j)));
            SPZ_gray_inv_final(i,j) = SPZ_gray_inv_final(i,j) - (4*(SPZ_raw_inv(i,j,2) - SPZ_gray_inv(i,j)));
            SPZ_gray_inv_final(i,j) = SPZ_gray_inv_final(i,j) - (4*(SPZ_raw_inv(i,j,3) - SPZ_gray_inv(i,j)));
            
        end
    end
    
%     figure(2)
%     imshow(SPZ_gray_inv_final)
    
    for i = 1: size(SPZ_gray_inv_final, 1)
        for j = 1: size(SPZ_gray_inv_final, 2)
            SPZ_final(i,j) = 256-SPZ_gray_inv_final(i,j);
        end
    end
%     figure(511)
%     imshow(SPZ_final)
    
    

%% end of function
end
