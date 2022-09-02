% Basic cross-over operator
function coSols = doCrossOver1(sols,memParams)

coSols = [];
numPat = memParams.numPat;

% Scan through solutions
for si=1:memParams.numCOSol
    aCOSol = crossOverSolCC(sols(:,2+numPat:end),memParams);
    errPat = ones(1,numPat);
    coSols = [coSols; -1 errPat aCOSol];
end



end

