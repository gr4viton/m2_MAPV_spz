% function [thisChar, newP] = F60_whichChar(chim, iCh, draw)
% function [char] = F60_whichChar( iCh, ftCh, ftNs, meas, species)
function [char] = F60_whichChar( iCh, ftCh )
% returns array of characters
% \param chim - prepared character image
% \param iChar - number of the character -> to utilize aprior syntax
% \param draw - whether to subplot informative data [1=yes]

%% prerequisitions
% apriory syntax = [#] number; [X] alpha-character; [@] alpha or number
always_syntax = '@X@####';
% syntax = '#X#####';

% gpCharsNum = '1234567890';
% % DELETE THOSE WHO ARE NOT PRESENT IN DATABASE!
% gpCharsAlpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 

global traAN;
global grpAN;
global traA;
global grpA;
global traN;
global grpN;

char = '?';


%% what it can be 
% if iCh == 2
% % alpha-character only
%     training = traA;
%     group = grpA;
% elseif iCh >= 4
% % number only    
%     training = traN;
%     group = grpN;
% else
% % alpha or number
%     training = traAN;
%     group = grpAN;
% end

    training = traAN;
    group = grpAN;
sample = ftCh';

% ldaClass = classify(sample,training,group);
% char = ldaClass{:};

char = classify(sample,training,group);

disp2(2,sprintf('#%i = %c',iCh, char));
% char = classify(ftCh,meas,species,'linear');

%% ende
thisChar = char;

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

