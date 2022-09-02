% Function for creating a layered KPH2 network based on parameters and limits
% ------ Arguments
% numNodes: numInputs (I), numMiddle (M), numOutput (O)
% limits: ranges for solution parameters
% ------ Types
% 1 - input node
% 2 - middle node (interneuron)
% 3 - output node
% ------ Weight functions
% 1 - inner product
% 2 - Euclidean distance
% 3 - Higher-order (HO) product
% 4 - HO "variability"
% 5 - "HO" standard deviation
% ------ Node functions
% 1 - identity
% 2 - sigmoid
% 3 - Gaussian
% ------ Status
% 0 - does not exist
% 1 - exists
% ------ Status of createKPH2sol
% 0 - no error
% 1 - error
% *** Notes ***********************
% - Create a layered architecture; recurrent connections allowed at the second layer (i.e. between middle nodes); the user
% can specify weight/node functions and function parameters
function [netKPH2 aSolRaw allOptions funcStat] = createLayeredKPH2(numNodes,aSolRaw,limits,layParam)

% Number of neurons
if nargin < 1
    numNodes.I = 3;
    numNodes.M = 3;
    numNodes.O = 3;
end
% Compute expected number of parameters and check discrepancy
expectNumParam = compExpectNumParamKPH2(numNodes.I,numNodes.M,numNodes.O);
if nargin < 2
    aSolRaw = rand(1,expectNumParam);
else
    actualNumParam = max(size(aSolRaw));
    if expectNumParam ~= actualNumParam
        disp(['The size of the parameter vector is inconsistent with the specified number of nodes.']);
        disp(['The parameter vector should have ' int2str(expectNumParam) ' parameters.']);
        return
    end
end

% Limits
if nargin < 3
    limits.maxIter = 5;
    limits.P_minWB = -1;
    limits.P_maxWB = 1;
    limits.sig_minFP = 0.3;
    limits.sig_maxFP = 3;
    limits.gaus_minFP = 0.3;
    limits.gaus_maxFP = 3;
    limits.allNodesExist = false; % if true: all nodes must exist
    limits.allConExist = false; % if true: all connections must exist
    limits.weightFunctions = [1 2 3 4 5]; %[1 2 3 4 5]; which weight functions to select from
    limits.nodeFunctions = [1 2 3]; %[1 2 3]; which node functions to select from
    limits.inNoIn = false; % if true: inputs can't receive connections from the net.
    limits.outNoOut = false; % if true: outputs can't send connections to the net.
end
% Layer 1 & 2: weight function, node function and function parameter
if nargin < 4
    layParam.numIter = 5; % number of iterations
    layParam.L1wf = 1; % layer 1 weight function
    layParam.L1nf = 2; % layer 1 node function
    layParam.L1nfp = [1]; % layer 1 node function parameter
    layParam.L2wf = 1; % layer 2 weight function
    layParam.L2nf = 2; % layer 2 node function
    layParam.L2nfp = [1]; % layer 2 node function parameter
    layParam.conMid2Mid = false; % lateral connections between middle nodes?
    layParam.conIn2Out = false; % connections from input to output nodes?
end
allOptions.limits = limits;
allOptions.layParam = layParam;
% Extract basic information
totNodes = numNodes.I+numNodes.M+numNodes.O;
numWeightFuncs = size(limits.weightFunctions,2);
numNodeFuncs = size(limits.nodeFunctions,2);
% Initializations
funcStat = 1;
nodesKPH2 = [];
conKPH2 = [];
paramIndex = 1;
conIndex = 1;
% Scan through parameters
% Create elements and parameters
% DBG: Check that the number of created parameters is the same as the
% expected number.

% Specify number of iterations
netKPH2.numIterations = layParam.numIter;
aParam = layParam.numIter/limits.maxIter;
aSolRaw(paramIndex) = aParam;
paramIndex = paramIndex + 1;

