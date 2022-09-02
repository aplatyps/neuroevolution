% Mutate one particular solution
function aSol = mutateSolNet(aSol,memParams)
    % Extract basic information
    limits = aSol.limits;
    range = 2*memParams.mutRange;
    minWeight = limits.P_minWB;
    maxWeight = limits.P_maxWB;
    numCon = size(aSol.con,2);
    numNodes = size(aSol.nodes,2);

    % Scan connections
    for ci=1:numCon
        % Mutate
        % Generate a random value within the accepted range
        randVal = (rand*range)-memParams.mutRange;
        aSol.con{ci}.weight = aSol.con{ci}.weight + randVal;
        % Check limits
        if aSol.con{ci}.weight < minWeight
            aSol.con{ci}.weight = minWeight;
        elseif  aSol.con{ci}.weight > maxWeight
            aSol.con{ci}.weight = maxWeight;
        end
    end

    % Scan nodes
    for ni=1:numNodes
        % --- Mutate autoWeight
        randVal = (rand*range)-memParams.mutRange;
        aSol.nodes{ni}.autoWeight = aSol.nodes{ni}.autoWeight + randVal;
        % Check limits
        if aSol.nodes{ni}.autoWeight < minWeight
            aSol.nodes{ni}.autoWeight = minWeight;
        elseif  aSol.nodes{ni}.autoWeight > maxWeight
            aSol.nodes{ni}.autoWeight = maxWeight;
        end
        % --- Mutate autoWeight
        randVal = (rand*range)-memParams.mutRange;
        aSol.nodes{ni}.bias = aSol.nodes{ni}.bias + randVal;
        % Check limits
        if aSol.nodes{ni}.bias < minWeight
            aSol.nodes{ni}.bias = minWeight;
        elseif  aSol.nodes{ni}.bias > maxWeight
            aSol.nodes{ni}.bias = maxWeight;
        end
        % ---Mutate funcParams;
        if (aSol.nodes{ni}.nodeFunction == 2) % Sigmoid; type 2; 1 param
            randVal = (rand*range)-memParams.mutRange;
            tmpVal = aSol.nodes{ni}.funcParam + randVal;
            aSol.nodes{ni}.funcParam = clip2bounds(tmpVal,limits.sig_minFP,limits.sig_maxFP);
        elseif (aSol.nodes{ni}.nodeFunction == 3) % Gaussian; type 3; 2 param
            % Func param 1
            randVal = (rand*range)-memParams.mutRange;
            tmpVal = aSol.nodes{ni}.funcParam(1) + randVal;
            aSol.nodes{ni}.funcParam(1) = clip2bounds(tmpVal,limits.gaus_minFP1,limits.gaus_maxFP1);
            % Func param 2
            randVal = (rand*range)-memParams.mutRange;
            tmpVal = aSol.nodes{ni}.funcParam(2) + randVal;
            aSol.nodes{ni}.funcParam(2) = clip2bounds(tmpVal,limits.gaus_minFP2,limits.gaus_maxFP2);
        end
end




