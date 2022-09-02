% Individual learning based on differential evolution
% Scan through solutions that are intended for IL.
% For each solution select a random solution. Evalute both. Create velocity
% and apply.
function [nextGenS numEval] = indivLearn4(nextGenS,selSol,memParams,data)
% Basic parameters
alpha = 0.5;
numPat = size(data.in,1);
funcName = memParams.costFuncName;
% Basic information
numSelSol = size(selSol,2);
totSol = size(nextGenS,1);
totParam = size(nextGenS,2)-1-numPat; % -1 because of cost and errPat
numParam = memParams.ilNumParam;
% Go through solutions
numEval = 0;
paramStartIndx = 2+numPat;
errPatEndIndx = 2+numPat-1;
for si=1:numSelSol
    aSolParam = nextGenS(selSol(si),paramStartIndx:end);
    aSolCost = nextGenS(selSol(si),1);
    aSolErrPat = nextGenS(selSol(si),2:errPatEndIndx);
    % Loop through number of local search iterations
    curBestCost = aSolCost;
    curBestSol = aSolParam;
    curBestErrPat = aSolErrPat;
    % Select a random subset of parameters to focus on
    paramInds = randperm(totParam);
    selParam = paramInds(1:numParam);
    for iter=1:memParams.ilNumIter
        
        % Select a random solution
        rsoli = ceil(rand*totSol);
        % Establish leader/follower
        rsolcost = nextGenS(rsoli,1);
        rsolparam = nextGenS(rsoli,paramStartIndx:end);
        if rsolcost < curBestCost
            leader = rsolparam;
            follower = curBestSol;
        else
            leader = curBestSol;
            follower = rsolparam;
        end
        % Compute velocity
        veloc = alpha*(leader-follower);
        % Supress the unselected parameters
        veloc = modVecVals(veloc,selParam,0);
        % Apply velocity to leader and follower & normalize
        newLeader = leader+veloc;
        newFollower = follower+veloc;
        newLeader = normSol(newLeader,memParams.paramRange);  % because of <0 and >1
        newFollower = normSol(newFollower,memParams.paramRange);  % because of <0 and >1
        % Evaluate solutions
        %splicedNewLeader = spliceOut(newLeader,memParams.silentParam);
        %splicedNewFollower = spliceOut(newFollower,memParams.silentParam);
        [newLeadCost data fs newLeadErrPat] = feval(funcName, newLeader, data);
        [newFollowCost data fs newFolErrPat] = feval(funcName, newFollower, data);
        % If best is better than current best, keep
        vecCosts = [curBestCost newLeadCost newFollowCost];
        [val ind] = min(vecCosts);
        if ind == 2
            curBestCost = newLeadCost;
            curBestErrPat = newLeadErrPat;
            curBestSol = newLeader;
        elseif ind == 3
            curBestCost = newFollowCost;
            curBestErrPat = newFolErrPat;
            curBestSol = newFollower;
        end
        
        numEval = numEval + 2;
  
    end
    if curBestCost < aSolCost
        nextGenS(selSol(si),:) = [curBestCost curBestErrPat curBestSol];
    end
    
end

end




