% Compute new costs; replace;
% Simple fitness sharing based on complementary classifications
function sols = fitnessShare1(sols,ccMatrix)
% Extract basic information
numSols = size(sols,1);
% Scan through solutions
for si=1:numSols
    % Search for min cc error (along corresponding row and column)
    minRow = min(ccMatrix(si,:));
    minCol = min(ccMatrix(:,si));
    newErr = min(minRow,minCol);
    % Replace old error by cc error
    sols(si,1) = newErr;
end


end

