% Function for generating initial solution set
% The leftmost column is for holding solution costs (evaluations) ("-1" means "not defined")
% --- Arguments
% - gsoParams: global stochastic optimization parameters
function [solutions numEval] = initSolRand(gsoParams,data)
% Initialize solution matrix
numParams = gsoParams.numSolParams;
numSols = gsoParams.ngSize;
solutions = zeros(numSols,numParams+1+gsoParams.numPat);
solutions(:,1) = (-1)*ones(numSols,1);
% Generate solutions
minVal = gsoParams.paramRange(1);
diff = gsoParams.paramRange(2) - minVal;
solutions(:,2:end) = minVal+rand(numSols,numParams+gsoParams.numPat)*diff;
numEval = 0;
% Fix param. of solutions
%solutions = fixSolParam(solutions,gsoParams.fixParams);




