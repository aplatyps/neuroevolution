% Compute the positional extremes of a network of nodes
function [minX maxX minY maxY] = compPosExtremes(nodes)
% Get number of nodes
numNodes = size(nodes,2);
% Initializations
xpositions = zeros(1,numNodes);
ypositions = zeros(1,numNodes);
% Scan nodes
for ni=1:numNodes
    % Accumulate x-positions
    xpositions(ni) = nodes{ni}.position(2);
    % Accumulate y-positions
    ypositions(ni) = nodes{ni}.position(1);
end
% Compute extremes
minX = min(xpositions);
maxX = max(xpositions);
minY = min(ypositions);
maxY = max(ypositions);


end

