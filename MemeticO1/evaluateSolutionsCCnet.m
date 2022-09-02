% --- Notes
% Function for evaluating solutions
% Only evaluate those solutions whose costs are not defined (i.e. -1).
% --- Arguments
% - sols: solutions (leftmost column is reserved for cost evaluations)
% - costFunc: name of function to be used for evaluating solutions
% --- Outputs
% - evalSols: the same inputted solutions but with cost evaluations on the left
function [sols data numEval] = evaluateSolutionsCCnet(sols,funcName,data,verbose)
%fs = 0; % function status
evalSols = [];
% Extract basic information
numSols = size(sols,2);
% Scan through solutions
if verbose == 1
    disp(['Evaluating ' num2str(numSols) ' solutions.']);
end

% Data weight parameters
numPat = size(data.in,1);

numEval = 0;
for si=1:numSols
    % If the cost is "not defined"
    if sols{si}.cost == -1 % default "not defined"
        % Evaluate solution
        if verbose == 1
            disp(['Evaluating solution ' int2str(si) ' ...']);
        end
        % Evaluate
        [aCost errPat data fs] = feval(funcName, sols{si}, data);
        numEval = numEval + 1;

        % Store cost, etc.
        sols{si}.cost = aCost;
        sols{si}.errPat = errPat;
        sols{si}.costFunc = funcName;
    end
    if verbose == 1
        disp(['Cost of solution ' num2str(si) ': ' num2str(sols{si}.cost)]);
    end
end


