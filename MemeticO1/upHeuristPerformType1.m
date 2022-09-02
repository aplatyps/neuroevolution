% Update performance storage and probability of selection
function heuristicPerform = upHeuristPerformType1(ins)

improvEval = ins.improv/ins.genEval;
heuristicPerform = ins.heuristicPerform;

% Basic information
numHeuristic = size(ins.heuristicPerform.probs,1);
% Add improvement/eval (store)
heuristicPerform.improvEvals{ins.curHeuristIndex} = [heuristicPerform.improvEvals{ins.curHeuristIndex} improvEval];
% Recompute probabilities
sumIE = zeros(numHeuristic,1);
for hi=1:numHeuristic
    sumIE(hi) = sum(heuristicPerform.improvEvals{hi});
end

allNonZero = checkAllNonZero(sumIE);
% Until at least one improvement has been observed for each heuristic
% combination, keep probs uniform.
if allNonZero
    probIE = sumIE/sum(sumIE);
else
    probIE = ones(numHeuristic,1)*(1/numHeuristic);
end

heuristicPerform.probs = probIE;

end

