% Sort costs and return x (numSel) best.
function bestIndeces = getBestIndeces(costs,numSel)

% Extract basic information
numCol = size(costs,2);

% Initializations
bestIndeces = zeros(numSel,numCol);

% Scan columns
for ci=1:numCol
    % Sort and get indeces  
    [costsS costsI] = sort(costs(:,ci));
    % Extract x best
    bestIndeces(:,ci) = costsI(1:numSel);
end





end

