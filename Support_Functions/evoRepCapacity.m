% Function for empirically determining the "early evolvability" and representational capacity of KPH2 networks
function erc = evoRepCapacity(net)

% Capacity test parameters
param.maxIter = 10; % number of iterations to train the weights
param.numPat = 8; % number of random patterns to use
param.numTests = 10; % number of tests (random patterns and labellings generated and tested (used for optimizing the net) )
param.inRange = [0 1]; % input range
param.outRange = [0 1]; % output range
param.evalFunc = 'evalKPH2PR1';
param.verbosity = 1;
% Extract basic information
param.numIn = net.numNodes.I; % Number of inputs
param.numOut = net.numNodes.O; % Number of outputs

% GSO parameters
gsoParams.initSolFunc = 'initSolRand'; % 'initSolVar';
gsoParams.costFuncName = param.evalFunc;
gsoParams.maxIter = param.maxIter; % max. num. of optimization iterations
gsoParams.minCost = 0; % minimum cost stopping condition
%gsoParams.ngSize = 6; % size of next generation
gsoParams.ngSize = 20; % size of next generation
gsoParams.percTrim = 0.4; % NG-percentage of solutions to trim off the DE expanded solution set
gsoParams.numSolParams = compExpectNumParamKPH2(net.numNodes.I,net.numNodes.M,net.numNodes.O); % number of parameters in solution
%gsoParams.numSolParams = 72; % number of parameters in solution
gsoParams.paramRange = [0 1]; % range of solution parameter values
gsoParams.minDiffLF = 0.1; % minimum difference between a leader and its immediate follower (see N1)
%gsoParams.minDiffLL = 0.3; % min. difference between two consecutive leaders (see N1)
gsoParams.minDiffLL = 0.5; %0.5;
%gsoParams.minDiffTrim = 0.1; % minimum difference between sol. to be kept in the trimmed set
gsoParams.minDiffTrim = 0.3;
%gsoParams.alpha = 0.25; % DE rate; proportion to be applied to (leader-follower).
gsoParams.alpha = 0.15;
gsoParams.gvAmplify = 20;
gsoParams.mutRange = 0.2; % range of mutation (if range=0.2 mutations go from -0.2 to +0.2)
gsoParams.mutProb = 0.8; %0.5; % probability of mutating a particular parameter
gsoParams.fixParams = []; % [param1 val1; param2 val2 ...] Specify what parameters to fix to what value
gsoParams.vis_verbose = 0; % verbosity (0: nothing; 1: text; 2: plot cost; 3: plot cost & sol. var.)
gsoParams.saveEveryXgen = Inf; % save every x generations


vecImprov = [];
vecCosts = [];
% Loop through tests
for ti=1:param.numTests
    if param.verbosity == 1
       disp(['Test ' int2str(ti)]); 
    end
    % Generate random patterns
    % Generate random labelings
    data = createData4ERC(param);
    data.net = net;
    % Try to optimize the network
    if param.verbosity == 1
        disp('Optimizing ...');
    end
    [psData netData] = GSO_1(param.evalFunc,data,gsoParams);
    % Compute current cost proportion relative to initial cost (1-prop =
    % improvement)
    anImprov = 1-(netData.vecCosts(end)/netData.vecCosts(1));
    aCost = netData.vecCosts(end);
    if param.verbosity == 1
        disp(['Cost: ' num2str(aCost) '   Improvement: ' num2str(anImprov)]);
    end
    % Store results (improvement and cost)
    vecImprov = [vecImprov anImprov];
    vecCosts = [vecCosts aCost];
end
% Compute some of the results
avrgImprov = mean(vecImprov);
avrgCost = mean(vecCosts);
improvStdError = std(vecImprov)/sqrt(param.numTests);

% Package results
erc.net = net;
erc.param = param;
erc.vecImprovs = vecImprov;
erc.vecCosts = vecCosts;
erc.avrgImprov = avrgImprov;
erc.improvStdErr = improvStdError;
erc.avrgCost = avrgCost;


end

