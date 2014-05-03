close all
figure

in = xinteg;

g = 0.42;
% set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1]);
% set(0,'DefaultAxesColorOrder',[0,0,0; 1 0 0; 0 1 0; 0 0 1]);
set(0,'DefaultAxesColorOrder',[g g g; 1 0 0; 0 1 0; 0 0 1]);

siz = numel(in)/3;
t = 1:siz;
r_g_b = 0;
for q=1:3
    r_g_b(q,:) = in(:,:,q);
end
rgb(1,:) = sum(in,3);

if siz>100
    % stairs would not be seen anyway
    plot(t,rgb,'--', t,r_g_b); axis tight;
else
%     stairs(t,rgb);
%     stairs(t,r_g_b);
%     stairs(t,r_g_b(q,:));
end

% hold on;
% stairs(t,rgb)
