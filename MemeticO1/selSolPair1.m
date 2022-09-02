function [rsoli1 rsoli2] = selSolPair1(numSol)
solInds = randperm(numSol);
rsoli1 = solInds(1);
rsoli2 = solInds(2);


end

