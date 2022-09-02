% Generate complementary classification matrix
% Type 3: Very similar to Type 1 except in the condition of individual
% errors
% Warning: the way the error is normalized may cause problems in the future
% when applying the method to regression types of data.
function ccMatrix = genCCmatrix7(sols,numPat)
% Extract basic information (e.g. error patterns)
errPats = sols(:,2:2+numPat-1);
% Assume errors are min/max 0/1
errPats = errNormalize(errPats,0.15);
numSols = size(sols,1);
% Initialize ccMatrix
ccMatrix = zeros(numSols,numSols);
% Double scan error patterns
aFac = 27/(numPat^3);
for si1=1:numSols
    for si2=1:numSols
        
        if si2 <= si1
            ccMatrix(si1,si2) = 1;
            continue;
        end
        
        % Compute complementary error
        errPat1 = errPats(si1,:);
        errPat2 = errPats(si2,:);
        
        [n11 n10 n01 n00] = computeNs(errPat1,errPat2);
        
        ccQual = aFac * (n00 * n01 * n10); % n00 means no-err/no-err
        ccError = 1-ccQual;
        ccMatrix(si1,si2) = ccError;

    end
end

% Normalize
minCCerror = min(min(ccMatrix));
ccMatrix = ccMatrix - minCCerror;
maxCCerror = max(max(ccMatrix));
if maxCCerror > 0
    aFac = 1.0/maxCCerror;
    ccMatrix = ccMatrix * aFac;
end

%disp('Que?');



end

