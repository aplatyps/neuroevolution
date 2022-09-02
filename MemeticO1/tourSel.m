%% ---------------------------------------
% Tournament Selection Algorithm
%
% Description:
% Randomly selects individual solutions to form a population among 
% the best solutions that are randomly selected from all solutions
% and sorted to best solution first.
% The solutions are then compared among each other within the 
% population until 2 best solutions are picked
%
% @input: list of solutions, population size
% @return: best solution 1, best solution 2
%
%% ----------------------------------------

function [rsoli1 rsoli2] = tourSel(solst, pSize)
    % Initialise population
    pop = [];
    % Get 20 random solutions from all solutions
    for i = 1:pSize
        pop(i) = randi([1 size(solst,1)],1);
    end

    % Tournament Selection
    better = pop(1);
    best = pop(1);
    for i = 1:pSize
        ind = pop(i);
        % Compare cost and select best solutions
        if solst(ind,1) < solst(best,1)
            better = best;
            best = ind;
        end
    end
    rsoli1=best;
    rsoli2=better;
end