% Basic cross-over operator
function difSols = doDifferential2(sols,memParams)

% Basic info
numPat = memParams.numPat;
[yLeng xLeng] = size(sols);
numSol = yLeng;
numParam = xLeng-1-memParams.numPat; % -1 because of cost & errPats
% Basic initializations
difSols = [];

% Scan through solutions
if memParams.pairSelect ~= 1
    ccMatrix = genCCmatrixGen(sols,memParams.numPat,memParams.ccMatrixType);
end
for si=1:memParams.numDESol
    
    % Select random solution indeces
    if memParams.pairSelect == 1
        [rsoli1 rsoli2] = selSolPair1(numSol);
    else
        [rsoli1 rsoli2] = selSolPair2(ccMatrix,memParams);
    end
    
    sol1 = sols(rsoli1,2+numPat:end);
    cost1 = sols(rsoli1,1);
    sol2 = sols(rsoli2,2+numPat:end);
    cost2 = sols(rsoli2,1);
    
    % Determine follower and leader
    if cost1 < cost2
        leader = sol1;
        follower = sol2;
    else
        leader = sol2;
        follower = sol1;
    end
   
    % Compute velocity & new solution
    velocVec = memParams.alpha*(leader-follower);
    newSol = leader + velocVec;
    newSol = normSol(newSol,memParams.paramRange);

    % Store solution
    errPat = ones(1,numPat);
    difSols = [difSols; -1 errPat newSol];
    
end



end

