% Selection heuristics probabilistically
function [memParams curHeuristIndex] = selectHeuristics(memParams,heuristicPerform)
% Basic info
numHeuristics = size(heuristicPerform.probs,1);
% Cumulative probability
cumulProb = zeros(numHeuristics,1);
cumulProb(1,1) = heuristicPerform.probs(1);
for hi=2:numHeuristics
    cumulProb(hi,1) = cumulProb(hi-1,1)+heuristicPerform.probs(hi);
end
% Select heuristic
randVal = rand;
for hi=1:numHeuristics
    if randVal <= cumulProb(hi)
       curHeuristIndex = hi;
       break
    end
end
memParams.doCrossOver = memParams.heuristicList(curHeuristIndex,1);
memParams.doProbMingle = memParams.heuristicList(curHeuristIndex,2);
memParams.doMutation = memParams.heuristicList(curHeuristIndex,3);
memParams.doDiffEvol = memParams.heuristicList(curHeuristIndex,4);
memParams.doIL = memParams.heuristicList(curHeuristIndex,5);




end




