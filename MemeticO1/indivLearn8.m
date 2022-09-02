% Individual learning based on differential evolution
% Scan through solutions that are intended for IL.
% For each solution select a random solution. Evalute both. Create velocity
% and apply.
% This is based on IL4 except that velocities can have different
% dimensionalities
function [nextGenS numEval] = indivLearn8(nextGenS,selSol,memParams,data)
% Basic info
numPat = memParams.numPat;
% Basic parameters
alpha = 0.5;
funcName = memParams.costFuncName;
% Basic information
numSelSol = size(selSol,2);
totSol = size(nextGenS,1);
totParam = size(nextGenS,2)-1-numPat; % -1 because of cost
numParam = memParams.ilNumParam;
% Go through solutions
numEval = 0;
paramStart = 2+numPat;
errPatEnd = 1+numPat;
for si=1:numSelSol
    aSolParam = nextGenS(selSol(si),paramStart:end);
    aSolCost = nextGenS(selSol(si),1);
    aSolErrPat = nextGenS(selSol(si),2:errPatEnd);
    % Loop through number of local search iterations
    curBestCost = aSolCost;
    curBestSol = aSolParam;
    curBestErrPat = aSolErrPat;
    % Select a random subset of parameters to focus on
    paramInds = randperm(totParam);
    randNumParam = ceil(rand*numParam);
    selParam = paramInds(1:randNumParam);
    for iter=1:memParams.ilNumIter
        
        % Select a random solution
        rsoli = ceil(rand*totSol);
        % Establish leader/follower
        rsolcost = nextGenS(rsoli,1);
        rsolparam = nextGenS(rsoli,paramStart:end);
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
        [newLeadCost thisCostTerms evalParams data fs newLeadEP] = feval(funcName, newLeader, data);
        [newFollowCost thisCostTerms evalParams data fs newFolEP] = feval(funcName, newFollower, data);
        % If best is better than current best, keep
        vecCosts = [curBestCost newLeadCost newFollowCost];
        [val ind] = min(vecCosts);
        if ind == 2
            curBestCost = newLeadCost;
            curBestSol = newLeader;
            curBestErrPat = newLeadEP;
        elseif ind == 3
            curBestCost = newFollowCost;
            curBestSol = newFollower;
            curBestErrPat = newFolEP;
        end
        
        numEval = numEval + 2;
  
    end
    if curBestCost < aSolCost
        nextGenS(selSol(si),:) = [curBestCost curBestErrPat curBestSol];
    end
    
end

end




