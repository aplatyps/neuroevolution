%% ---------------------------------------
% Adaptive Mutation
%
% Description:
% Creates a mutated solution with adaptive mutation by comparing
% to a threshold for cost (0.3) to a randomly selected solution 
% and mutates it if the cost is above 0.3 (considered non-optimal)
%
% @input: list of solutions, model parameters, list of solution cost
% @return: mutated solution
%
%% ----------------------------------------

% Function for 
% Selects a random solution and then mutates it
function mutSol = mutateSol2(solutions,gsoParams,solCostm)
   % Extract basic information
   [numSol, numParam] = size(solutions);
   % Select a random solution
   rs = ceil(rand*numSol);
   srcSol = solutions(rs,:);
   % Mutate the solution only if the solution cost is high
   if solCostm > 0.3
       mutSol = mutateThis(srcSol,gsoParams);
   else
       mutSol = srcSol;
   end
end