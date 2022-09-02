% Function for sorting solutions
% Sort solutions according to fitness sharing (FS) errors
function [sortedSols] = sortSolutionsCC2(sols,fsErr)
   % Extract basic information
   [yLeng xLeng] = size(sols);
   numSols = yLeng;
   sortedSols = zeros(numSols,xLeng);
   % Sort the fs errors and get indeces
   [costsS costsI] = sort(fsErr(:,1));
   % Rearrange solutions
   % Scan through solutions
   for soli=1:numSols
      % Put the solution in the right place
      sorti = costsI(soli);
      sortedSols(soli,:) = sols(sorti,:);
   end
   
   
   