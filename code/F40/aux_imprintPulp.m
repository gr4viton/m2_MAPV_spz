function aux_imprintPulp(chim);
% print all char images in one pulped image
imPulp = [chim{1}];
for iCh=2:7
    im = [chim{iCh}];
    % imPulp = blkdiag(imPulp,im);        
    ih = size(im,1);
    ip = size(imPulp,1);
    if ih>ip
        iw = size(imPulp,2);
        imPulp = cat(1,imPulp,ones(ih-ip,iw));
    elseif ih<ip
        iw = size(im,2);
        im = cat(1,im,ones(ip-ih,iw));
    end
    L = GET_whiteLineVBw(imPulp);
    imPulp = cat(2,imPulp,L,im);
    % imPulp = imfuse(imPulp,im,'montage');
end

aux_imprintS(imPulp, strcat('all chims') );