function [P] = INIT_probability(gpChars)
%% initialization of Probability vector with normal distribution
% P = [colvect(mu), colvect(sd)]
% sd - standard deviation
% - smaller values of std means higher peaks of normal distribution
% mu - mean 
% - around 0 = not this char
% - around 1 = probably this char
% - around 0.5 = we do not know

ons = ones(numel(gpChars),1);
% mean value
% mu = 0.5*ons;
mu = 0*ons;

% standard deviation = sigma^2
sd = 1*ons;
P = [mu, sd];


end