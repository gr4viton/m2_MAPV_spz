function [thisChar, newP] = F60_whichChar(chim, iCh, draw)
% returns array of characters
% \param chim - prepared character image
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% prerequisitions
% apriory syntax = [#] number; [X] alpha-character
always_syntax = 'XXX####';
syntax = '#X#####';

gpCharsNum = '1234567890';
% DELETE THOSE WHO ARE NOT PRESENT IN DATABASE!
gpCharsAlpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 

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
disp2(2,sprintf('#%i',iCh));


%% what it can be 
% debug
gpChars = gpCharsNum;
    P = INIT_probability(gpChars);
    P = GET_numberProb(chim,gpChars,P, iCh);
%% FINAL   
% if and( iCh >= 4, iCh <= 7)
% % 4:7 = surely number
%     gpChars = gpCharsNum;
%     P = INIT_probability(gpChars);
%     P = GET_numberProb(chim,gpChars,P);
% elseif iCh == 2
% % 2 = surely alpha char
%     gpChars = gpCharsAlpha;
%     P = INIT_probability(gpChars);
%     P = GET_charProb(chim,gpChars,P);
% else
% % [1],[3] = maybe alpha-char / maybe number
% % more probable is - number???
% % only on old lpts are in this position a alpha-char
%     gpChars = gpCharsNum;
%     P = INIT_probability(gpChars);
%     P = GET_numberProb(chim,gpChars,P);
% %     gpChars = gpCharsAlpha;
% %     P = GET_char(chim,gpChars,P);
% 
% %     gpChars = cat(2,gpCharsNum,gpCharsAlpha);
% %     P = INIT_probability(gpChars);
% %     P = GET_alphanumProb(chim,gpChars,P);
% end

% % debug
% P(:,1)
% max(P(:,1))

% Maximal mean value = mu
[maxMu,ind] = max(P(:,1));
% future - combine with std around mu - max(P(:,2))
% i.e if two values are close togeather from max_me -> and one of them have
% lower std = more focused => probably it is the second -> this should not
% happen often

%% print'em
aux_printProb(P,gpChars);

%% ende
thisChar = gpChars(ind);
newP = [maxMu, P(ind,2)];

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

