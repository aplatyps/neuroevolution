% --- Overview
% Simple function for testing different optimization algorithms on
% a particular neuroevolutionary framework
% --- Arguments
% data: actual dataset (e.g. data6).
% dataLabel1: label of dataset; used for results; (e.g. 'data6').
% layers with 4 hidden nodes each; 1 output).
function res = neuroevol(data,dataLabel)


% Experimental parameters
numTests = 30; %10;
propTrain = 1; % proportion of training data (vis-a-vis test data)

% Neural network parameters 
limits.architecture = 1; % any node, any TF. (1 = no constraints, 2 = semi-constrainted; 3 = constrained)
limits.numNodes = [2 6 6 1];
limits.P_minWB = -1;
limits.P_maxWB = 1;
limits.sig_minFP = 0.3;
limits.sig_maxFP = 3;
limits.gaus_minFP1 = 0.01; %0.3; % Gaussian steepness
limits.gaus_maxFP1 = 10; %3; % Gaussian steepness
limits.gaus_minFP2 = 0; % Gaussian top cut-off threshold
limits.gaus_maxFP2 = 2; % % Gaussian top cut-off threshold
limits.weightFunctions = [1 2 3 4 5 6 7]; %[1 2 3 4 5]; which weight functions to select from
limits.nodeFunctions = [1 2 3]; %[1 2 3]; which node functions to select from
ai = limits.architecture;

% Extract basic information
numPat = size(data.in,1);
numLayers = size(limits.numNodes,2);

% Optimization parameters for neuroevol
costFuncName = 'evalKPH2PR1ccEuclideEDeeNN1';
memParams.initSolFunc = 'initSolRand'; % 'initSolVar';
memParams.costFuncName = costFuncName;
memParams.maxIter = 50; % max. num. of optimization iterations
memParams.maxEval = Inf; % max. num. of evaluations
memParams.minCost = -Inf; % minimum cost stopping condition
memParams.ngSize = 24; % 12; % size of next generation
memParams.numLayers = numLayers;
memParams.percTrim = 0.4; % NG-percentage of solutions to trim off the DE expanded solution set
memParams.trimMethod = 0;
memParams.paramRange = [0 1]; % range of solution parameter values
memParams.minDiffLF = 0.1; % minimum difference between a leader and its immediate follower (see N1)
memParams.minDiffLL = 0.5; %0.5;
memParams.minDiffTrim = 0.3;
memParams.alpha = 0.15;%0.9;% 0.15;
memParams.gvAmplify = 20;
memParams.mutRange = 0.2; % range of mutation (if range=0.2 mutations go from -0.2 to +0.2)
memParams.mutProb = 0.5; %0.75; %0.8; %0.5; % probability of mutating a particular parameter
memParams.fixParams = []; % [param1 val1; param2 val2 ...] Specify what parameters to fix to what value
memParams.vis_verbose = 0; % verbosity (0: nothing; 1: text; 2: plot cost; 3: plot cost & sol. var. 4: cost and solution param
memParams.saveEveryXgen = Inf; % save every x generations
memParams.storeIterBestSol = false; % store the best solution for every iteration?
memParams.ndm = false; % optimizing NDMs? Optimizing combinations of NDMs.
memParams.numCOSol = 5;
memParams.numPMSol = 5;
memParams.numMSol = 5;
memParams.numDESol = 5;
memParams.doCrossOver = true;
memParams.doProbMingle = true;
memParams.doMutation = true;
memParams.doDiffEvol = true;
memParams.crossOverType = 3;
memParams.probMingleType = 1;
memParams.differentialType = 2;
memParams.pairSelect = 1;  % 1 = no CC
memParams.ccMatrixType = 1;
memParams.maxCCerr4solsel = 0.1;
memParams.initSolMaxError = 10;

% Some results packing
res.limits = limits;
res.memParams = memParams;
res.dataLabel = dataLabel;
res.data = data;

disp(['Architecture ' int2str(ai)]);

data.limits = limits;
numParamEachSol = compNumEDeeNNparam(limits);
memParams.numSolParams = numParamEachSol; % number of parameters in solution
% Loop through tests
for ti=1:numTests
    disp(['Test ' int2str(ti)]);
    % Create training and test set
    [trainData testData] = createTrainTestData(data,propTrain);
    % Train.
    [ps mres] = memeticO1pureSEDeeNN1(memParams.costFuncName,trainData,testData,memParams);
    %Store train error curve, layer change.
    res.neuroevol{ai}.trainErrors(ti,:) = mres.trainErrors;
    res.neuroevol{ai}.testErrors(ti,:) = mres.testErrors;
    res.neuroevol{ai}.layerChanges{ti} = mres.layerChanges;
    res.neuroevol{ai}.bestSol(ti,:) = ps{1}.rawParam;
    % Create and store best network
    aNet = createNetEDeeNN1(limits,ps{1}.rawParam);
    res.neuroevol{ai}.bestNet{ti} = aNet;  
end

end

