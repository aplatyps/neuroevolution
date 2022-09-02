% ------ Node functions
% 1 - identity -> 'idNF'
% 2 - sigmoid -> 'sigNF1'
% 3 - Gaussian -> gausNF1'
function nfName = getNFname(nfNum)

switch nfNum
    case 1
        nfName = 'idNF';
    case 2
        nfName = 'sigNF1';
    case 3
        nfName = 'gausNF1';
    otherwise
        nfName = -1;
end


end

