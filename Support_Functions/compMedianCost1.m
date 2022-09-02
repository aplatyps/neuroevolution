function medianCost = compMedianCost1(nets)

% Number of networks
numNets = size(nets,2);
% Scan through networks
vecCosts = zeros(1,numNets);
for ni=1:numNets
    % Extract cost; put into a vector
    vecCosts(ni) = nets{ni}.propertiesCell.cost;
end
% Compute median
medianCost = median(vecCosts);


end

