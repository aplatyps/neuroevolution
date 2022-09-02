% Return indeces of unused nodes
% Vector: 0 - unused; 1 - used.
function listUnused = getUnusedNodes(net)
% Get number of nodes
numNodes = size(net.nodes,2);
% Scan through nodes
listUnused = ones(1,numNodes);
for ni=1:numNodes
    % Check if unused
    if nodeUnused2(net.nodes{ni},net.nodes,net.con)
        listUnused(ni) = 0;
    end
end



end

