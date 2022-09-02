% Function for generating a solution from crossing-over two existing solutions
function coSol = crossOverSolCC(solutions,memParams)
% Extract basic information
[numSol numParam] = size(solutions);
% Check
if numSol == 1
    disp('Attempting to cross-over with only one solution in the set.');
    crossOverSol=-1;
    return
elseif numParam < 2
    disp('Too few parameters.');
    crossOverSol=-1;
    return
end

if memParams.pairSelect == 1
    % Randomly select solution-1 and solution-2
    riSol1 = ceil(rand*numSol);
    riSol2 = riSol1;
    while riSol2 == riSol1
        riSol2 = ceil(rand*numSol);
    end
else % select according to complementary classifications
   
    ccMatrix = genCCmatrixGen(solutions,memParams.numPat,memParams.ccMatrixType);
    [riSol1 riSol2] = selSolPair2(ccMatrix);
    
end
% Randomly select cut-off point
cutOffPoint = ceil(rand*(numParam-1));
% Combine solutions into a new solution
solution1 = solutions(riSol1,:);
solution2 = solutions(riSol2,:);
coSol = [solution1(1,1:cutOffPoint) solution2(1,cutOffPoint+1:numParam)];