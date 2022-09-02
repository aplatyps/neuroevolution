% Function for creating a mutate solution
% Selects a random solution and then mutates it
function mutSol = mutateSol(solutions,gsoParams)
   % Extract basic information
   [numSol numParam] = size(solutions);
   % Select a random solution
   rs = ceil(rand*numSol);
   srcSol = solutions(rs,:);
   % Mutate the solution
   mutSol = mutateThis(srcSol,gsoParams);
   