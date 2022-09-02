function bestErr = getBestError(costTerms)

% Get num. of cost terms
numSol = size(costTerms,1);
bestCost = costTerms(1,1);
bestErr = costTerms(1,2);
% Scan cost terms
for si=2:numSol
    % If current cost is smaller than cur. min then update best err
    if costTerms(si,1) < bestCost
       bestCost = costTerms(si,1);
       bestErr = costTerms(si,2);
    end
end


end

