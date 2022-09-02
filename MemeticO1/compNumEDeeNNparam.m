% Compute number of EDeeNN paramters
% What determines num.param.: 1 WF, 1 NF, 2 NF parameters, 1 bias, x weights,
% architecture
% limits.numNodes = [numIn numNodesInLayer2 ... numNodesInLayerN]
% -----
function numParam = compNumEDeeNNparam(limits)

% Extract basic information
numLayers = size(limits.numNodes,2);

numParam = 0;
if limits.architecture == 1 % no WF/NF constraints
    for li=2:numLayers % layer 1 contains the number of inputs (no param)
        numParamEachNode = 5 + limits.numNodes(li-1); %1+1+2+1+x-weights
        numParam = numParam + (limits.numNodes(li)*numParamEachNode);
    end
elseif (limits.architecture == 2 || limits.architecture == 3) % archit. 3 is a bit of hack/graft.
    for li=2:numLayers
        numParamEachNode = 3 + limits.numNodes(li-1); %2 NF param + 1 bias + x-weights
        numParam = numParam + (limits.numNodes(li)*numParamEachNode);
        numParam = numParam + 2; % 1 WF + 1 NF per layer
    end
end


end

