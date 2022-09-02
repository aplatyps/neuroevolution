% Compute the number of different weight and node functions (used nodes)
function [countWF countNF] = compNumWNfunc(net)
% Initialize function store
wFuncs = [-1 0]; % -1 and 0 are control values (to be ignored)
nFuncs = [-1 0];
countWF = 0;
countNF = 0;
% Get number of nodes
numNodes = size(net.nodes,2);
% Scan nodes
for ni=1:numNodes
    % If node is being used
    if ~nodeUnused2(net.nodes{ni},net.nodes,net.con)
        % If the weight function is new then store it and increment new wf counter
        if ~isInVec(net.nodes{ni}.weightFunction,wFuncs)
            wFuncs = [wFuncs net.nodes{ni}.weightFunction];
            countWF = countWF + 1;
        end
        % If the store function is new then store it and increment new nf counter
        if ~isInVec(net.nodes{ni}.nodeFunction,nFuncs)
            nFuncs = [nFuncs net.nodes{ni}.nodeFunction];
            countNF = countNF + 1;
        end
    end
end


end

