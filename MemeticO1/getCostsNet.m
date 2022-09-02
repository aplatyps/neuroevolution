% Extract costs from a set of solutions
function costVec = getCostsNet(sols)
numSols = size(sols,2);
costVec = zeros(1,numSols);
for si=1:numSols
    costVec(si) = sols{si}.cost;
end

end

