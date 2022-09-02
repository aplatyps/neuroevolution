% Individual learning based on differential evolution
% Scan through solutions that are intended for IL.
% For each solution select a random solution. Evalute both. Create velocity
% and apply.
function [nextGenS numEval] = indivLearn6(nextGenS,selSol,memParams,data)
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
        newFollower = follower+veloc;
        newLeader = normSol(newLeader,memParams.paramRange);  % because of <0 and >1
        newFollower = normSol(newFollower,memParams.paramRange);  % because of <0 and >1
        % Evaluate solutions
        %splicedNewLeader = spliceOut(newLeader,memParams.silentParam);
        %splicedNewFollower = spliceOut(newFollower,memParams.silentParam);
        [newLeadCost thisCostTerms evalParams data fs] = feval(funcName, newLeader, data);
        [newFollowCost thisCostTerms evalParams data fs] = feval(funcName, newFollower, data);
        numEval = numEval + 2;
        % If best is better than current best, keep
        vecCosts = [curBestCost newLeadCost newFollowCost];
        [val ind] = min(vecCosts);
        improv = true;
        if ind == 2
            curBestCost = newLeadCost;
            curBestSol = newLeader;
            while improv % keep adding veloc until no improvement
                newLeader = newLeader+veloc;
                newLeader = normSol(newLeader,memParams.paramRange);
                %splicedNewLeader = spliceOut(newLeader,memParams.silentParam);
                [newLeadCost thisCostTerms evalParams data fs] = feval(funcName, newLeader, data);
                numEval = numEval + 1;
                if newLeadCost < curBestCost
                    curBestCost = newLeadCost;
                    curBestSol = newLeader;
                else
                    improv = false;
                end
            end
        elseif ind == 3
            curBestCost = newFollowCost;
            curBestSol = newFollower;
            while improv % keep adding veloc until no improvement
                newFollower = newFollower+veloc;
                newFollower = normSol(newFollower,memParams.paramRange);
                %splicedNewFollower = spliceOut(newFollower,memParams.silentParam);
                [newFollowCost thisCostTerms evalParams data fs] = feval(funcName, newFollower, data);
                numEval = numEval + 1;
                if newFollowCost < curBestCost
                    curBestCost = newFollowCost;
                    curBestSol = newFollower;
                else
                    improv = false;
                end
            end
        end
        
        
  
    end
    if curBestCost < aSolCost
        nextGenS(selSol(si),:) = [curBestCost curBestSol];
    end
    
end

end




