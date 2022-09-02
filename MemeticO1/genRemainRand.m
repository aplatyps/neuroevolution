% Function for expanding the trimmed solution set via mutation and cross-over
function nextGen = genRemainRand(trimSol,memParams)
% Extract basic information
[yLeng xLeng] = size(trimSol);
numTrimSol = yLeng;
numTotSol = memParams.ngSize;
numParams = memParams.numSolParams;
minRange = memParams.paramRange(1);
diffRange = memParams.paramRange(2) - minRange;
% Determine how many solutions remain to be generated
numRemainSol = numTotSol-numTrimSol;
% Scan through remaining solutions
for si=1:numRemainSol
    % Randomly select either mutation, cross over or random
    randSol = minRange+rand(1,numParams)*diffRange;
    trimSol(numTrimSol+si,:) = [-1 randSol];
end
% Apply fixed parameters
nextGen = fixSolParam(trimSol,memParams.fixParams);

