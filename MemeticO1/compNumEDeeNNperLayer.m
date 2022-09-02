% Compute the number of parameters for specific layers
function numParam = compNumEDeeNNperLayer(layer,limits)

if limits.architecture == 1 % no WF/NF constraints
    numParamEachNode = 5 + limits.numNodes(layer-1); %1+1+2+1+x-weights
    numParam = limits.numNodes(layer)*numParamEachNode;    
elseif (limits.architecture == 2 || limits.architecture == 3)
    numParamEachNode = 3 + limits.numNodes(layer-1); %2 NF param + 1 bias + x-weights
    numParam = (limits.numNodes(layer)*numParamEachNode) + 2;    
end

end

