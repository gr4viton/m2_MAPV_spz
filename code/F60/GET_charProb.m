function [newP] = GET_charProb(chim, gpChars, P)
% returns probabilities of individual characters form gpChars

% select X
P(end-2,1) = 1; 

newP = P;
