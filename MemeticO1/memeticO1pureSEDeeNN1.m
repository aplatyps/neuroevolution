% Simple global stochastic optimization function based on several simple
% heuristics
function [packedSolutions miscRes] = memeticO1pureSEDeeNN1(costFuncName,trainData,testData,memParams,sol0)

% Basic info.
numPat = size(trainData.in,1);
memParams.numPat = numPat;
memParams.costFuncName = costFuncName;
numParamPerLayer = compAllNumEDeeNNperLayer(trainData.limits);

% Basic Inits
vecTestErr = [];

% Random seed
stream = RandStream('mt19937ar','seed',sum(100*clock));
RandStream.setGlobalStream(stream);
%RandStream.setDefaultStream(stream);

packedSolutions = [];

totEval = 0; % keep track of the total number of evaluations

if nargin < 4
    memParams.initSolFunc = 'initSolRand'; % 'initSolVar';
    memParams.costFuncName = costFuncName;
    memParams.maxIter = Inf; % max. num. of optimization iterations
    memParams.maxEval = Inf; % max. num. of evaluations
    memParams.minCost = 0; % minimum cost stopping condition
    %memParams.ngSize = 6; % size of next generation
    memParams.ngSize = 20; % size of next generation
    memParams.percTrim = 0.4; % NG-percentage of solutions to trim off the DE expanded solution set
    memParams.numSolParams = compNumEDeeNNparam(trainData.limits); % number of parameters in solution
    %memParams.numSolParams = 72; % number of parameters in solution
    memParams.paramRange = [0 1]; % range of solution parameter values
    memParams.minDiffLF = 0.1; % minimum difference between a leader and its immediate follower (see N1)
    %memParams.minDiffLL = 0.3; % min. difference between two consecutive leaders (see N1)
    memParams.minDiffLL = 0.5; %0.5;
    %memParams.minDiffTrim = 0.1; % minimum difference between sol. to be kept in the trimmed set
    memParams.minDiffTrim = 0.3;
    %memParams.alpha = 0.25; % DE rate; proportion to be applied to (leader-follower).
    memParams.alpha = 0.15;%0.9;% 0.15;
    memParams.gvAmplify = 20;
    memParams.mutRange = 0.2; % range of mutation (if range=0.2 mutations go from -0.2 to +0.2)
    memParams.mutProb = 0.5; %0.75; %0.8; %0.5; % probability of mutating a particular parameter
    memParams.fixParams = []; % [param1 val1; param2 val2 ...] Specify what parameters to fix to what value
    memParams.vis_verbose = 5; % verbosity (0: nothing; 1: text; 2: plot cost; 3: plot cost & sol. var. 4: cost and solution param
    memParams.saveEveryXgen = 1; % save every x generations
    memParams.storeIterBestSol = true; % store the best solution for every iteration?
    % "Deconstructed GSO" parameters
    memParams.doCrossOver = false;
    memParams.doProbMingle = true;
    memParams.doMutation = true;
    memParams.doDiffEvol = false;
    memParams.doIL = true;
    memParams.numCOSol = 10;
    memParams.numPMSol = 10;
    memParams.numMSol = 10;
    memParams.maxDESol = 10;
    % Individual learning parameters
    memParams.ilType = 8; % see doIndivLearn1 for the meaning of different types
    memParams.ilEveryGen = 1; % if x then do invidual learning every x generations
    memParams.ilNumSol = 10; % number of solutions to be targetted for individual learning
    memParams.ilNumParam = 2; % number of parameters to be targetted for individual learning
    memParams.ilNumIter = 10; % number of individual learning (local search) iterations
    %memParams.ilRandType = 1; % type of learning (1: new rand vals, 2: rand perturbations)
    memParams.pairSelect = 1;
    % CC parameters
    memParams.ccMatrixType = 3;
    %memParams.ccMatrixTypeFS = 0;
end

if nargin < 5
    % Initialize solutions
    if memParams.vis_verbose == 1 | memParams.vis_verbose == 2
        disp('****** Initializing solutions ...');
    end
    [sol0 numEval] = feval(memParams.initSolFunc,memParams,trainData);
    totEval = totEval + numEval;
    if isempty(sol0)
        disp('Could not initialize solutions. Please check your initialization function.');
        return
    end
end

% Check consistency of inputted solutions and parameters
if nargin == 5
    [yl1 xl1] = size(sol0);
    if xl1 == memParams.numSolParams
        sol0 = [-1 sol0];
    end
    if (xl1 < memParams.numSolParams) || (xl1 > memParams.numSolParams + 1)
        disp('Discrepancy between the inputted solutions and the GSO parameter set.');
        finalSolutions = -1;
        return
    end
end

% Evaluate solutions.
[sol0E trainData fs numEval] = evaluateSolutionsCC(sol0,costFuncName,trainData,memParams.vis_verbose);
totEval = totEval + numEval;
if fs ~= 0
    return;
end

% Sort solutions by quality (lowest cost is the best)
[solPostInit] = sortSolutionsCC(sol0E);

if memParams.vis_verbose == 1
    disp(['### Cost of best initial solution:' num2str(solPostInit(1,1))]);
end

% Plotting initialization
vecBestCost = [];
vecBestErr = [];
if memParams.vis_verbose >= 2
    vecMeanVar = [];
    figure
end

if memParams.vis_verbose == 2
    disp('Click the bottom-right quarter of the figure to stop optimizing.');
end

% Iterate through generations
bestCost = Inf;
dei = 1;
doStop = false;
if memParams.storeIterBestSol
    iterBestSol = [];
end

% Iterate through generations
while (totEval <= memParams.maxEval) && (dei <= memParams.maxIter) && (bestCost > memParams.minCost) && (~doStop)
    
    % *** Global expansions
    coSols = []; pmSols = []; mSols = []; deSols = [];
    % Cross-over
    if memParams.doCrossOver
        coSols = doCrossOver(solPostInit,memParams);
    end
    % Probabilistic mingling
    if memParams.doProbMingle
        pmSols = doProbMingle(solPostInit,memParams);
    end
    % Mutation
    if memParams.doMutation
        mSols = doMutation(solPostInit,memParams);
    end
    % Differential evolution
    if memParams.doDiffEvol
        deSols = doDifferential(solPostInit,memParams);
    end
    
    % Package, evaluate and sort
    solPostGlob = [solPostInit; coSols; pmSols; mSols; deSols];
    [solPostGlob trainData fs numEval] = evaluateSolutionsCC(solPostGlob,costFuncName,trainData,memParams.vis_verbose);
    totEval = totEval + numEval;
    if fs ~= 0
        return;
    end
    [solPostGlob] = sortSolutionsCC(solPostGlob);
    
    % *** Individual learning expansion
    % If you wish you can do individual/local learning here
    solPostIL = solPostGlob; % ignoring individual learning
    
    % *** Trim and expand
    % Trim the x% (of NG size) solutions that are sufficiently different from each other
    solPostInit = trimSolutionsGen(solPostIL,memParams);
    % Fill the remaining solutions with random solutions
    if memParams.vis_verbose == 1
        disp('*** Expanding solution set with random solutions ...');
    end
    solPostInit = genRemainRandCC(solPostInit,memParams);
    [solPostInit trainData fs numEval] = evaluateSolutionsCC(solPostInit,costFuncName,trainData,memParams.vis_verbose);
    totEval = totEval + numEval;
    if fs ~= 0
        return;
    end
    [solPostInit] = sortSolutionsCC(solPostInit);
    
    % *** Visualization, saving, etc.
    bestCost = solPostInit(1,1);
    if memParams.vis_verbose == 1
        disp(['### Cost of current best solution:' num2str(bestCost)]);
    end
    
    vecBestCost = [vecBestCost bestCost]; % store best cost at each iteration
    
    % Extract best raw solution
    bestRawSol = solPostInit(1,2+numPat:end);
    
    % Compute test error and store -------
    if ~isempty(testData)
        [testCost testData fs testErrPat] = feval(costFuncName, bestRawSol, testData);
        vecTestErr = [vecTestErr testCost];
    end
    % ------- Compute test error and store 
    
     % Compute layer change ------------
    if dei > 1
        layerChangesVec = compLayerChange(bestRawSol,prevBest,numParamPerLayer);
        layerChangesMat(dei-1,:) = layerChangesVec;
    end
    prevBest = bestRawSol;
    % ----------- Compute layer change
    
    % **** Visualizations
    if memParams.vis_verbose == 2
        % Cost
        if ~isempty(vecBestErr)
            subplot(1,2,1);
        end
        plot(1:dei,vecBestCost,'b');
        if ~isempty(vecBestErr)
            subplot(1,2,2);
            plot(1:dei,vecBestErr,'g');
        end
        xlabel('Generation');
        ylabel('Best cost');
        drawnow;
        % If click bottom-right stop
        rect = get(gcf,'OuterPosition');
        halfx = (rect(3)/2);
        halfy = (rect(4)/2);
        mousePos = (get(gcf,'CurrentPoint'));
        if mousePos(2) < halfy && mousePos(1) > halfx
            doStop = true;
        end
        
    elseif memParams.vis_verbose == 3
        % Mean variability
        aMeanVar = mean(std(solPostInit(:,2:end)));
        vecMeanVar = [vecMeanVar aMeanVar];
        % Plots
        % Cost
        subplot(1,2,1);
        plot(1:dei,vecBestCost,'b');
        xlabel('Generation');
        ylabel('Best cost');
        % Variability
        subplot(1,2,2);
        plot(1:dei,vecMeanVar,'r');
        xlabel('Generation');
        ylabel('Mean std. dev. of sol.');
        drawnow;
    elseif memParams.vis_verbose == 4
        % Cost
        
        if ~isempty(vecBestErr)
            subplot(1,3,1);
        else
            subplot(1,2,1);
        end
        plot(1:dei,vecBestCost,'b');
        
        if ~isempty(vecBestErr)
            subplot(1,3,2);
            plot(1:dei,vecBestErr,'g');
        end
        xlabel('Generation');
        ylabel('Best cost');
        drawnow;
        
        if ~isempty(vecBestErr)
            subplot(1,3,3);
        else
            subplot(1,2,2);
        end
        
        solImg = sol2RGB(solPostInit);
        imshow(solImg,[]);
        
        
        % If click bottom-right stop
        rect = get(gcf,'OuterPosition');
        halfx = (rect(3)/2);
        halfy = (rect(4)/2);
        mousePos = (get(gcf,'CurrentPoint'));
        if mousePos(2) < halfy && mousePos(1) > halfx
            doStop = true;
        end
        
        % *** DBG
        %         if dei == 1 || rem(dei,25) == 0
        %            [aNet funcStat] = createKPH2sol(evalParams.numNodes,evalParams.limits,solExpandS(1,2:end),[]);
        %             sn = structOptim(aNet);
        %             pause
        %         end
        % *******
    elseif memParams.vis_verbose == 5
        % Cost
        
        if ~isempty(vecBestErr)
            subplot(1,3,1);
        else
            subplot(1,2,1);
        end
        plot(1:dei,vecBestCost,'b');
        
        if ~isempty(vecBestErr)
            subplot(1,3,2);
            plot(1:dei,vecBestErr,'g');
        end
        xlabel('Generation');
        ylabel('Best cost');
        drawnow;
        
        if ~isempty(vecBestErr)
            subplot(1,3,3);
        else
            subplot(1,2,2);
        end
        
        solImg = sol2RGB(solPostInit);
        %imshow(solImg,[]);
        bar(trainData.weights);
        
        % If click bottom-right stop
        rect = get(gcf,'OuterPosition');
        halfx = (rect(3)/2);
        halfy = (rect(4)/2);
        mousePos = (get(gcf,'CurrentPoint'));
        if mousePos(2) < halfy && mousePos(1) > halfx
            doStop = true;
        end
        
    end
    
    % Store best solution
    if memParams.storeIterBestSol
        iterBestSol = [iterBestSol; solPostInit(1,2+numPat:end);];
    end
       
    dei=dei+1;
    
end

% Package results
numSol = size(solPostInit,1);
miscRes.trainErrors = vecBestCost;
miscRes.testErrors = vecTestErr;
miscRes.layerChanges = layerChangesMat;
miscRes.totGen = dei;
miscRes.totEval = totEval;
for si=1:numSol
    packedSolutions{si}.cost = solPostInit(si,1);
    packedSolutions{si}.rawParam = solPostInit(si,2+numPat:end);
end

end

