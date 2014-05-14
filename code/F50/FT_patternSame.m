function [ftCh, ftNs] = FT_patternSame(centerS,chim,ftCh,ftNs,tit,pat,pat_ch);
    
siz = numel(pat);
for q=1:siz
    c = chim;
    f = pat{q};
% resize on same size
    nml = numel(f);
    if nml > numel(c)
        % f is bigger -> make c bigger
        c = imresize(c, size(f));
    else
        f = imresize(f, size(c));
    end
    if centerS~=1;
%     take only centers of image and pattern
        chim = c;
        ih = size(c,1);
        iw = size(c,2);
        aux_subimagesAnonymous();
        c = chimCent(centerS);
        
        chim = f;
        aux_subimagesAnonymous();
        f = chimCent(centerS);
    end
% count error    
    nml = numel(f);
    err = 0;
    for e=1:nml
        err = err + abs(f(e) - c(e));
    end
    err = err / nml;
    ftVal = err;
    tit = sprintf('%s:%c',tit,pat_ch{q});
    [ftCh, ftNs] = FT_addFeature(ftCh,ftVal,ftNs,tit);
end