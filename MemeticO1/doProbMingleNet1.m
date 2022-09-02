% Basic probabilistic mingling; PM1 only on weights and parameters.
% Assume that the networks all have the same number of nodes and
% connections
function pmSols = doProbMingleNet1(sols,memParams)

% Extract basic information
numSol = size(sols,2);
numPat = memParams.numPat;
numNodes = size(sols{1}.nodes,2);
numCon = size(sols{1}.con,2);

% Intializations
pmSols = [];

% Scan through solutions
for si=1:memParams.numPMSol
    
    % Select random solution indeces
    if memParams.pairSelect == 1
        [rsoli1 rsoli2] = selSolPair1(numSol);
    else
        ccMatrix = genCCmatrixGenNet(sols,memParams.numPat,memParams.ccMatrixType);
        [rsoli1 rsoli2] = selSolPair2(ccMatrix,memParams);
    end
  
    %disp(['rsoli1: ' int2str(rsoli1) '  rsoli2: ' int2str(rsoli2)]);
    
    % Get solution pair and corresponding costs
    sol1 = sols{rsoli1};
    cost1 = sol1.cost;
    sol2 = sols{rsoli2};
    cost2 = sol2.cost;
    pmSols{si} = sol1; % solution 1 by default

    % If we knew what the global minimum was we could compute a more
    % accurate probOne. Later come up with other compromises.
    if cost1 < cost2
        probOne = 0.75;
    else
        probOne = 0.25;
    end
    
    % Scan parameters and select probabilistically
    % Scan nodes
    for ni=1:numNodes
        % Mingle autoWeight, bias and funcParams;
        randVal = rand;
        if randVal <= probOne
            pmSols{si}.nodes{ni}.autoWeight = sol1.nodes{ni}.autoWeight;
            pmSols{si}.nodes{ni}.bias = sol1.nodes{ni}.bias;
            if memParams.optimArchit == true
                pmSols{si}.nodes{ni}.weightFunction = sol1.nodes{ni}.weightFunction;
                pmSols{si}.nodes{ni}.nodeFunction = sol1.nodes{ni}.nodeFunction;
                pmSols{si}.nodes{ni}.funcParam = sol1.nodes{ni}.funcParam;
            end
        else
            pmSols{si}.nodes{ni}.autoWeight = sol2.nodes{ni}.autoWeight;
            pmSols{si}.nodes{ni}.bias = sol2.nodes{ni}.bias;
            if memParams.optimArchit == true
                pmSols{si}.nodes{ni}.weightFunction = sol2.nodes{ni}.weightFunction;
                pmSols{si}.nodes{ni}.nodeFunction = sol2.nodes{ni}.nodeFunction;
                pmSols{si}.nodes{ni}.funcParam = sol2.nodes{ni}.funcParam;
            end
        end
    end
    
    % Scan connections
    for ci=1:numCon
        % Mingle weights
        randVal = rand;
        if randVal <= probOne
            pmSols{si}.con{ci}.weight = sol1.con{ci}.weight;
            if memParams.optimArchit == true
                pmSols{si}.con{ci}.source = sol1.con{ci}.source;
                pmSols{si}.con{ci}.target = sol1.con{ci}.target;
            end
        else
            pmSols{si}.con{ci}.weight = sol2.con{ci}.weight;
            if memParams.optimArchit == true
                pmSols{si}.con{ci}.source = sol2.con{ci}.source;
                pmSols{si}.con{ci}.target = sol2.con{ci}.target;
            end
        end
        % If architecture then update source and targets.
        
    end
    
    % Cost and error pattern
    errPat = ones(1,numPat);
    pmSols{si}.cost = -1;
    pmSols{si}.errPat = errPat;
    
    
end



end

