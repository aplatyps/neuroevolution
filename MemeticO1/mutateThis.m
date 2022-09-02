% Mutate one particular solution
function mutSol = mutateThis(aSol,gsoParams);
   % Extract basic information
   numParams = size(aSol,2);
   range = 2*gsoParams.mutRange;
   minVal = gsoParams.paramRange(1);
   maxVal = gsoParams.paramRange(2);
   % Initialize
   mutSol = aSol;
   % Scan parameters
   for pi=1:numParams
      randVal = rand;
      if randVal <= gsoParams.mutProb
         % Generate a random value within the accepted range
         randVal = (rand*range)-gsoParams.mutRange;
         % Add value
         mutSol(pi)=mutSol(pi)+randVal; 
         % Check limits
         if mutSol(pi)<minVal
            mutSol(pi)=minVal;
         elseif mutSol(pi) > maxVal
            mutSol(pi)=maxVal;
         end
      end
   end
   