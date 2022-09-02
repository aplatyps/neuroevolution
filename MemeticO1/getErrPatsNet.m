% Extract costs from a set of solutions
function errPats = getErrPatsNet(sols)
numSols = size(sols,2);
errPats = [];
for si=1:numSols
    errPats = [errPats; sols{si}.errPat];
end

end

