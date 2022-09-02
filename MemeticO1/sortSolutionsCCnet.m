% Function for sorting solutions
function [sortedSols] = sortSolutionsCCnet(sols)
   % Extract basic information
   numSols = size(sols,2);
   % Extract costs from solutions
   costVec = getCostsNet(sols);
   % Sort costs and get indeces
   [costsS costsI] = sort(costVec);
   % Scan through solutions and sort
   for soli=1:numSols
      % Put the solution in the right place
      sorti = costsI(soli);
      sortedSols{soli} = sols{sorti};
   end
 
   
   
   