function [numUsedCon totCon] = getNumUsedConKPH2(net)
% Compute number of used connections
numConIndeces = size(net.con,2);
% Scan connections
numUsedCon = 0;
for coni=1:numConIndeces
    % If both the input and output exist then increment
    si = net.con{coni}.source;
    ti = net.con{coni}.target;
    if ~nodeUnused2(net.nodes{si},net.nodes,net.con) && ~nodeUnused2(net.nodes{ti},net.nodes,net.con)
        numUsedCon = numUsedCon + 1;
    end
end

% Compute total number of possible connections
% Compute number of nodes
[numUsed totNodes] = getNumUsedNodesKPH2(net);
totUsed = numUsed(4);
% Scan nodes
totCon = 0;
for ni=1:totNodes
    % If node exists
    if ~nodeUnused2(net.nodes{ni},net.nodes,net.con)
        totCon = totCon + totUsed - 1;
    end
end



end

