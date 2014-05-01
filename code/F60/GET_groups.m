function [gpIS, gpNOT] = GET_groups(gpChars, chList)
% returns indexes of chList in gpChars = [gpIS] , and those who are not
% there = [gpNOT].
% 
% gpChars = string of characters
% chList = string of those which are selected 
% - if array of numbers < 10 would be inserted, its automatically converted
% gpIS = indexes of chList in gpChars
% gpNOT = indexes of complement

% isNumbers = 0;
if(max(chList) < 10)
% this means we are probably classifying numbers
% and inserted them here 
% --> so we need to create characters from these numbers
%     isNumbers = 1;
%     chList = num2str(chList)
    chList = chList+'0';
end

gpIS = [];
gpNOT = 1:numel(gpChars);
for q=1:length(chList)
    index_chQ = strfind(gpChars, chList(q));
    if isempty(index_chQ)
        % not defined
        error(sprintf('character [%s] = chList[%i], not defined in gpChars',chList(q),q));
    else
        % add found to gpIS
        gpIS = cat(2,gpIS,index_chQ);
        % remove found from gpNOT
        cond = eq(gpNOT, index_chQ);
        gpNOT(cond) = [];
    end
end


end