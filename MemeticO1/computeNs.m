% Compute Ns (see Q statistics)
% Note that 1 here means error
function [n11 n10 n01 n00] = computeNs(errPat1,errPat2)
% Extract basic information
numPat = size(errPat1,2);
% Initialize
n11 = 0; n10 = 0; n01 = 0; n00 = 0;
% Scan errors
for pi=1:numPat
    % Compute
    if errPat1(pi) == 1 && errPat2(pi) == 1
        n11 = n11 + 1;
    elseif errPat1(pi) == 0 && errPat2(pi) == 0
        n00 = n00 + 1;
    elseif errPat1(pi) == 1 && errPat2(pi) == 0
        n10 = n10 + 1;
    else
        n01 = n01 + 1;
    end
end


end

