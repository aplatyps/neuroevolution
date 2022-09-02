% Function for extracting error patterns from a set of solutions
function errPats = extractErrPatsNet(sols)
numSols = size(sols,2);
errPats = [];
for si=1:numSols
    anErrPat = sols{si}.errPat;
    errPats = [errPats; anErrPat];
end

end

