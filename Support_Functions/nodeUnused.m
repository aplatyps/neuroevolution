% Function for checking whether a node is unused
function res = nodeUnused(aNode)

numConIn = size(aNode.inputs,2);
numConOut = size(aNode.outputs,2);

% If the node's stauts is 0, or has no inputs/outputs, or is a in/middle node without outputs 
if aNode.status == 0 || (numConIn == 0 && numConOut == 0) || (aNode.type<=2 && numConOut == 0)
    res = true;
    return
else
    res = false;
end


end

