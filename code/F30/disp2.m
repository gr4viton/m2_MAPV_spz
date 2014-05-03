function [ ] = disp2( indention, msg )
%DISP displays the message with an indention from iDISP global variable
%   

switch(indention)
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

