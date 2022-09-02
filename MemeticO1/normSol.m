% Function for normalizing solutions
function solution = normSol(solution,paramRange)
   % Extract basic information
   minP = paramRange(1);
   maxP = paramRange(2);
   numParams = size(solution,2);
   % Scan parameters
   for pi=1:numParams
      aParam = solution(pi);
      % Check min. val.
      if aParam < minP
         solution(pi) = minP;
      elseif aParam > maxP % Check max. val.
         solution(pi) = maxP;
      end
   end

      