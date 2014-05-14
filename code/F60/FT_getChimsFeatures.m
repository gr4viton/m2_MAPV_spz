function FT_getChimsFeatures(toSave, draw)
% gets features of all saved chims

global F_I;
F0_defPlot();
% load chims - named after what number they are


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% font examples - for pattern matching

global font_chim;
global font_ch;

[font_chim, font_ch] = FT50_loadFontExamples();
[font_ch{:}]

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SORTED
imgPath = 'chim_sorted\'; 
dCell = dir(strcat(imgPath,'*.png'));    

maxChim = length(dCell);
% tryNchim = 15;
tryNchim  = maxChim;

if(tryNchim > maxChim) 
   tryNchim = maxChim; 
end

% keep track of already tried chim indexes
was = [];

% vector of all chim features
ftv = [];
ftNamev = [];
% vector of all chim should be characters
charv = [];

whichLpt = 1;    % if try on different LPTs each time
whichLpt = 0;

if draw==1
    F_I = 123;
    F_I=F_I+1; FI_here=F_I; figure(FI_here); SI = 0; SY = 2; SX = 2;
    SX = ceil(tryNchim)/5;
    SY = 5;
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
end
disp2(1,sprintf('Counting features of all training chims'));
for countChim = 1:tryNchim
    
    numChim = countChim;
%     if whichLpt  == 1
% %       random was only for debug
% %         and it was baad decision bcs it confused - created twins
% %         if isempty
%         while numel(was)<maxChim
%             numChim = ceil((maxChim-1)*rand(1) + 1); % random from <1;100>
%             if isempty(was(was==numChim))
%                 % for the first time
%                 was = cat(2,numChim);           
%                 break;                
%             end
%         end
%     elseif whichLpt  == 2
% %         numCh = gpLpt(iLpt);
%     end
    
    imRgb = imread(strcat(imgPath, dCell(numChim).name)); 
    if islogical(imRgb)
        % is already binary
        chim{numChim} = imRgb;
    else
        chim{numChim} = im2bw(imRgb,0.5);
    end
% take that the characters are always uppercase
    char{numChim} = upper( dCell(numChim).name(1) );

    [ftCh, ftNs] = F50_getFeaturesOfChar(chim{numChim},numChim);
    ftv = cat(1,ftv,ftCh');
    ch = char{numChim};
    charv = cat(1,charv,ch);
    
%     disp2(1,sprintf('#%i = [%s]', q, char{q}));
%     for r = 1:length(ftCh)
%         disp2(2,sprintf('% 0.2f = %s', ftCh(r), ftNs{r} ))
%     end

%     disp2(3,sprintf('chim = %3d/%-3d',numChim,tryNchim));
    disp2(2,sprintf('chim = %3d/%-3d ==> should be [%c]',countChim,tryNchim,ch));
%     disp2(3,sprintf('Should be %c',ch));
    if draw==1
        im = chim{numChim};
        aux_imprintS(im,ch);
    end
end

% % to have only positive numbers
% mm = min(min(ftv));
% ftv = ftv + mm;
    
ftNames = ftNs;

if toSave ==1
    save('features','ftv','charv','ftNames');
end