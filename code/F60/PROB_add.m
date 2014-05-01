function nP = PROB_add(u, A, B, P, i)
% updates probabilities of [i] selected indexes of P by kalman filter with
% u = input = new measured value 
% A = system matrix A
% B = system matrix B
% P = old probabilites
% i = indexes

% o = old
% n = new

% if no selected indexes
if isempty(i)
    nP = P;
    return;
end

% old P
oMu = P(:,1);
oSd = P(:,2); 

% old values which are not selected with index [i] are preserved
nMu= oMu;
nSd = oSd;

% kalman on selected indexes
nMu(i) = A.*oMu(i) + B.*u;
nSd(i) = A.*oSd(i).*A' + 0;

nP = [nMu, nSd];
end