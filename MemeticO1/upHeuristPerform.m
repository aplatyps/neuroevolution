% Update performance storage and probability of selection
function heuristicPerform = upHeuristPerform(ins)

if ins.type == 1
    heuristicPerform = upHeuristPerformType1(ins);
elseif ins.type == 2
    heuristicPerform = upHeuristPerformType2(ins);
elseif ins.type == 3
    heuristicPerform = upHeuristPerformType3(ins);
end


end

