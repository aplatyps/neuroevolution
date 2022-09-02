% Architecture == 1: no constraints; full diversity allowed.
% Architecture == 2: semi-constrained; only one WF/NF allowed per layer
% Architecture == 3: constrained; only one WF/NF combination allowed for
% Function for creating a SEDeeNN network based on parameters and limits
% ------ Arguments
% limits: ranges for solution parameters
% aSolRaw: raw solution vector
% ------ Weight functions
% 1 - inner product -> 'ipWF1'
% 2 - Euclidean distance -> 'edWF1'
% 3 - Higher-order (HO) product 1 -> 'hoWF1'
% 4 - Higher-order (HO) product 2 (standard) -> 'hoWF2'
% 5 - Standard deviation -> 'sdWF1'
% 6 - MIN -> 'minWF1'
% 7 - MAX -> 'maxWF1'
% ------ Node functions
% 1 - identity -> 'idNF'
% 2 - sigmoid -> 'sigNF1'
% 3 - Gaussian -> gausNF1'
% ------ Status of createKPH2sol
% 0 - no error
% 1 - error
function [net funcStat] = createEDeeNN1archit1(limits,aSolRaw)


funcStat = 1;
nodes = [];
% Check arguments
% Check that the number of raw parameters is consistent with numNodes
expectNumParam = compNumEDeeNNparam(limits);
actualNumParam = max(size(aSolRaw));
if expectNumParam ~= actualNumParam
    disp(['The size of the parameter vector is inconsistent with the specified number of nodes.']);
    disp(['The parameter vector should have ' int2str(expectNumParam) ' parameters.']);
    return
end
% Specify the number of node and weight functions
numWeightFuncs = size(limits.weightFunctions,2);
numNodeFuncs = size(limits.nodeFunctions,2);
% Extract basic information
numLayers = size(limits.numNodes,2);
% Initializations
paramIndex = 1;

% Input nodes do not have to be created; they are taken from the data.
numInNodes = limits.numNodes(1);
for ni=1:numInNodes
    nodes{1}{ni}.weightFunction = -1;
    nodes{1}{ni}.nodeFunction = -1;
    nodes{1}{ni}.funcParam = [];
    nodes{1}{ni}.bias = 0; % weights are setup in the connections
    nodes{1}{ni}.value = 0;
    nodes{1}{ni}.conWeights = [];
end

for li=2:numLayers
    numLnodes = limits.numNodes(li);
    aNumCon = limits.numNodes(li-1);
    for ni=1:numLnodes
        % --- Weight function
        wfi = ceil(aSolRaw(paramIndex)*numWeightFuncs);
        if wfi == 0
            wfi = 1;
        end
        nodes{li}{ni}.weightFunction = getWFname(limits.weightFunctions(wfi)); % get func. from list of selected func.
        paramIndex = paramIndex + 1;
        % --- Node function
        nfi = ceil(aSolRaw(paramIndex)*numNodeFuncs);
        if nfi == 0
            nfi = 1;
        end
        nodes{li}{ni}.nodeFunction = getNFname(limits.nodeFunctions(nfi));
        paramIndex = paramIndex + 1;
        % --- Node function parameters
        % Note for later speedup: remove string compares; just use wfi and nfi.
        if strcmp(nodes{li}{ni}.nodeFunction,'idNF')
            nodes{li}{ni}.funcParam = [];
        elseif strcmp(nodes{li}{ni}.nodeFunction,'sigNF1')
            nodes{li}{ni}.funcParam = putInRange(aSolRaw(paramIndex),limits.sig_minFP,limits.sig_maxFP);
        else
            nodes{li}{ni}.funcParam = zeros(1,2);
            nodes{li}{ni}.funcParam(1) = putInRange(aSolRaw(paramIndex),limits.gaus_minFP1,limits.gaus_maxFP1);
            nodes{li}{ni}.funcParam(2) = putInRange(aSolRaw(paramIndex+1),limits.gaus_minFP2,limits.gaus_maxFP2);
        end
        paramIndex = paramIndex + 2;
        % --- Bias
        adjW = aSolRaw(paramIndex);
        paramIndex = paramIndex + 1;
        if strcmp(nodes{li}{ni}.weightFunction,'ipWF1')
            adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
        end
        nodes{li}{ni}.bias = adjW;
        % --- Value
        nodes{li}{ni}.value = 0;
        % --- Weights
        adjW = aSolRaw(paramIndex:paramIndex+aNumCon-1);
        paramIndex = paramIndex+aNumCon;
        if strcmp(nodes{li}{ni}.weightFunction,'ipWF1')
            adjW = putInRangeVec(adjW,limits.P_minWB,limits.P_maxWB);
        end
        nodes{li}{ni}.conWeights = adjW;
    end
end
    
% Function status and results
funcStat = 0;
net.nodes = nodes;
net.limits = limits;
net.rawParam = aSolRaw;

end

