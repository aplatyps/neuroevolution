% Individual learning based on differential evolution
% Scan through solutions that are intended for IL.
% For each solution select a random solution. Evalute both. Create velocity
% and apply.
function [nextGenS numEval] = indivLearn7(nextGenS,selSol,memParams,data)
% Basic parameters
alpha = 0.5;
funcName = memParams.costFuncName;
% Basic information
numSelSol = size(selSol,2);
totSol = size(nextGenS,1);
totParam = size(nextGenS,2)-1; % -1 because of cost
numParam = memParams.ilNumParam;
% Go through solutions
numEval = 0;
for si=1:numSelSol
    aSolParam = nextGenS(selSol(si),2:end);
    aSolCost = nextGenS(selSol(si),1);
    % Loop through number of local search iterations
    curBestCost = aSolCost;
    curBestSol = aSolParam;
    % Select a random subset of parameters to focus on
    paramInds = randperm(totParam);
    selParam = paramInds(1:numParam);
    for iter=1:memParams.ilNumIter
        % Select a random solution
        rsoli = ceil(rand*totSol);
        % Establish leader/follower
        rsolcost = nextGenS(rsoli,1);
        rsolparam = nextGenS(rsoli,2:end);
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
        newLeader = normSol(newLeader,memParams.paramRange);  % because of <0 and >1
        % Evaluate solution
        %splicedNewLeader = spliceOut(newLeader,memParams.silentParam);
        [newLeadCost thisCostTerms evalParams data fs] = feval(funcName, newLeader, data);
        % If best is better than current best, keep
        vecCosts = [curBestCost newLeadCost];
        [val ind] = min(vecCosts);
        if ind == 2
            curBestCost = newLeadCost;
            curBestSol = newLeader;
        end
        
        numEval = numEval + 1;
  
    end
    if curBestCost < aSolCost
        nextGenS(selSol(si),:) = [curBestCost curBestSol];
    end
    
end

end




