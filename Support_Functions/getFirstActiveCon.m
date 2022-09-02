% Function for getting the first connection associated with an active input
function conIndex = getFirstActiveCon(nodes,connections,inputs)
% Get number of inputs
numIn = size(inputs,2);
% Scan inputs
for ii=1:numIn
    % If one of the inputs is active return
    conIndex = inputs(ii);
    sourceIndex = connections{conIndex}.source;
    if nodes{sourceIndex}.status == 1
        conIndex = ii;
        return
    end
    
end

conIndex = -1;


end

