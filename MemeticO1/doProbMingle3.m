% Basic cross-over operator
% Not probabilistic: just select the "better" parameter.
function pmSols = doProbMingle3(sols,memParams)

pmSols = [];
[yLeng xLeng] = size(sols);
numSol = yLeng;
numParam = xLeng-1-memParams.numPat; % -1 because of cost & errPats
globMinCost = min(sols(:,1));
numPat = memParams.numPat;

% Scan through solutions
for si=1:memParams.numPMSol
    
    aPMSol = zeros(1,numParam);
    % Select solution indeces
    if memParams.pairSelect == 1 |  memParams.pairSelect == 0% random
        [rsoli1 rsoli2] = selSolPair1(numSol);
    else % select according to complementary classifications
        ccMatrix = genCCmatrixGen(sols,memParams.numPat,memParams.ccMatrixType);
        [rsoli1 rsoli2] = selSolPair2(ccMatrix,memParams);
    end
   
    sol1 = sols(rsoli1,2+numPat:end);
    cost1 = sols(rsoli1,1);
    sol2 = sols(rsoli2,2+numPat:end);
    cost2 = sols(rsoli2,1);
     
    % Scan parameters and select probabilistically
    for pi=1:numParam
        if cost1 <= cost2
            aPMSol(pi) = sol1(pi);
        else
            aPMSol(pi) = sol2(pi);
        end
    end

    errPat = ones(1,numPat);
    pmSols = [pmSols; -1 errPat aPMSol];
    
end



end

