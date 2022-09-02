% Generate complementary classification matrix
% Type 3: Very similar to Type 1 except in the condition of individual
% errors
function ccMatrix = genCCmatrixNet3(sols,numPat)
% Extract basic information (e.g. error patterns)
errPats = extractErrPatsNet(sols);

numSols = size(sols,2);
% Initialize ccMatrix
ccMatrix = zeros(numSols,numSols);
% Double scan error patterns
for si1=1:numSols
    for si2=1:numSols
        
        if si2 <= si1
            ccMatrix(si1,si2) = 1;
            continue;
        end
        
        % Compute complementary error
        errPat1 = errPats(si1,:);
        errPat2 = errPats(si2,:);
        ccError = sum(min([errPat1; errPat2]))/numPat;
        numOverlap = compOverlap(errPat1,errPat2);
        
        % Store complementary error
        err1 = (sum(errPat1)/numPat);
        err2 = (sum(errPat2)/numPat);
        %disp(['e1: ' num2str(err1) '  e2: ' num2str(err2)]);
        
        % --- The randGuesser check in this form did not work ... 
        %randGuesser1 = checkRandGuesser(errPat1);
        %randGuesser2 = checkRandGuesser(errPat2);
        %if (numOverlap >= 1) && (~randGuesser1) && (~randGuesser2)
        
        if (numOverlap >= 1) && ((err1 <= 0.499) || (err2 <= 0.499))
            ccMatrix(si1,si2) = ccError;
        else
            ccMatrix(si1,si2) = 1;
        end
    end
end

% Normalize
minCCerror = min(min(ccMatrix));
ccMatrix = ccMatrix - minCCerror;
maxCCerror = max(max(ccMatrix));
aFac = 1.0/maxCCerror;
ccMatrix = ccMatrix * aFac;



end

