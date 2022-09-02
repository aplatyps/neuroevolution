% Create new CoDeeNN generation
function nextSols = newCoDeeNNGen(solutions1,solutions2,bestIndeces1,bestIndeces2)

% Extract basic information
numPop = size(solutions1,2);
numOld = size(bestIndeces1,1);
numNew = size(bestIndeces2,1);
totSol = numOld + numNew;

% Scan populations
for pi=1:numPop
    numParam = size(solutions1{pi}(1,:),2);
    nextSols{pi} = zeros(totSol,numParam);
    % Old solutions; scan indeces; add solutions
    for oi=1:numOld
        bestIndex = bestIndeces1(oi,pi);
        nextSols{pi}(oi,:) = solutions1{pi}(bestIndex,:);
    end
    % New solutions; scan indeces; add solutions
    for ni=1:numNew
        rowi = numOld+ni;
        bestIndex = bestIndeces2(ni,pi);
        nextSols{pi}(rowi,:) = solutions2{pi}(bestIndex,:);
    end
end

end

