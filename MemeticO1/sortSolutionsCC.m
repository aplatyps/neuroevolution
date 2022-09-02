% Function for sorting solutions
function [sortedSols] = sortSolutionsCC(sols,errPats)
   % Extract basic information
   [yLeng xLeng] = size(sols);
   numSols = yLeng;
   sortedSols = zeros(numSols,xLeng);
   % Sort the first column (costs) and get indeces
   [costsS costsI] = sort(sols(:,1));
   % Rearrange solutions
   % Scan through solutions
   for soli=1:numSols
      % Put the solution in the right place
      sorti = costsI(soli);
      sortedSols(soli,:) = sols(sorti,:);
   end
   
   
   