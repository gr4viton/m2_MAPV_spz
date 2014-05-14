function [ftCh, ftNames] = ...
    FT_addFeature(a_ftCh,a_ftVal,a_ftNames,a_name)

% name will be optional...

ftCh =    cat(1, a_ftCh,     a_ftVal);
ftNames = cat(1, a_ftNames,  a_name);

end