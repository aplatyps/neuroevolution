% Get "best" combined solution from a population of layers using multiple
% tries
function [bestRawSol bestCost] = getBestRawSolMT(sols1,sols2,costs1,costs2,memParams,data,numTries)

% Extract basic information
numPop = size(sols1,2);
numSubSol = size(sols1{1},1);

% Initializations
bestCosts = [];
bestRawSols = [];

% Get the best solution based on the best layers
bestRawSol1 = getBestRawSol(sols1,sols2,costs1,costs2);
[bestCost1 data fs errPat] = feval(memParams.costFuncName,bestRawSol1,data);
bestCosts = [bestCosts; bestCost1];
bestRawSols = [bestRawSols; bestRawSol1];

% Do remaining tries
for ti=2:numTries
    combinedSol = [];
    % Scan through populations/layers
    for pi=1:numPop
        % Choose old/new randomly and choose sub-solution randomly
        doNew = round(rand);
        randSub = ceil(rand*numSubSol);
        if randSub == 0
            randSub = 1;
        end
        % Append
        if ~doNew
            combinedSol = [combinedSol sols1{pi}(randSub,:)];
        else
            combinedSol = [combinedSol sols2{pi}(randSub,:)];
        end
    end
    % Evaluate and store
    [aCost data fs errPat] = feval(memParams.costFuncName,combinedSol,data);
    bestCosts = [bestCosts; aCost];
    bestRawSols = [bestRawSols; combinedSol];
end

% Select best
[minVal minIndex] = min(bestCosts);
bestRawSol = bestRawSols(minIndex,:);
bestCost = bestCosts(minIndex);


end

