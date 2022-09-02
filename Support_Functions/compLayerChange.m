function layerChanges = compLayerChange(curSol,prevSol,numParamPerLayer)

% Extract basic information
numLayers = size(numParamPerLayer,2);

% Scan layers
currentStart = 1;
for li=1:numLayers
    numParamsThisLayer = numParamPerLayer(li);
    currentEnd = currentStart+numParamsThisLayer-1;
    % Extract raw parameters
    prevLayer = prevSol(1,currentStart:currentEnd);
    curLayer = curSol(1,currentStart:currentEnd);
    % Compute average change per parameter
    aDist = sum(abs(prevLayer-curLayer))/numParamsThisLayer;
    %aDist = sqrt(sum((prevLayer-curLayer).^2))/numParamsThisLayer;
    % Store result
    layerChanges(li) = aDist;
    % Update indeces
    currentStart = currentEnd + 1;
end

end

