function DISP_planeSeparation(meas,species,ftNames,a,b,nStep)
%% plane separation as an image
    ix = a;
    iy = b;
    xmm=[ min(meas(:,ix)), max(meas(:,ix)) ];
    ymm=[ min(meas(:,iy)), max(meas(:,iy)) ];
    xint = linspace(xmm(1),xmm(2),nStep);
    yint = linspace(ymm(1),ymm(2),nStep);
    [x,y] = meshgrid(xint,yint);
    x = x(:);
    y = y(:);
    mxy = meas(:,[ix,iy]);
    j = classify([x y],mxy,species);
    
    im = zeros(length(xint),length(yint));
    im(:) = j;
    tit = sprintf('x = %d; y = %d',a,b);
    aux_imprintS(im,tit)
    colormap('hsv')

    xlabel(ftNames(a));
    ylabel(ftNames(b));