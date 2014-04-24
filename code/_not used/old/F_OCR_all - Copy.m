% /***********
% \project    MAPV - Projekt 2 - Separace a rozpoznání znakù SPZ
% \url        <http://midas.uamt.feec.vutbr.cz/APV/projects/project_2.php>
% \authors    xdavid10, xnovac10, xsauer01, xvlada00 @ FEEC-VUTBR
% \filename	  .m
% \contacts	  Bc. DAVIDEK Daniel <danieldavidek@gmail.com>
%             Bc. NOVACEK Petr   <xnovac10@stud.feec.vutbr.cz>
%             Bc. SAUER Petr     <xsauer01@stud.feec.vutbr.cz>
%             Bc. VLADAR Martin  <xvlada00@stud.feec.vutbr.cz>
% \date		  15-04-2014
% \brief      ..
% \license    ?
% ***********/

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASIC DEFINITIONS
F0_defines();
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEANING
close all; clear; clc;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i_lpt = 1:100
    name = sprintf('./SPZ_100/SPZ_%03d.bmp', i);
    img = imread(name)
    


%% testing
%% rotating
% for i = 1:100
%     
%     name = sprintf('./SPZ_100/SPZ_%03d.bmp', i);
%     img = imread(name);
%     img = rotation_settlement(img);
%     save_to = sprintf('./SPZ_100_rotated/SPZ_%03d.bmp', i);
%     imwrite(img, save_to, 'bmp');
% %     pause(1)
%     
% end

%% cutting-off background

% for i = 1:100
%     
%     name = sprintf('./SPZ_100_rotated/SPZ_%03d.bmp', i);
%     img = imread(name);
%     img = cut_off_bg(img);
%     save_to = sprintf('./SPZ_100_cutted_off/SPZ_%03d.bmp', i);
%     imwrite(img, save_to, 'bmp');
% %     pause(1)
%     
% end

for i = 1:100
    
    name = sprintf('./SPZ_100/SPZ_%03d.bmp', i);
    img = imread(name);
    img = rgb_separation(img);
    
%     figure(i)
%     imshow(img)
    img1 = fragmentation(img);
    save_to = sprintf('./SPZ_100_THolded/SPZ_%03d.bmp', i);
    imwrite(img1, save_to, 'bmp')
%      figure(100+i)
%      imshow(img1)
%      pause(1)
    
end










