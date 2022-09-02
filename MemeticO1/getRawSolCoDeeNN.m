function solRaw = getRawSolCoDeeNN(solCEP,numPat)

% Extract basic information
numPop = size(solCEP,2);

% Scan populations
for pi=1:numPop    
    % Extract
    solRaw{pi} = solCEP{pi}(:,2+numPat:end);
end


end

