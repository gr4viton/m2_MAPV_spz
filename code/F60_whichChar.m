function [char] = F60_whichChar(chim, iCh, draw)
% returns array of characters
% \param features - feature vector of one character
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% prerequisitions
% apriory syntax = [#] number; [X] alpha-character
always_syntax = 'XXX####';
syntax = '#X#####';

nums = '0123456789';
% DELETE THOSE WHO ARE NOT PRESENT IN DATABASE!
chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 

%%
% the definition should be in F0_defines.m
ft = struct( ...
    'areaSumRel', 1,...
    'areaSumAbs', 1,...
    'circumfrnc', 1,...
    'eulerNum', 1 ...
);

%% make database of features from database of images

char = '?';

%% what it can be
if or( iCh >= 4, iCh <= 7)
% 4:7 = surely number
    [num, prob] = GET_numberProb(chim);
elseif iCh == 2
% 2 = surely alpha char
    [char, prob] = GET_charProb(chim);
else
% [1],[3] = maybe alpha-char / maybe number
%     [num, prob] = GET_number(chim);
%     [char, prob] = GET_char(chim);
    [num, prob] = GET_alphanumProb(chim);
end

% pravdepodobnosti jednotlivých písmen
% dat na nulu pro ty ktere ze syntaxe nemozou byt na iChar


%% B vs 8
% mirroring
% left half center px count vs right..
% but it should be straight

% okraj
% hlavní poloosa - natoèit
% majoritni uhel hlavní (jenom možná)

% ft.point = im(1,1);
% features.areaSumRel = ..
% calls individual functions for computation of features

%% dumb
% if iCh == 4:7
%     if(ft.point == 1)
%         char = '6';
%     else
%         char = '9';
%     end
% %     if(ft.areaSumRel == 0.5)
% else
%     char = 'K'; 
% end
%% end of function
end

