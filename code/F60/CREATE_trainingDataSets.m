function [traAN, grpAN, traA , grpA, traN , grpN] = CREATE_trainingDataSets(meas, species)

disp2(1,sprintf('Create training data and its group selectors = classifiers'));
chN = '1234567890';
% DELETE THOSE WHO ARE NOT PRESENT IN DATABASE??
% chA = 'ABCDEFGSTUVWXYZ'; 
chA = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 

%% alphanumeric
chs = cat(2,chA,chN);
[traAN , grpAN] = aux_createTrainingGroup(chs, meas, species);

%% alpha
chs = chA;
[traA , grpA] = aux_createTrainingGroup(chs, meas, species);

%% numeric
chs = chN;
[traN , grpN] = aux_createTrainingGroup(chs, meas, species);

%% save train groups
disp2(1,sprintf('Save ''learnt classifiers'' in ''classifier.mat'''));
save('classifier','traAN','grpAN','traA','grpA','traN','grpN');
