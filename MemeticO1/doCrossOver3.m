%% ---------------------------------------
% Uniform Cross-over Algorithm
%
% Description:
% Randomly chooses between 2 chromosomes and takes parts of the
% chromosome up to a certain cut-off point as an offspring. 
% The process is repeated until a full chromosome is reproduced
%
% @input: list of solutions, model parameters
% @return: list of chromosomes
%
%% ----------------------------------------

function coSols = doCrossOver3(sols, memParams)
    
    % Basic info
    numPat = memParams.numPat;
    [yLeng xLeng] = size(sols);
    numSol = yLeng;
    numParam = xLeng-1-memParams.numPat; % -1 because of cost & errPats
    % Basic initializations
    coSols = [];
    pSize = memParams.ngSize;
    solst = sols;    
    
    for si=1:memParams.numCOSol
        aCOSol = [];
        
        % Select solution indeces with tournament selection   
        if memParams.pairSelect == 1
            [rsoli1 rsoli2] = tourSel(solst,pSize);
        % Select random solution indeces
        else 
            [rsoli1 rsoli2] = selSolPair1(numSol);
        end
        
        % Rewrite complete solutions
        sol1 = sols(rsoli1,2+numPat:end);
        cost1 = sols(rsoli1,1);
        sol2 = sols(rsoli2,2+numPat:end);
        cost2 = sols(rsoli2,1);
        
        % Do uniform crossover
        idx = 0;
        while idx ~= numParam || idx < numParam
            idx = idx + 1;
            
            % Select random solution
            rsol = randi([1 2],1);
            if rsol == 1
                s = sol1;
            else 
                s = sol2;
            end
            
            if idx == numParam
                aCOSol = [aCOSol s(idx)];
                break;
            end
            
            % Select random cut-off point
            rcut = randi([idx+1 numParam],1); 
            
            % Cross-over
            for i = idx:rcut
                aCOSol = [aCOSol s(i)];
            end
            idx = rcut;            
        end
        errPat = ones(1,numPat);   
        coSols = [coSols; -1 errPat aCOSol];
    end
    
end