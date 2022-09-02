% Get the values of active nodes at inputs
function [activeInVec activeWeights] = getActiveInputs(nodes,con,inputs)
activeInVec = [];
activeWeights = [];
% Get number of inputs
numIn = size(inputs,2);
% Scan inputs
for ii=1:numIn
    % If input node is active, add to vector
    conIndex = inputs(ii);
    sourceIndex = con{conIndex}.source;
    if nodes{sourceIndex}.status == 1
        activeInVec = [activeInVec nodes{sourceIndex}.value];
        activeWeights = [activeWeights con{conIndex}.weight];
    end
end


end

