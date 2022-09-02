% Select solution pairs with a probability that is inversely proportional
% to their complementary error.
% ccMatrix -> numSol x numSol; normalized to 0 to 1. (0 = zero compl.err)
function [ri1 ri2] = selSolPair3(solPairs,memParams,numSol)

% Extract basic information
numPairs = size(solPairs,1);

% Basic initializations
ri1 = -1; ri2 = -1;

% Cumulative probability
for pi=2:numPairs
    solPairs(pi,1) = solPairs(pi,1) + solPairs(pi-1,1);
end
% Normalize
maxProb = max(solPairs(:,1));
if maxProb == 0
    maxProb = 1;
end
solPairs(:,1) = solPairs(:,1)/maxProb;

% Random number
randVal = rand;
% Select index
for pi=1:numPairs
    if randVal <= solPairs(pi,1)
        ri1 = solPairs(pi,2);
        ri2 = solPairs(pi,3);
        break
    end
end

if ri1 == -1
   ri1 = ceil(rand*numSol); ri2 = ceil(rand*numSol);
   if ri1 == 0
       ri1 = 1;
   end
   if ri2 == 0
       ri2 = 1;
   end
end



end

