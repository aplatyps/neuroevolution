% Generate complementary classification matrix
% Type 2: sum of all errors ...
function ccMatrix = genCCmatrix1(sols,numPat)
% Type 2: sum errors
% Extract basic information (e.g. error patterns)
errPats = sols(:,2:2+numPat-1);
numSols = size(sols,1);
% Initialize ccMatrix
ccMatrix = zeros(numSols,numSols);
% Double scan error patterns
for si1=1:numSols
    for si2=1:numSols 
        if si2 < si1
            ccMatrix(si1,si2) = 1;
            continue;
        end
        % Compute complementary error
        errPat1 = errPats(si1,:);
        errPat2 = errPats(si2,:);
        ccError = (sum(errPat1)+sum(errPat2))/(numPat*2);
        ccMatrix(si1,si2) = ccError;  
    end
end

% Normalize
minCCerror = min(min(ccMatrix));
ccMatrix = ccMatrix - minCCerror;
maxCCerror = max(max(ccMatrix));
aFac = 1.0/maxCCerror;
ccMatrix = ccMatrix * aFac;



end

