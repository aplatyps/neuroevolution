% Get values from a layer of nodes and put into a vector
function vecValues = getValues(nodes)
% Extract basic information
numNodes = size(nodes,2);
% Initialize
vecValues = zeros(1,numNodes);
% Scan and copy
for ni=1:numNodes
    vecValues(ni) = nodes{ni}.value;
end

end

