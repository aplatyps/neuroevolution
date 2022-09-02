function numParamPerLayer = compAllNumEDeeNNperLayer(limits)

numNodeLayers = size(limits.numNodes,2);
numParamPerLayer = zeros(1,numNodeLayers-1);
for li=2:numNodeLayers
    numParamPerLayer(li-1) = compNumEDeeNNperLayer(li,limits);
end


end

