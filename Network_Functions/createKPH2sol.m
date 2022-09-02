% Function for creating a KPH2 network based on parameters and limits
% ------ Arguments
% numNodes: numInputs (I), numMiddle (M), numOutput (O)
% limits: ranges for solution parameters
% aSolRaw: raw solution vector
% ------ Types
% 1 - input node
% 2 - middle node (interneuron)
% 3 - output node
% ------ Weight functions
% 1 - inner product
% 2 - Euclidean distance
% 3 - Higher-order (HO) product
% 4 - HO subtractive "variability"
% 5 - Standard deviation
% 6 - MIN
% 7 - MAX
% ------ Node functions
% 1 - identity
% 2 - sigmoid
% 3 - Gaussian
% ------ Status
% 0 - does not exist
% 1 - exists
% ------ Status of createKPH2sol
% 0 - no error
% 1 - error
% *** Notes ***********************
% [N1] When inputting a network via data.net, the fixed architectural
% aspects include: number and type of nodes, connection patterns, weight functions and node functions.
% [N2] If you want to extend the createKPH2sol function by adding new
% weight/node functions you need to make sure you also update runKPH2 (add a case),
% finalVis (in StructOptim) (line cases and instructions), getKPH2prop (getWFnNF), possibly evaluation functions
% (list of selected weight functions), evalKPH2PR3 (numWeightFuncs,
% numNodeFuncs).
function [netKPH2 funcStat] = createKPH2sol(numNodes,limits,aSolRaw,fixNet)


% Did we pass a network with the data?
if ~isempty(fixNet)
    onlyOptimWeights = true;
else
    onlyOptimWeights = false;
end

funcStat = 1;
nodesKPH2 = [];
conKPH2 = [];
% Check arguments
% Check that the number of raw parameters is consistent with numNodes
expectNumParam = compExpectNumParamKPH3(numNodes.I,numNodes.M,numNodes.O);
actualNumParam = max(size(aSolRaw));
if expectNumParam ~= actualNumParam
    disp(['The size of the parameter vector is inconsistent with the specified number of nodes.']);
    disp(['The parameter vector should have ' int2str(expectNumParam) ' parameters.']);
    return
end
% Specify the number of node and weight functions
numWeightFuncs = size(limits.weightFunctions,2);
numNodeFuncs = size(limits.nodeFunctions,2);
% Extract basic information
totNodes = numNodes.I+numNodes.M+numNodes.O;
% Initializations
paramIndex = 1;
conIndex = 1;
% Specify number of iterations
netKPH2.numIterations = ceil(aSolRaw(paramIndex)*limits.maxIter);
if netKPH2.numIterations == 0
    netKPH2.numIterations = 1;
end
paramIndex = paramIndex + 1;
% *** Create input nodes.
% Input nodes have no inputs from the rest of the network, only from data.

for ii=1:numNodes.I
    nodesKPH2{ii}.type = 1;
end

for ii=numNodes.I+1:numNodes.I+numNodes.M
    nodesKPH2{ii}.type = 2;
end
    
for ii=numNodes.I+numNodes.M+1:totNodes
    nodesKPH2{ii}.type = 3;
end

