% Function for expanding the trimmed solution set via mutation and cross-over
function nextGen = genRemainSol(trimSol,gsoParams)
% Extract basic information
[yLeng xLeng] = size(trimSol);
numTrimSol = yLeng;
numTotSol = gsoParams.ngSize;
numParams = gsoParams.numSolParams;
minRange = gsoParams.paramRange(1);
diffRange = gsoParams.paramRange(2) - minRange;
% Determine how many solutions remain to be generated
numRemainSol = numTotSol-numTrimSol;
% Scan through remaining solutions
for si=1:numRemainSol
    % Randomly select either mutation, cross over or random
    triDec = round(rand*2);
    if triDec == 0 % mutate
        mutSol = mutateSol(trimSol(:,2:xLeng),gsoParams);
        trimSol(numTrimSol+si,:) = [-1 mutSol];
    elseif (triDec == 1) & (numTrimSol > 1) % cross-over
        coSol = crossOverSol(trimSol(:,2:xLeng));
        trimSol(numTrimSol+si,:) = [-1 coSol];
    else % random solution
        randSol = minRange+rand(1,numParams)*diffRange;
        trimSol(numTrimSol+si,:) = [-1 randSol];
    end
end
% Apply fixed parameters
nextGen = fixSolParam(trimSol,gsoParams.fixParams);

