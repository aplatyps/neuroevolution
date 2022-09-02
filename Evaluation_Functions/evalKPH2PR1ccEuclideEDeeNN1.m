% Optimize relative to some data-set
% ------ Types
% 1 - input node
% 2 - middle node (interneuron)
% 3 - output node
% ------ Weight functions
% 1 - inner product
% 2 - Euclidean distance
% 3 - Higher-order (HO) product
% 4 - HO subtractive "variability"
% 5 - Standard deviation
% 6 - MIN
% 7 - MAX
% ------ Node functions
% 1 - identity
% 2 - sigmoid
% 3 - Gaussian
% ------ Status
% 0 - does not exist
% 1 - exists
function [cost data funcStat errPat] = evalKPH2PR1ccEuclideEDeeNN1(aSolRaw,data)

doImbalTest = false;
if doImbalTest
    % Count number of 0s and 1s
    [numZeros numOnes] = countZeroesOnes(data.out);
end
    
% --- Extract basic information
numPatterns = size(data.in,1);
% *** Get num. nodes / layers etc.
limits = data.limits;
numNodes = limits.numNodes;
numLayers = size(numNodes,2);
architecture = limits.architecture;

% Initializations
funcStat = 1; % error
cost = Inf;
errPat = [];

% Check compatibility of num. inputs and data
if numNodes(1) ~= size(data.in(1,:),2)
    disp('The number of input nodes is inconsistent with the data.');
    return
end

netSEDeeNN = createNetEDeeNN1(limits,aSolRaw);

% Computer error
[error errPat maxOutPat] = compEuclidErrPat2EDeeNN(netSEDeeNN,data);
cost = error;

funcStat = 0; % function completed without errors


end

