% Basic cross-over operator
function pmSols = doProbMingle4(sols,memParams)

pmSols = [];
[yLeng xLeng] = size(sols);
numSol = yLeng;
numParam = xLeng-1-memParams.numPat; % -1 because of cost & errPats
globMinCost = min(sols(:,1));
numPat = memParams.numPat;

if memParams.pairSelect == 2
    ccMatrix = genCCmatrixGen(sols,memParams.numPat,memParams.ccMatrixType); % errors
    allSolPairs = getSolPairs(ccMatrix); % qualities
end

% Scan through solutions
for si=1:memParams.numPMSol
    
    aPMSol = zeros(1,numParam);
    % Select solution indeces
    if memParams.pairSelect == 1 % random
        [rsoli1 rsoli2] = selSolPair1(numSol);
    else
        [rsoli1 rsoli2] = selSolPair3(allSolPairs,memParams,numSol);
    end
  
    sol1 = sols(rsoli1,2+numPat:end);
    cost1 = sols(rsoli1,1);
    sol2 = sols(rsoli2,2+numPat:end);
    cost2 = sols(rsoli2,1);
   
    if cost1 < cost2
        probOne = 0.75;
    else
        probOne = 0.25;
    end
    
    % Scan parameters and select probabilistically
    for pi=1:numParam
        randVal = rand;
        if randVal <= probOne
            aPMSol(pi) = sol1(pi);
        else
            aPMSol(pi) = sol2(pi);
        end
        
    end

    errPat = ones(1,numPat);
    pmSols = [pmSols; -1 errPat aPMSol];
    
end



end

