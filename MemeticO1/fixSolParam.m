% Assume that solutions contain the left score column
function solutions = fixSolParam(solutions,fixParams)
numSol = size(solutions,1);
numFixed = size(fixParams,1);
% Scan throuh solutions
for si=1:numSol
    % Scan through fixed param and update solution 
    for fi=1:numFixed
        solutions(si,1+fixParams(fi,1)) = fixParams(fi,2);
    end
end
