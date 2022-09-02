% Number of sol pairs with ccErr < 0.05 and overlap > 0
function numPairs = countCCpairs1(sols,numPat)
% Basic parameters
minErr = 0.05;
minOverlap = 1;
% Extract basic information
numSols = size(sols,1);
% Scan through sol1
errPatFirst = 2;
errPatLast = 1+numPat;
numPairs = 0;
for si1=1:numSols
    % Extract error pattern 1
    errPat1 = sols(si1,2:errPatFirst+errPatLast);
    % Scan through sol2
    for si2=1:si1-1
        % Extract error pattern 2
        errPat2 = sols(si2,2:errPatFirst+errPatLast);
        % Compute ccErr
        aCCerr = sum(min([errPat1;errPat2]))/numPat;
        % Compute overlap
        numOverlap = compOverlap(errPat1,errPat2);
        % Pass test?
        if (aCCerr < minErr) && (numOverlap >= minOverlap)
            numPairs = numPairs + 1;
        end
    end
end


end

