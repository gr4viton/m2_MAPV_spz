function [training, group] = aux_createTrainingGroup(chs,meas,species)
% creates [training] data and its [group] selectors from [meas] samples
% with [species] defined in [chs]
chsiz = numel(chs);
siz = numel(species);
training = [];
group = {};
for iSp=1:siz
    for iCh=1:chsiz
        if strcmp( species(iSp), chs(iCh) )
            training = cat(1,training, meas(iSp,:));
            group = cat(1, group, species(iSp));
        end
    end
end
group = [group{:}]';