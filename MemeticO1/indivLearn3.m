% Basic individual learning:
% 1) self cross-over
function [nextGenS numEval] = indivLearn3(nextGenS,selSol,memParams,data)
funcName = memParams.costFuncName;
numSol = size(selSol,2);
totParam = size(nextGenS,2)-1; % -1 because of cost
% Go through solutions
numEval = 0;
for si=1:numSol
    aSolParam = nextGenS(selSol(si),2:end);
    aSolCost = nextGenS(selSol(si),1);
    % Loop through number of local search iterations
    curBestCost = aSolCost;
    curBestSol = aSolParam;
    for iter=1:memParams.ilNumIter
        % location for self-cross-over
        loc = ceil(rand*totParam);
        newSol = [curBestSol(loc:end) curBestSol(1:loc-1)];
        %splicedNewSol = spliceOut(newSol,memParams.silentParam);
        [aCost thisCostTerms evalParams data fs] = feval(funcName, newSol, data);
        numEval = numEval + 1;
        % Keep if better
        if aCost < curBestCost
            curBestCost = aCost;
            curBestSol = newSol;
            break
        end
    end
    if curBestCost < aSolCost
        nextGenS(selSol(si),:) = [curBestCost curBestSol];
    end
    
end

end




