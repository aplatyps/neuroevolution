function [bestCCind bestCCerr] = getBestCCpair(sols,numPat)
% Extract basic information
numSols = size(sols,1);
% Scan through sol1
bestCCerr = Inf;
errPatFirst = 2;
errPatLast = 1+numPat;
bestCCind = [-1 -1];
for si1=1:numSols
    % Extract error pattern 1
    errPat1 = sols(si1,2:errPatFirst+errPatLast);
    % Scan through sol2
    for si2=1:si1-1
        % Extract error pattern 2
        errPat2 = sols(si2,2:errPatFirst+errPatLast);
        % Compute ccErr
        aCCerr = sum(min([errPat1;errPat2]))/numPat;
        % Better than current best? If so, store information
        if aCCerr < bestCCerr
            bestCCind = [si1 si2];
            bestCCerr = aCCerr;
        end
    end
end


end

