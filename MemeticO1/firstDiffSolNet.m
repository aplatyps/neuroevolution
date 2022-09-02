% Function for getting the first sufficiently different solution
function soli = firstDiffSolNet(leader,solutions,minDiff)
   % Extract basic information
   numSols = size(solutions,2);
   % Scan through solutions
   for si=1:numSols
      % Compute difference between leader and potential follower
      aDiff = compSolNetDiff1(leader,solutions{si});
      %disp(['aDiff: ' num2str(aDiff)]);
      
      % If the difference is large enough return index of follower
      if aDiff >= minDiff
         soli = si;
         return
      end
   end
   % If no suitable candidate is found return -1
   soli=-1;