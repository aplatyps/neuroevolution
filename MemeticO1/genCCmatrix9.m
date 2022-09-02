% Generate complementary classification matrix
% Type 8: Very similar to Type 6 except that first order difficulty is
% added to the Qcc equation
% Warning: the way the error is normalized may cause problems in the future
% when applying the method to regression types of data.
function ccMatrix = genCCmatrix9(sols,numPat)
% Extract basic information (e.g. error patterns)
errPats = sols(:,2:2+numPat-1);
% Compute pattern difficulties
patDiffic = sum(errPats);
maxDiffic = max(patDiffic);
patDiffic = patDiffic/maxDiffic;
% Assume errors are min/max 0/1
errPats = errNormalize(errPats,0.15);
numSols = size(sols,1);
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
        
        %diffic = comp1stOrderDiffic(patDiffic,errPat1,errPat2);
        %[n11 n10 n01 n00] = computeNs(errPat1,errPat2);
        %ccQual = (aFac * (n00 * (n01 + n10)))+diffic; % n00 means no-err/no-err
        
        [z11 z10 z01 z00] = computeZs(patDiffic,errPat1,errPat2);
        ccQual = z00*z10*z01;
        
        ccMatrix(si1,si2) = ccQual;

    end
end

% Normalize
minCCqual = min(min(ccMatrix));
ccMatrix = ccMatrix - minCCqual;
maxCCqual = max(max(ccMatrix));
ccMatrix = ccMatrix / maxCCqual;
ccMatrix = 1-ccMatrix;



end

