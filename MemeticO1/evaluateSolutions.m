% --- Notes
% Function for evaluating solutions
% Only evaluate those solutions whose costs are not defined (i.e. -1).
% --- Arguments
% - sols: solutions (leftmost column is reserved for cost evaluations)
% - costFunc: name of function to be used for evaluating solutions
% --- Outputs
% - evalSols: the same inputted solutions but with cost evaluations on the left
function [evalSols costTerms evalParams data fs numEval] = evaluateSolutions(sols,funcName,data,verbose)
fs = 0; % function status
evalSols = [];
% Extract basic information
[yLeng xLeng] = size(sols);
numSols = yLeng;
numParams = xLeng-1;
% Scan through solutions
if verbose == 1
    disp(['Evaluating ' num2str(numSols) ' solutions.']);
end
costTerms = [];
evalParams = [];
% Data weight parameters
numPat = size(data.in,1);
accumulWeights = zeros(numPat,1);

numEval = 0;
for si=1:numSols
    % If the cost is "not defined"
    if sols(si,1) == -1 % default "not defined"
        % Evaluate solution
        if verbose == 1
            disp(['Evaluating solution ' int2str(si) ' ...']);
        end
        % Silent DNA
         aSol = sols(si,2:numParams+1);
%         rParamInds = randperm(numParams);
%         selParam = rParamInds(1:numSilent);
%         aSol = spliceOut(aSol,selParam);
        % Evaluate
        [aCost thisCostTerms evalParams data fs] = feval(funcName, aSol,data);
        numEval = numEval + 1;
        if ~isempty(data.weights)
            accumulWeights(:,1) = accumulWeights(:,1) + data.weights;
        end
        costTerms = [costTerms; thisCostTerms];
        if fs ~= 0
            return
        end
        % aCost = gsoCostBridge(sols(si,2:numParams+1),funcName,params);
        % Store cost
        sols(si,1) = aCost;
        %simParamList{si} = simParams;
    end
    if verbose == 1
        disp(['Cost of solution ' num2str(si) ': ' num2str(sols(si,1))]);
    end
end
evalSols = sols;
data.weights = accumulWeights/numSols;