for ii=1:totNodes
    % Weight function
    if nodesKPH2{ii}.type == 1 && limits.inNoIn % If inputs allow no inward connections
        nodesKPH2{ii}.weightFunction = -1;
        nodesKPH2{ii}.nodeFunction = 1;
        nodesKPH2{ii}.autoWeight = 1;
        nodesKPH2{ii}.funcParam = [];
        nodesKPH2{ii}.bias = 0; % weights are setup in the connections
        nodesKPH2{ii}.value = 0;
        nodesKPH2{ii}.status = 1;
        nodesKPH2{ii}.inputs = [];
        nodesKPH2{ii}.outputs = [];
    else
        if onlyOptimWeights % if we are updating only the weights of an inputted network
            wfi = ceil(fixNet.rawParam(paramIndex)*numWeightFuncs);
            if wfi == 0
                wfi = 1;
            end
            nodesKPH2{ii}.weightFunction = limits.weightFunctions(wfi); % get func. from list of selected func.
            aSolRaw(paramIndex) = fixNet.rawParam(paramIndex); % copy param from fixNet to raw solution
        else
            wfi = ceil(aSolRaw(paramIndex)*numWeightFuncs);
            if wfi == 0
                wfi = 1;
            end
            nodesKPH2{ii}.weightFunction = limits.weightFunctions(wfi); % get func. from list of selected func.
        end
        paramIndex = paramIndex + 1;
        % Node function
        if onlyOptimWeights % if we are updating only the weights of an inputted network
            nfi = ceil(fixNet.rawParam(paramIndex)*numNodeFuncs);
            if nfi == 0
                nfi = 1;
            end
            nodesKPH2{ii}.nodeFunction = limits.nodeFunctions(nfi);
            aSolRaw(paramIndex) = fixNet.rawParam(paramIndex); % copy param from fixNet to raw solution
        else
            nfi = ceil(aSolRaw(paramIndex)*numNodeFuncs);
            if nfi == 0
                nfi = 1;
            end
            nodesKPH2{ii}.nodeFunction = limits.nodeFunctions(nfi);
        end
        paramIndex = paramIndex + 1;
        % Autoweight
        % Interpret weight according to weight function
        adjW = aSolRaw(paramIndex);
        paramIndex = paramIndex + 1;
        if nodesKPH2{ii}.weightFunction == 1
            adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
        end
        nodesKPH2{ii}.autoWeight = adjW;
        % Function parameter
        if nodesKPH2{ii}.nodeFunction == 1
            nodesKPH2{ii}.funcParam = [];
        elseif nodesKPH2{ii}.nodeFunction == 2
            nodesKPH2{ii}.funcParam = putInRange(aSolRaw(paramIndex),limits.sig_minFP,limits.sig_maxFP);
        else
            nodesKPH2{ii}.funcParam = zeros(1,2);
            nodesKPH2{ii}.funcParam(1) = putInRange(aSolRaw(paramIndex),limits.gaus_minFP1,limits.gaus_maxFP1);
            nodesKPH2{ii}.funcParam(2) = putInRange(aSolRaw(paramIndex+1),limits.gaus_minFP2,limits.gaus_maxFP2);
        end
        paramIndex = paramIndex + 2;
        % Bias
        adjW = aSolRaw(paramIndex);
        paramIndex = paramIndex + 1;
        if nodesKPH2{ii}.weightFunction == 1
            adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
        end
        nodesKPH2{ii}.bias = adjW;
        nodesKPH2{ii}.value = 0;
        % Status
        if nodesKPH2{ii}.type == 3 % output nodes always exist
            nodesKPH2{ii}.status = 1;
        else
            if limits.allNodesExist
                nodesKPH2{ii}.status = 1;
            else
                if onlyOptimWeights % if we are updating only the weights of an inputted network
                    nodesKPH2{ii}.status = round(fixNet.rawParam(paramIndex));
                    aSolRaw(paramIndex) = fixNet.rawParam(paramIndex); % copy param from fixNet to raw solution
                else
                    if limits.allNodesExist
                        nodesKPH2{ii}.status = 1;
                    else
                        nodesKPH2{ii}.status = round(aSolRaw(paramIndex));
                    end
                end
            end
        end
        paramIndex = paramIndex + 1;
        % Input and outputs
        nodesKPH2{ii}.inputs = [];
        nodesKPH2{ii}.outputs = [];
    end
end


% *** Set up connections
% Scan middle and output nodes
%firstMiddle = numNodes.I+1;
doubleTotNodes = totNodes*2;
for ni=1:totNodes
    firstParam = paramIndex;
    lastParam = firstParam+doubleTotNodes-1;
    % Scan raw parameters
    sourceIndex = 1;
    for pi=firstParam:2:lastParam
        % If all "connection must exist" or the "DNA" states that a connections exists
        % then create a connection (source, target, weight)
        
        if onlyOptimWeights % if we are updating only the weights of an inputted network
            aSolRaw(pi) = fixNet.rawParam(pi); % the status of the current connection should be the same as the inputted one
        end
        
        if (limits.allConExist && (sourceIndex ~= ni)) || ((round(aSolRaw(pi)) == 1) && (sourceIndex ~= ni)) % some buffer "DNA" is allowed for switching the last cond. on/off
            % Check other constraints (inNoIn and outNoOut)
            if  ~(nodesKPH2{ni}.type == 1 && limits.inNoIn) && ~(nodesKPH2{sourceIndex}.type == 3 && limits.outNoOut) && ~(nodesKPH2{ni}.type == 3 && nodesKPH2{sourceIndex}.type == 1 && limits.noIn2Out) && ~(nodesKPH2{ni}.type == 2 && nodesKPH2{sourceIndex}.type == 2 && limits.noMid2Mid)
                % Create a connection
                conKPH2{conIndex}.source = sourceIndex;
                conKPH2{conIndex}.target = ni;
                % Adjust weight according to weight function
                adjW = aSolRaw(pi+1);
                if nodesKPH2{ni}.weightFunction == 1
                    adjW = putInRange(adjW,limits.P_minWB,limits.P_maxWB);
                end
                conKPH2{conIndex}.weight = adjW;
                % Update the source and the target with a reference to the connection index
                nodesKPH2{ni}.inputs = [nodesKPH2{ni}.inputs conIndex];
                nodesKPH2{sourceIndex}.outputs = [nodesKPH2{sourceIndex}.outputs conIndex];
                % Update connection index
                conIndex = conIndex + 1;
            end
        end
        sourceIndex = sourceIndex + 1;
    end
    % Update paramIndex
    paramIndex = paramIndex+doubleTotNodes;
end
funcStat = 0;


netKPH2.numNodes = numNodes;
netKPH2.limits = limits;
netKPH2.nodes = nodesKPH2;
netKPH2.con = conKPH2;
netKPH2.rawParam = aSolRaw;

end

