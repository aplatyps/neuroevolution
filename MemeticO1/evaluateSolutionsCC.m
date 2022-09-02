% --- Notes
% Function for evaluating solutions
% Only evaluate those solutions whose costs are not defined (i.e. -1).
% --- Arguments
% - sols: solutions (leftmost column is reserved for cost evaluations)
% - funcName: name of function to be used for evaluating solutions
% - data: dataset
% - verbose: display status?
% --- Outputs
% - evalSols: the same inputted solutions but with cost evaluations on the left
function [evalSols data fs numEval errPats] = evaluateSolutionsCC(sols,funcName,data,verbose)
fs = 0; % function status
evalSols = [];
% Extract basic information
[yLeng xLeng] = size(sols);
numSols = yLeng;
numParams = xLeng-1;
numPat = size(data.in,1);
% Scan through solutions
if verbose == 1
    disp(['Evaluating ' num2str(numSols) ' solutions.']);
end

numEval = 0;
for si=1:numSols
    % If the cost is "not defined"
    if sols(si,1) == -1 % default "not defined"
        % Evaluate solution
        if verbose == 1
            disp(['Evaluating solution ' int2str(si) ' ...']);
        end
        % Extract solution
        xIndex = 2 + numPat;
        aSol = sols(si,xIndex:end);
        % Evaluate
        [aCost data fs errPat] = feval(funcName, aSol,data);
        numEval = numEval + 1;
        if fs ~= 0
            return
        end
        % Store cost
        sols(si,1) = aCost;
        sols(si,2:2+numPat-1) = errPat;
    end
    if verbose == 1
        disp(['Cost of solution ' num2str(si) ': ' num2str(sols(si,1))]);
    end
end
evalSols = sols;