% *** Create input nodes.
% Input nodes have no inputs from the rest of the network, only from data.
for ii=1:numNodes.I
    nodesKPH2{ii}.type = 1;
    nodesKPH2{ii}.weightFunction = -1;
    nodesKPH2{ii}.nodeFunction = 1;
    nodesKPH2{ii}.autoWeight = 1;
    nodesKPH2{ii}.funcParam = [];
    nodesKPH2{ii}.bias = 0; % weights are setup in the connections
    nodesKPH2{ii}.value = 0;
    nodesKPH2{ii}.status = 1;
    nodesKPH2{ii}.inputs = [];
    nodesKPH2{ii}.outputs = [];
end

% *** Create middle nodes
startIndex = numNodes.I+1;
endIndex = startIndex+numNodes.M-1;
for mi=startIndex:endIndex
    % Node type
    nodesKPH2{mi}.type = 2;
    % Weight function
    nodesKPH2{mi}.weightFunction = layParam.L1wf;
    aParam = layParam.L1wf/numWeightFuncs;
    aSolRaw(paramIndex) = aParam;
    paramIndex = paramIndex + 1;
    % Node function
    nodesKPH2{mi}.nodeFunction = layParam.L1nf;
    aParam = layParam.L1nf/numNodeFuncs;
    aSolRaw(paramIndex) = aParam;
    paramIndex = paramIndex + 1;
    % Autoweight
    adjW = aSolRaw(paramIndex);
    paramIndex = paramIndex + 1;
    if nodesKPH2{mi}.weightFunction == 1
        adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
    end
    nodesKPH2{mi}.autoWeight = adjW;
    % Function parameter
    nodesKPH2{mi}.funcParam = layParam.L1nfp;
    if nodesKPH2{mi}.nodeFunction == 2 % sigmoid
        aParam = revPutInRange(layParam.L1nfp,limits.sig_minFP,limits.sig_maxFP);
    elseif nodesKPH2{mi}.nodeFunction == 3 % Gaussian
        aParam = revPutInRange(layParam.L1nfp,limits.gaus_minFP,limits.gaus_maxFP);
    else
        aParam = aSolRaw(paramIndex);
    end
    aSolRaw(paramIndex) = aParam;
    paramIndex = paramIndex + 1;
    % Bias
    adjW = aSolRaw(paramIndex);
    paramIndex = paramIndex + 1;
    if nodesKPH2{mi}.weightFunction == 1
        adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
    end
    nodesKPH2{mi}.bias = adjW;
    % Value
    nodesKPH2{mi}.value = 0;
    % Status
    nodesKPH2{mi}.status = 1; % all nodes exist by definition
    aSolRaw(paramIndex) = 1;
    paramIndex = paramIndex + 1;
    % Inputs
    nodesKPH2{mi}.inputs = [];
    % Outputs
    nodesKPH2{mi}.outputs = [];
end

% *** Create output nodes
startIndex = numNodes.I+numNodes.M+1;
endIndex = startIndex+numNodes.O-1;
for oi=startIndex:endIndex
    % Node type
    nodesKPH2{oi}.type = 3;
    % Weight function
    nodesKPH2{oi}.weightFunction = layParam.L2wf;
    aParam = layParam.L2wf/numWeightFuncs;
    aSolRaw(paramIndex) = aParam;
    paramIndex = paramIndex + 1;
    % Node function
    nodesKPH2{oi}.nodeFunction = layParam.L2nf;
    aParam = layParam.L2nf/numNodeFuncs;
    aSolRaw(paramIndex) = aParam;
    paramIndex = paramIndex + 1;
    % Autoweight
    adjW = aSolRaw(paramIndex);
    paramIndex = paramIndex + 1;
    if nodesKPH2{oi}.weightFunction == 1
        adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
    end
    nodesKPH2{oi}.autoWeight = adjW;
    % Function parameter
    nodesKPH2{oi}.funcParam = layParam.L2nfp;
    if nodesKPH2{oi}.nodeFunction == 2 % sigmoid
        aParam = revPutInRange(layParam.L2nfp,limits.sig_minFP,limits.sig_maxFP);
    elseif nodesKPH2{oi}.nodeFunction == 3 % Gaussian
        aParam = revPutInRange(layParam.L2nfp,limits.gaus_minFP,limits.gaus_maxFP);
    else
        aParam = aSolRaw(paramIndex);
    end
    aSolRaw(paramIndex) = aParam;
    paramIndex = paramIndex + 1;
    % Bias
    adjW = aSolRaw(paramIndex);
    paramIndex = paramIndex + 1;
    if nodesKPH2{oi}.weightFunction == 1
        adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
    end
    nodesKPH2{oi}.bias = adjW;
    % Value
    nodesKPH2{oi}.value = 0;
    % Status
    nodesKPH2{oi}.status = 1; % all nodes exist by definition
    % Inputs
    nodesKPH2{oi}.inputs = [];
    % Outputs
    nodesKPH2{oi}.outputs = [];
    
