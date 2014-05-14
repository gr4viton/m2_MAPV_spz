function DISP_scatteredValues(meas,species,ftNames,a,b, nStep)
%% scatter actual values
cols = 'rgbcmyk';
shps = 'osdosd';
    ix = a;
    iy = b;

    xmm=[ min(meas(:,ix)), max(meas(:,ix)) ];
    ymm=[ min(meas(:,iy)), max(meas(:,iy)) ];
    
%   transfer measure from actual values to image position
    coef = (nStep -1) / (xmm(2)-xmm(1)) ;
    ma = (meas(:,a) - xmm(1)) * coef + 0.5;
    
    coef = (nStep -1) / (ymm(2)-ymm(1)) ;
    mb = (meas(:,b) - ymm(1)) * coef + 0.5;
%   scat
    gscatter(ma, mb, species, cols,shps);
    legend('hide');
    
%     aux_nextSubplot();
%     gscatter(x,y,j,cols,shps)
%%
    xlabel(ftNames(a));
    ylabel(ftNames(b));
    
    axis tight