function ccInfo = compCCinfo3(sols,numPat)
% Extract basic information
errPats = sols(:,2:1+numPat);
numSols = size(sols,1);
% Initialiation
ccInfo = zeros(1,7);
% >>> Error of best solution
% Scan through error patterns % Recomputed because of shared fitness; not
% the best design but hopefully improves maintainability ...
bestErr = Inf;
for si=1:numSols
    % Compute individual errors
    thisError = sum(errPats(si,:))/numPat;
    % Keep track of best and store
    if thisError < bestErr
        bestErr = thisError;
    end
end
ccInfo(1) = bestErr;
% >>> Error of best complementary pair
[bestCCind bestCCerr] = getBestCCpair(sols,numPat);
ccInfo(2) = bestCCerr;
% >>> Error difference between solutions of best CC pair
si1 = bestCCind(1); si2 = bestCCind(2);
ccInfo(3) = abs(sols(si1,1)-sols(si2,1));
% >>> Mean error of generation
ccInfo(4) = mean(sols(:,1));
% >>> Standard deviation of mean of error for each pattern
ccInfo(5) = std(mean(errPats));
% >>> Number of sol pairs with ccErr < 0.05 and overlap > 0
ccInfo(6) = countCCpairs1(sols,numPat);
% Overall CC error
ccInfo(7) = sum(min(errPats))/numPat;



end

