% Basic individual learning: select a subset of parameters and search
% randomly for better configurations
function [nextGenS numEval] = indivLearn1(nextGenS,selSol,gsoParams,funcName,data)
% Type of individual learning
if gsoParams.ilRandType == 1
    subModFunc = 'randSubMod1';
else     % if gsoParams.ilRandType == 2
    subModFunc = 'randSubMod2';
end

numSol = size(selSol,2);
totParam = size(nextGenS,2)-1; % -1 because of cost
numParam = ceil(totParam*gsoParams.ilPropParam);
% Go through solutions
numEval = 0;
for si=1:numSol
    aSolParam = nextGenS(selSol(si),2:end);
    aSolCost = nextGenS(selSol(si),1);
    % Select a random subset of parameters to focus on
    paramInds = randperm(totParam);
    selParam = paramInds(1:numParam);
    % Loop through number of local search iterations
    curBestCost = aSolCost;
    curBestSol = aSolParam;
    for iter=1:gsoParams.ilNumIter
        %newSol = randSubMod1(aSolParam,selParam,gsoParams);
        newSol = feval(subModFunc,curBestSol,selParam,gsoParams);
        [aCost thisCostTerms evalParams data fs] = feval(funcName, newSol, data);
        numEval = numEval + 1;
        % Keep if better
        if aCost < curBestCost
            curBestCost = aCost;
            curBestSol = newSol;
        end
    end
    if curBestCost < aSolCost
        nextGenS(selSol(si),:) = [curBestCost curBestSol];
    end
    
end

end

