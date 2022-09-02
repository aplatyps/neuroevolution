% Generate complementary classification matrix
% Type 5: This is not a complementary classification measure. This measure
% represents the combined error of each individual solution; so ccMat-5 is more of a control condition. 
function ccMatrix = genCCmatrix5(sols,numPat)
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
        
        err1 = (sum(errPat1)/numPat);
        err2 = (sum(errPat2)/numPat);
        
        ccMatrix(si1,si2) = (err1+err2)/2;
        
    end
end

% Normalize
minCCerror = min(min(ccMatrix));
ccMatrix = ccMatrix - minCCerror;
maxCCerror = max(max(ccMatrix));
aFac = 1.0/maxCCerror;
ccMatrix = ccMatrix * aFac;



end

