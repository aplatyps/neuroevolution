% Function for generating initial solution set
% The leftmost column is for holding solution costs (evaluations) ("-1" means "not defined")
% --- Arguments
% - gsoParams: global stochastic optimization parameters
function solutions = initSolVar(gsoParams)

% Initialization parameters
minStdDev = 0.3;

% Extract basic information
[cost evalParams funcStat] = feval(gsoParams.costFuncName,[],[]);
numNodes = evalParams.numNodes;
limits = evalParams.limits;
% Initializations
solutions = [];

soli = 1;
% Loop while the num. sol. is < target
while soli <= gsoParams.ngSize
    % Create a random solution
    randVec = rand(1,gsoParams.numSolParams+1);
    minVal = gsoParams.paramRange(1);
    diff = gsoParams.paramRange(2) - minVal;
    randVec = minVal + (randVec*diff);
    randVec(1) = -1;
    % Create a network
    [net funcStat] = createKPH2sol(numNodes,limits,randVec(2:end),[]);
    % Create classification map
    classifImg = visKPH2gen2DnoPlot(net,0:0.1:1,0:0.1:1);
    % Compute standard deviation
    [yLeng xLeng] = size(classifImg);
    classifVec = reshape(classifImg,1,yLeng*xLeng);
    aStdDev = std(classifVec);
    % If the std. dev. is > thresh. then store the solution
    if aStdDev >= minStdDev
        if gsoParams.vis_verbose > 0
            disp(['Solution ' int2str(soli) ': std. dev. ' num2str(aStdDev)]);
        end
        solutions = [solutions; randVec];
        soli = soli + 1;
    end
    
end






