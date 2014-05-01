function aux_printProb(P,gpChars)
% print probabilities for individual characters
aux_nextSubplot();
y = P(:,1)*100;
x = cellstr(gpChars(:));
bar(y); axis tight;
% set(g,'axis
% set(g,'XTickLabel',gpChars)
set(gca,'XTickLabel',x,  'XTick',1:numel(x))
ylabel = 'probability [%]';
