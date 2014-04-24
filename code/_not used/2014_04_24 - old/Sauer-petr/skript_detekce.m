clear all; close all; clc
% load('CISLA1.mat')%ulozene znaky zkouseci mnozina
load('CISLA2.mat')
%% normalni zobrazeni - cislo bile, pozadi cerne
pc1=double(pc1);%pc1 je ulozena cislice
pc2=double(pc2);
pc3=double(pc3);
pc4=double(pc4);
pc5=double(pc5);
pc6=double(pc6);
pc7=double(pc7);
figure
subplot(241),imshow(pc1,[])
subplot(242),imshow(pc2,[])
subplot(243),imshow(pc3,[])
subplot(244),imshow(pc4,[])
subplot(245),imshow(pc5,[])
subplot(246),imshow(pc6,[])
subplot(247),imshow(pc7,[])
%% vysledky
[R1,S1]=prunikZnaku(pc1);
[R2,S2]=prunikZnaku(pc2);
[R3,S3]=prunikZnaku(pc3);
[R4,S4]=prunikZnaku(pc4);
[R5,S5]=prunikZnaku(pc5);
[R6,S6]=prunikZnaku(pc6);
[R7,S7]=prunikZnaku(pc7);
R=[R1;R2;R3;R4;R5;R6;R7]
S=[S1;S2;S3;S4;S5;S6;S7]
[R,S]
