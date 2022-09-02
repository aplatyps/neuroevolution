% Compute the size of a KPH1 network (size = num. used nodes)
% Format of numUsed is: [numUsedIn numUsedMiddle numUsedOutput
% numUsedTotal]
function [numUsed totNodes] = getNumUsedNodesKPH2(net)
% Initializations
numUsed = [0 0 0 0];
% Get total number of nodes
totNodes = size(net.nodes,2);
% Scan through nodes
for ni=1:totNodes
    % Check whether the node is being used and change counter
    if ~nodeUnused2(net.nodes{ni},net.nodes,net.con);
        % Input
        if net.nodes{ni}.type == 1
            numUsed(1) = numUsed(1) + 1;
        elseif net.nodes{ni}.type == 2 % Middle
            numUsed(2) = numUsed(2) + 1;
        else % Output
            numUsed(3) = numUsed(3) + 1;
        end   
    end
    
end
% Total
numUsed(4) = sum(numUsed(1:3));


