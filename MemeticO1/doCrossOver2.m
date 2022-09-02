% Basic cross-over operator
function coSols = doCrossOver2(sols,memParams)

% Basic info
numPat = memParams.numPat;
[yLeng xLeng] = size(sols);
numSol = yLeng;
numParam = xLeng-1-memParams.numPat; % -1 because of cost & errPats
% Basic initializations
coSols = [];

% Scan through solutions
if memParams.pairSelect ~= 1
    ccMatrix = genCCmatrixGen(sols,memParams.numPat,memParams.ccMatrixType);
end
for si=1:memParams.numCOSol
    
    % Select random solution indeces
    if memParams.pairSelect == 1
        [rsoli1 rsoli2] = selSolPair1(numSol);
    else % select according to complementary classifications
        [rsoli1 rsoli2] = selSolPair2(ccMatrix,memParams);
    end
    
    %disp(['rsoli1: ' int2str(rsoli1) '  rsoli2: ' int2str(rsoli2)]);
    
    sol1 = sols(rsoli1,2+numPat:end);
    cost1 = sols(rsoli1,1);
    sol2 = sols(rsoli2,2+numPat:end);
    cost2 = sols(rsoli2,1);
    
    % Select random cut-off point
    rcut = ceil(rand*numParam);
    if rcut < 2
        rcut = 2;
    elseif rcut == numParam
        rcut = rcut - 1;
    end
    
    % Cross-over
    aCOSol = [sol1(1:rcut) sol2(rcut+1:end)];
    
    errPat = ones(1,numPat);
    coSols = [coSols; -1 errPat aCOSol];
    
end



end

