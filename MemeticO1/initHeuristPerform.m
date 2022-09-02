% Initialize heuristic performance structure
function heuristicPerform = initHeuristPerform(memParams)
% Basic info.
numCombHeuristics = size(memParams.heuristicList,1);
% Structure
heuristicPerform.probs = ones(numCombHeuristics,1)*(1/numCombHeuristics);
for hi=1:numCombHeuristics
    % Performance can be quite sensitive to this initial value: careful.
    % If it is much larger than the average cost improve per generation
    % then probabilities will change slowly. Conversely, probabilities will
    % change fast, early on and will become biased towards the early
    % improvers.
    %heuristicPerform.improvEvals{hi} = [0.01];
    % ---
    % Alternative: don't comp prob until all have at least one improv
    % observation (see upHeuristicsPerform).
    heuristicPerform.improvEvals{hi} = [];
end


end

