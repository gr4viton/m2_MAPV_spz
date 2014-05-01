function [ ] = disp2( indentation, msg )
%DISP displays the message with an indention from iDISP global variable
%   
global disp2_level;
if disp2_level >= indentation
    switch(indentation)
        case(1)
            prefix = '> ';
        case(2)
            prefix = '  * ';
        case(3)
            prefix = '    - ';    
        otherwise
            prefix = '';    
    end
    disp([prefix,msg]);
end

end

