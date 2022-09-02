% Count number of used nodes
function unc = countUsedNodes(netKPH2)
% Initializations
unc = 0;
% Get number of nodes
numNodes = size(netKPH2.nodes,2);
% Scan nodes
for ni=1:numNodes
    % If used then increment counter
    if ~nodeUnused2(netKPH2.nodes{ni},netKPH2.nodes,netKPH2.con)
        unc = unc + 1;
    end
end

end

