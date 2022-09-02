% Function for checking whether a node is unused
function res = nodeUnused2(aNode,nodes,connections)

numConIn = size(aNode.inputs,2);
numConOut = size(aNode.outputs,2);

% If the node's stauts is 0, or has no inputs/outputs, or is a middle node with outputs 
if aNode.status == 0 || (numConIn == 0 && numConOut == 0) || (aNode.type<=2 && numConOut == 0)
    res = true;
    return
end

% If all outputs are to non-existent nodes
% Scan through outputs
% If any output is connected to an existing node then return false
if aNode.type ~= 3
    numOut = size(aNode.outputs,2);
    for oi=1:numOut
        % Get connection
        conIndex = aNode.outputs(oi);
        % Get target
        targIndex = connections{conIndex}.target;
        % Check target status
        %numConOut = size(nodes{targIndex}.outputs,2);
        if (nodes{targIndex}.status == 1) % && numConOut > 0)
            res = false;
            return
        end
    end
    res = true;
    return
else
    res = false;
    return
end



end

