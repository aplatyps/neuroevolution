% Pre-pend costs and error patterns to sub-solutions in different
% populations
function solsCEP = addCostsErrPat(sols,costs,errPats)

% Extract basic information
numSubSol = size(sols{1},1);
numPop = size(sols,2);
numPat = size(errPats{1}{1},2);

% Initialization
for pi=1:numPop
    numParam = size(sols{pi}(1,:),2);
    xleng = 1+numPat+numParam;
    solsCEP{pi} = zeros(numSubSol,xleng);
end

% Scan populations
for pi=1:numPop
    % Scan sub-solutions
    for ssi=1:numSubSol
        aCost = costs(ssi,pi);
        anErrPat = errPats{ssi}{pi};
        % Preprend cost and error patterns
        solsCEP{pi}(ssi,:) = [aCost anErrPat sols{pi}(ssi,:)];
    end
end

end

