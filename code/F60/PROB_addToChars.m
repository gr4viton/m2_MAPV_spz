function [P] = PROB_addToChars(sysAB, P, gpChars, ftChars)
% adds powIS to ftChars from gpChars, to others from gpChars adds powNOT
% u is always 100% or 0%
% P = old probability = [mu,sd] of all gpChars

[gpIS, gpNOT] = GET_groups(gpChars,ftChars);
P = PROB_add(sysAB(1), sysAB(2), 1, P, gpIS);
% P = PROB_add(sysAB(1), sysAB(2), 0, P, gpNOT);