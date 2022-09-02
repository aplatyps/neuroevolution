% Update performance storage and probability of selection
function heuristicPerform = upHeuristPerformType3(ins)

genWeight = 0.1;
improvEval = (ins.improv/ins.genEval)+(genWeight*ins.gen);
heuristicPerform = ins.heuristicPerform;

% Basic information
numHeuristic = size(heuristicPerform.probs,1);
% Add improvement/eval (store)
heuristicPerform.improvEvals{ins.curHeuristIndex} = [heuristicPerform.improvEvals{ins.curHeuristIndex} improvEval];
% Recompute probabilities
sumIE = zeros(numHeuristic,1);
for hi=1:numHeuristic
    sumIE(hi) = sum(heuristicPerform.improvEvals{hi});
end

if sum(sumIE) == 0
    probIE = ones(numHeuristic,1)*(1/numHeuristic);
else
    [oneNonZero onzi] = checkOneNonZero(sumIE);
    if oneNonZero
        for hi=1:numHeuristic
            if hi == onzi
                continue
            end
            sumIE(hi) = sumIE(onzi);
            heuristicPerform.improvEvals{hi} = heuristicPerform.improvEvals{onzi};
        end
    end
    probIE = sumIE/sum(sumIE);
end


heuristicPerform.probs = probIE;


end



