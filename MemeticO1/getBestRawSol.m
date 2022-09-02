% Getting/making a "best solution" from an old set of populations and a new
% set of populations
function bestRawSol = getBestRawSol(sols1,sols2,costs1,costs2)

% Extract basic information
numPop = size(sols1,2);

% Initializations
bestRawSol = [];

% Scan through populations
for pi=1:numPop
    % Get minVal and minIndex for solutions 1 and 2
    [minV1 minI1] = min(costs1(:,pi));
    [minV2 minI2] = min(costs2(:,pi));
    % Get the best one of new/old & append sub-solution
    if minV1 < minV2
        bestRawSol = [bestRawSol sols1{pi}(minI1,:)];
    else
        bestRawSol = [bestRawSol sols2{pi}(minI2,:)];
    end
end


end

