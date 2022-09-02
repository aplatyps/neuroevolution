function numSNZ = getNumStatNonZero(netKPH2);
% Initializations
numSNZ = zeros(1,3);
% Get number of nodes
numNodes = size(netKPH2.nodes,2);
% Scan nodes
for ni=1:numNodes
    % If used then increment counter
    if netKPH2.nodes{ni}.status == 1
        % Input
        if netKPH2.nodes{ni}.type == 1
            numSNZ(1) = numSNZ(1) + 1;
        elseif netKPH2.nodes{ni}.type == 2 % Middle
            numSNZ(2) = numSNZ(2) + 1;
        else % Output
            numSNZ(3) = numSNZ(3) + 1;
        end
    end
end

end

