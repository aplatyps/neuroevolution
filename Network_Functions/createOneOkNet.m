function aNet = createOneOkNet(data,limits,memParams)

% Optimization parameters
if nargin < 3
    memParams.initSolFunc = 'initSolRand'; % 'initSolVar';
    memParams.costFuncName = 'evalKPH2PR1cc';
    memParams.maxIter = 10; % max. num. of optimization iterations
    memParams.maxEval = Inf; % max. num. of evaluations
    memParams.minCost = 0; % minimum cost stopping condition
    %memParams.ngSize = 6; % size of next generation
    memParams.optimArchit = false; % the default is only optimize weights & function parameters
    memParams.ngSize = 20; % size of next generation
    memParams.percTrim = 0.4; % NG-percentage of solutions to trim off the DE expanded solution set
    memParams.numSolParams = compExpectNumParamKPH3(numNodes.I,numNodes.M,numNodes.O);; % number of parameters in solution
    memParams.paramRange = [0 1]; % range of solution parameter values
    memParams.minDiffLF = 0.1; % minimum difference between a leader and its immediate follower (see N1)
    %memParams.minDiffLL = 0.3; % min. difference between two consecutive leaders (see N1)
    memParams.minDiffLL = 0.5; %0.5;
    memParams.trimMethod = 0;
    memParams.minDiffTrim = 0.3; % 0.1 % minimum difference between sol. to be kept in the trimmed set
    %memParams.alpha = 0.25; % DE rate; proportion to be applied to (leader-follower).
    memParams.alpha = 0.15;%0.9;% 0.15;
    memParams.gvAmplify = 20;
    memParams.mutRange = 0.2; % range of mutation (if range=0.2 mutations go from -0.2 to +0.2)
    memParams.mutProb = 0.5; %0.75; %0.8; %0.5; % probability of mutating a particular parameter
    %memParams.fixParams = []; % [param1 val1; param2 val2 ...] Specify what parameters to fix to what value
    memParams.vis_verbose = 2; % verbosity (0: nothing; 1: text; 2: plot cost; 3: plot cost & sol. var. 4: cost and solution param
    memParams.saveEveryXgen = Inf; % save every x generations
    memParams.storeIterBestSol = true; % store the best solution for every iteration?
    memParams.ndm = true; % optimizing NDMs?
    % "Deconstructed GSO" parameters
    memParams.doCrossOver = false;
    memParams.doProbMingle = true; memParams.probMingleType = 1;
    memParams.doMutation = true;
    memParams.doDiffEvol = false;
    memParams.doIL = false;
    memParams.numCOSol = 10;
    memParams.numPMSol = 10;
    memParams.numMSol = 10;
    memParams.maxDESol = 10;
    % Individual learning parameters
    memParams.ilType = 8; % see doIndivLearn1 for the meaning of different types
    memParams.ilEveryGen = 1; % if x then do invidual learning every x generations
    memParams.ilNumSol = 10; % number of solutions to be targetted for individual learning
    memParams.ilNumParam = 2; % number of parameters to be targetted for individual learning
    memParams.ilNumIter = 10; % number of individual learning (local search) iterations
    %memParams.ilRandType = 1; % type of learning (1: new rand vals, 2: rand perturbations)
    memParams.pairSelect = 2;
    % CC parameters
    memParams.ccMatrixType = 3;
    memParams.maxCCerr4solsel = 0.25;
end

if nargin < 2
    % ************** Network parameters
    % Num nodes
    numNodes.I = 2;
    numNodes.M = 4;
    numNodes.O = 1;
    % Limits
    limits.numNodes = numNodes;
    limits.maxIter = 5;
    limits.P_minWB = -1;
    limits.P_maxWB = 1;
    limits.sig_minFP = 0.3;
    limits.sig_maxFP = 3;
    limits.gaus_minFP1 = 0.3; % Gaussian steepness
    limits.gaus_maxFP1 = 3; % Gaussian steepness
    limits.gaus_minFP2 = 0; % Gaussian top cut-off threshold [if min/max = 0/2 smooth & abrupt; if 1/2 only smooth]
    limits.gaus_maxFP2 = 2; % % Gaussian top cut-off threshold
    limits.allNodesExist = true; % if true: all nodes must exist
    limits.allConExist = true; % if true: all connections must exist
    limits.weightFunctions = [1 2 3 4 5 6 7]; %[1 2 3 4 5 6 7]; %[1 2 3 4 5]; which weight functions to select from
    limits.nodeFunctions = [1 2 3]; % which node functions to select from
    limits.inNoIn = true; % if true: inputs can't receive connections from the net.
    limits.outNoOut = true; % if true: outputs can't send connections to the net.
    limits.noIn2Out = true; % if true: no connections from inputs to outputs
    limits.noMid2Mid = false; % if true: no lateral connections between middle nodes
    limits.allWFpresent = false; % if true: all listed weight functions must be used
else
   numNodes = limits.numNodes; 
end

% *** Optimize
data.numNodes = numNodes;
data.limits = limits;
[ps totEval totGen] = memeticO1pure(memParams.costFuncName,data,memParams);
aNet = createKPH2sol(numNodes,limits,ps{1}.rawParam,[]);


end

