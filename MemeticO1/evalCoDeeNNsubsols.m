% Function for evaluating sub-solutions in a set of populations
function [allCosts allErrPat eval] = evalCoDeeNNsubsols(solutions,memParams,data)

% Basic info
numSubSol = size(solutions{1},1);
numPop = size(solutions,2);

allCosts = zeros(numSubSol,numPop);
% Initialize average error patterns
for ssi=1:numSubSol
    for pi=1:numPop
        allErrPat{ssi}{pi} = 0;
    end
end
% Loop through evaluations
for ti=1:memParams.testPerSubSol
    % Create permuted matrix of subsol indeces
    matSubSolInd = createMatSubSolIndRP(numPop, numSubSol);
    % Loop through combined solutions
    for soli=1:numSubSol
        % Create solution (combine sub-solutions)
        aSol = combineSubSols(matSubSolInd(soli,:),solutions);
        % Evaluate solution
        [aCost data fs errPat] = feval(memParams.costFuncName,aSol,data);
        % Store costs in subSolCosts
        for pi=1:numPop
            rowi = matSubSolInd(soli,pi);
            allCosts(rowi,pi) = allCosts(rowi,pi) + aCost;
            allErrPat{rowi}{pi} = allErrPat{rowi}{pi} + (errPat/memParams.testPerSubSol);
        end
    end
end
% Average costs for each sub-sol
allCosts = allCosts/memParams.testPerSubSol;

eval = memParams.testPerSubSol * numSubSol;


end

