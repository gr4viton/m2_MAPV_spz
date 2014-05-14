function aux_imprintPulp(chim);
% print all char images in one pulped image
nml=numel(chim);
imPulp = [chim{1}];
for iCh=2:nml
    im = [chim{iCh}];
    % imPulp = blkdiag(imPulp,im);        
    ih = size(im,1);
    ip = size(imPulp,1);
    if ih>ip
        iw = size(imPulp,2);
        imPulp = cat(1,imPulp,zeros(ih-ip,iw));
    elseif ih<ip
        iw = size(im,2);
        im = cat(1,im,zeros(ip-ih,iw));
    end
    L = GET_whiteLineVBw(imPulp);
    B = L;
    B(:) = 0;
    BLB = cat(2,B,L,B);
    imPulp = cat(2,imPulp,BLB,im);
    % imPulp = imfuse(imPulp,im,'montage');
end

aux_imprintS(imPulp, strcat('all chims') );