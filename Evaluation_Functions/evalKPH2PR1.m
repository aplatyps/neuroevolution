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
function [cost costTerms evalParams data funcStat] = evalKPH2PR1(aSolRaw,data)

% *** Tests for imbalanced data-sets
% Note: later elaborate this so that it is more general (e.g. outputs with
% more than one node; outputs with a range of values (not just 0/1) )
doImbalTest = false;
if doImbalTest
    % Count number of 0s and 1s
    [numZeros numOnes] = countZeroesOnes(data.out);
end
% *******************************************
    
% Initializations
funcStat = 1; % error
cost = Inf;

% *** Get num. nodes and limits
gotNoLimits = false;
gotNoNumNodes = false;
if ~isempty(data) % got data
    if ~isempty(data.net) % if you have a network
        % Number of nodes
        numNodes.I = data.net.numNodes.I;
        numNodes.M = data.net.numNodes.M;
        numNodes.O = data.net.numNodes.O;
        % Limits
        limits = data.net.limits;
    else % no network
        if ~isempty(data.limits) % got limits information
            limits = data.limits;
            numNodes = limits.numNodes;
        else % no limits
            gotNoNumNodes = true;
            gotNoLimits = true;
        end
    end
else % no data
    gotNoNumNodes = true;
    gotNoLimits = true;
end

% Number of nodes
if gotNoNumNodes
    numNodes.I = 9;
    numNodes.M = 2;
    numNodes.O = 1;
end

% Limits
if gotNoLimits
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
    limits.allConExist = false; % if true: all connections must exist
    limits.weightFunctions = [1 2 3 4 5 6 7]; %[1 2 3 4 5 6 7]; %[1 2 3 4 5]; which weight functions to select from
    limits.nodeFunctions = [1 2 3]; % which node functions to select from
    limits.inNoIn = true; % if true: inputs can't receive connections from the net.
    limits.outNoOut = true; % if true: outputs can't send connections to the net.
    limits.noIn2Out = true; % if true: no connections from inputs to outputs
    limits.noMid2Mid = false; % if true: no lateral connections between middle nodes
    limits.allWFpresent = false; % if true: all listed weight functions must be used
end

% DO: Test evalPR1, and ERC

% Number of neurons
% if ~isempty(data.net)
%     numNodes.I = data.net.numNodes.I;
%     numNodes.M = data.net.numNodes.M;
%     numNodes.O = data.net.numNodes.O;
% else
%     numNodes.I = 2;
%     numNodes.M = 4;
%     numNodes.O = 1;
% end
% 
% % *** Parameter limits
% if isempty(data) | isempty(data.net)
%     limits.maxIter = 5;
%     limits.P_minWB = -1;
%     limits.P_maxWB = 1;
%     limits.sig_minFP = 0.3;
%     limits.sig_maxFP = 3;
%     limits.gaus_minFP = 0.3;
%     limits.gaus_maxFP = 3;
%     limits.allNodesExist = false; % if true: all nodes must exist
%     limits.allConExist = false; % if true: all connections must exist
%     limits.weightFunctions = [1 2 3 4 5]; %[1 2 3 4 5]; which weight functions to select from
%     limits.nodeFunctions = [1 2 3]; %[1 2 3]; which node functions to select from
% else
%     limits = data.net.limits;
% end

% Extract basic information
numParams = max(size(aSolRaw));
if numParams == 0 % return this information when e.g. [cost evalParams funcStat] = evalKPH2PR1([],[]);
    evalParams.numNodes = numNodes;
    evalParams.limits = limits;
    return
end
numPatterns = size(data.in,1);

% If the data has not been passed
if nargin < 2
    disp('Loading data ...');
    loadedData = load('DataMy/Data12img2D.mat');
    data = loadedData.data7;
end

% If we have passed a network with the data check compatibility
% if ~isempty(data.net)
%     if (data.net.numNodes.I ~= numNodes.I) || (data.net.numNodes.M ~= numNodes.M) || (data.net.numNodes.O ~= numNodes.O)
%         disp('Network incompatibility. Number of nodes differs.');
%         return
%     end
% end


% Load network architecture
% if limits.onlyOptimWeights 
%     % Load network
%     indata = load('kph2NetD3a.mat');
%     fixArchitNet = indata.net;
%     % Check compatibility
%     if (fixArchitNet.numNodes.I ~= numNodes.I) || (fixArchitNet.numNodes.M ~= numNodes.M) || (fixArchitNet.numNodes.O ~= numNodes.O)
%         disp('Network incompatibility. Number of nodes differs.');
%         return
%     end
% end

% Package limits (etc.)
evalParams.numNodes = numNodes;
evalParams.limits = limits;

% Check compatibility of num. inputs and data
if numNodes.I ~= size(data.in(1,:),2)
    disp('The number of input nodes is inconsistent with the data.');
    return
end
% Check compatibility of number of neurons and number of parameters
expectedNumParams = compExpectNumParamKPH3(numNodes.I,numNodes.M,numNodes.O);

if numParams ~= expectedNumParams
    disp('The number of parameters is inconsistent with what is expected from the network architecture.');
    disp(['Expected ' int2str(expectedNumParams) ' parameters.']);
    return
end


netKPH2 = createKPH2sol(numNodes,limits,aSolRaw,data.net);


% Scan through patterns
cost = 0;
for pati=1:numPatterns
    
    %selSample = rand;
    %if selSample > 0.8
    %    continue
    %end
    
    % Run pattern through KPH1 network
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pati,:),netKPH2);
    % Compute error
    anError = computeError1(netOut,data.out(pati,:));
    
    % *** Test imbalanced data
    if doImbalTest
        % Assuming one output; values = 0 or 1
        if data.out(pati,1) == 1
            anError = anError/numOnes;
        else
            anError = anError/numZeros;
        end
        
    end
    % ***********************
    
    % Add to cost
    cost = cost + anError;
end

cost = cost / numPatterns;

if limits.allWFpresent
    hasWFs = checkHasWFs(limits.weightFunctions, netKPH2);
    if ~hasWFs
        cost = Inf;
    end
end

funcStat = 0; % function completed without errors

evalParams.newNet = netKPH2;

costTerms = [];


end

