% Compute Ns (see Q statistics)
% Note that 1 here means error
function [z11 z10 z01 z00] = computeZs(diffics,errPat1,errPat2)
% Extract basic information
numPat = size(errPat1,2);
% Initialize
z11 = 0; z10 = 0; z01 = 0; z00 = 0;
% Scan errors
for pi=1:numPat
    % Compute
    aDiffic = diffics(pi);
    if errPat1(pi) == 1 && errPat2(pi) == 1
        z11 = z11 + aDiffic;
    elseif errPat1(pi) == 0 && errPat2(pi) == 0
        z00 = z00 + aDiffic;
    elseif errPat1(pi) == 1 && errPat2(pi) == 0
        z10 = z10 + aDiffic;
    else
        z01 = z01 + aDiffic;
    end
end


end

