function mSols = doMutation(sols,memParams)


mSols = [];
numPat = memParams.numPat;

% Scan through solutions
for si=1:memParams.numMSol
    % Call adaptive mutation
    anMSol = mutateSol2(sols(:,2+numPat:end),memParams,sols(:,1));
    errPat = zeros(1,numPat);
    mSols = [mSols; -1 errPat anMSol];
end

end

