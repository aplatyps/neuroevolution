% Function for checking whether a particular network has all the WFs in the
% input argument embodied in the network
function hasWFs = checkHasWFs(weightFuncs, net)
% Get number of nodes and WFs
numNodes = size(net.nodes,2);
numWF = max(size(weightFuncs));
% Scan through weight functions
for wfi=1:numWF
    % Scan through nodes
    hasThisWF = false;
    for nodi=1:numNodes
        % If a node is being used and it has the weight function
        if ~nodeUnused2(net.nodes{nodi},net.nodes,net.con) && (net.nodes{nodi}.weightFunction == weightFuncs(wfi))
            hasThisWF = true;
            break
        end
    end
    
    if hasThisWF == false
        hasWFs = false;
        return
    end

end

hasWFs = true;


end

