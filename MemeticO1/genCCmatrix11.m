% Generate complementary classification matrix
% Type 3: Very similar to Type 1 except in the condition of individual
% errors
% Warning: the way the error is normalized may cause problems in the future
% when applying the method to regression types of data.
function ccMatrix = genCCmatrix11(sols,numPat)
% Extract basic information (e.g. error patterns)
errPats = sols(:,2:2+numPat-1);
% Normalize errors/distances to max error/distance 
maxErr = max(max(errPats));
if maxErr ~= 0
    errPats = errPats / maxErr;
end

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
        distPat1 = errPats(si1,:);
        distPat2 = errPats(si2,:);
        
        ccErr = sum(min(distPat1,distPat2))/numPat;
        %ccQual = 1-ccErr;
       
        %ccMatrix(si1,si2) = ccQual;
        ccMatrix(si1,si2) = ccErr;

    end
end

end

