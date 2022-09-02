% Vector for extracting vectors of errors and creating a uniform table
function tableVecCosts = getAllVecCosts(allNets)
% Get number of network
numNets = size(allNets,2);
maxLeng = 0;
% Find the longest vector
for neti=1:numNets
    aLeng = size(allNets{neti}.vecCosts,2);
    if aLeng > maxLeng
        maxLeng = aLeng;
    end
end
% Initialize table
tableVecCosts = zeros(numNets,maxLeng);
% Go through networks
for neti=1:numNets
    % If the vector is smaller than max-leng then add padding (last cost)
    aLeng = size(allNets{neti}.vecCosts,2);
    tableVecCosts(neti,1:aLeng) = allNets{neti}.vecCosts;
    if aLeng < maxLeng
        lastCost = allNets{neti}.vecCosts(aLeng);
        remLeng = maxLeng-aLeng;
        tableVecCosts(neti,aLeng+1:end) = ones(1,remLeng)*lastCost;
    end
    
end




end

