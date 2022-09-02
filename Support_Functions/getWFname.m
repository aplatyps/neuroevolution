% ------ Weight functions
% 1 - inner product -> 'ipWF1'
% 2 - Euclidean distance -> 'edWF1'
% 3 - Higher-order (HO) product 1 -> 'hoWF1'
% 4 - Higher-order (HO) product 2 (standard) -> 'hoWF2'
% 5 - Standard deviation -> 'sdWF1'
% 6 - MIN -> 'minWF1'
% 7 - MAX -> 'maxWF1'
function wfName = getWFname(wfNum)

    switch wfNum
        case 1
            wfName = 'ipWF1';
        case 2
            wfName = 'edWF1';
        case 3
            wfName = 'hoWF1';
        case 4
            wfName = 'hoWF2';
        case 5
            wfName = 'sdWF1';
        case 6
            wfName = 'minWF1';
        case 7
            wfName = 'maxWF1';
        otherwise
            wfName = -1;
    end


end

