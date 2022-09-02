% Function for computing the difference between two solutions
% Simple Euclidean distance; distance based on weights only.
function aDist = compSolNetDiff1(sol1,sol2)
weightVec1 = getWeightsNet(sol1);
weightVec2 = getWeightsNet(sol2);
aDist = sqrt(sum((weightVec1-weightVec2).^2));
   