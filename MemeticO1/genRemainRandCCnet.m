% Function for expanding the trimmed solution set via mutation and cross-over
function nextGen = genRemainRandCCnet(trimSol,memParams)
% Extract basic information
numTrimSol = size(trimSol,2);
numTotSol = memParams.ngSize;
bestNet = trimSol{1};
% Determine how many solutions remain to be generated
numRemainSol = numTotSol-numTrimSol;

% Generate remaining solutions randomly
memParams.ngSize = numRemainSol;
[newSols numEval] = initSolRandNet(memParams,bestNet);

nextGen = [trimSol newSols];

