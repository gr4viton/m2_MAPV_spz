clc
B = training';
wtwin = size(B)
[C,ia,ic] = unique(B,'rows');
wotwin = size(C)
disp(sprintf('[%i] rows of training'' = columns of training is duplicate',wtwin-wotwin))
disp('which one')
size(C(ia))
size(C(ic))

I = ia;
ixDupRows = setdiff(1:size(B,1), I)

ftNames(90)

% 
% x = [
%     1 1
%     2 2
%     3 3
%     4 4
%     3 3
%     3 3
%     ]
% [u,I,J] = unique(x, 'rows', 'first');
% hasDuplicates = size(u,1) < size(x,1)
% 1:size(x,1)
% I
% ixDupRows = setdiff(1:size(x,1), I)
% dupRowValues = x(ixDupRows,:)