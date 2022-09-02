% Function for computing the difference between two solutions
% Simple Euclidean distance
function aDist = compSolDiff1(sol1,sol2)
   aDist = sqrt(sum((sol1-sol2).^2));
   