end

% CONTINUE HERE: CONTROL MIDDLE LATERAL CON; AND IN-TO-OUT CONNECTIONS?

% *** Set up connections
firstMiddle = numNodes.I+1;
firstOutput = numNodes.I+numNodes.M+1;
for targi=numNodes.I+1:totNodes
    % Scan potential inputs
    for sourcei=1:firstOutput-1

        doCon = checkDoCon1(sourcei,targi,firstMiddle,firstOutput,layParam);
        if doCon
            aSolRaw(paramIndex) = 1; % connection exists
            % Create a connection
            conKPH2{conIndex}.source = sourcei;
            conKPH2{conIndex}.target = targi;
            % Adjust weight according to weight function
            adjW = aSolRaw(paramIndex+1);
            if nodesKPH2{targi}.weightFunction == 1
                adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
            end
            conKPH2{conIndex}.weight = adjW;
            % Update the source and the target with a reference to the connection index
            nodesKPH2{targi}.inputs = [nodesKPH2{targi}.inputs conIndex];
            nodesKPH2{sourcei}.outputs = [nodesKPH2{sourcei}.outputs conIndex];
            % Update connection and source indeces
            conIndex = conIndex + 1;
        else
            aSolRaw(paramIndex) = 0; % connection does not exist
        end
        paramIndex = paramIndex + 2;
        
    end
end
    
    
    


% % *** Set up connections
% startIndex = numNodes.I+1; % first middle node
% endIndex = totNodes; % last node
% doubleIMnodes = (numNodes.I+numNodes.M)*2; % two parameters per connection (existence and weight)
% for ni=startIndex:endIndex
%     firstParam = paramIndex;
%     lastParam = firstParam+doubleIMnodes-1; % inputs are only from "input and middle nodes"
%     % Scan raw parameters
%     sourceIndex = 1;
%     for pi=firstParam:2:lastParam
%
%         % Don't allow self-connections
%         if sourceIndex == ni
%             sourceIndex = sourceIndex + 1;
%             continue
%         end
%
%         aSolRaw(pi) = 1; % the connection exists by default
%         % Create a connection
%         conKPH2{conIndex}.source = sourceIndex;
%         conKPH2{conIndex}.target = ni;
%         % Adjust weight according to weight function
%         adjW = aSolRaw(pi+1);
%         if nodesKPH2{ni}.weightFunction == 1
%             adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
%         end
%         conKPH2{conIndex}.weight = adjW;
%         % Update the source and the target with a reference to the connection index
%         nodesKPH2{ni}.inputs = [nodesKPH2{ni}.inputs conIndex];
%         nodesKPH2{sourceIndex}.outputs = [nodesKPH2{sourceIndex}.outputs conIndex];
%         % Update connection and source indeces
%         conIndex = conIndex + 1;
%         sourceIndex = sourceIndex + 1;
%     end
%     paramIndex = paramIndex+doubleIMnodes;
%
% end

funcStat = 0;

netKPH2.numNodes = numNodes;
netKPH2.limits = limits;
netKPH2.nodes = nodesKPH2;
netKPH2.con = conKPH2;
netKPH2.rawParam = aSolRaw;



end

