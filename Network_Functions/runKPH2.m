% Create Kernel Projection Higher-Order 2 (KPH2) network
% Notes: weights (i.e. [0,1]) are interpreted according to the weight function (e.g. [-1,+1]).
% ------ Arguments
% pattern: pattern for input neurons
% nodesKPH2: KPH2 nodes
% conKPH2: KPH2 connections
% ------ Some attributes of nodesKPH2
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
% ------ Node status
% 0 - does not exist
% 1 - exists
% ------ Function status
% 0 - no error
% 1 - error
function [out netKPH2 funcStat activHist] = runKPH2(pattern,netKPH2)


funcStat = 1;
out = [];
% Extract basic information
numI = netKPH2.numNodes.I;
numM = netKPH2.numNodes.M;
numO = netKPH2.numNodes.O;
% Check number of nodes
totNodes = max(size(netKPH2.nodes));
if totNodes ~= (numI+numM+numO)
    disp(['Number of nodes incompatibility.']);
    return
end
lengPat = max(size(pattern));
% Basic initializations
out = [];
activHist = zeros(netKPH2.numIterations,totNodes);
% Check pattern and input size compatibility
if lengPat ~= numI
    disp('The size of the pattern and the number of input neurons is different.');
    return
end

% Network iterations
for iter=1:netKPH2.numIterations
    % Use buffers
    bufNet = netKPH2;
    % Scan through all nodes
    for nodei=1:totNodes
        % If the node does not exist, skip it
        if netKPH2.nodes{nodei}.status == 0
            continue
        end
        
       
        % *** Weight function
        switch netKPH2.nodes{nodei}.weightFunction
            case 1 % inner product
                aSum = 0;
                % Autovalue
                anAutoWeight = netKPH2.nodes{nodei}.autoWeight;
                %anAutoWeight = 0;
                aSum = aSum + (anAutoWeight*netKPH2.nodes{nodei}.value);
                % Input connections
                % Get number of connections
                numCon = size(netKPH2.nodes{nodei}.inputs,2);
                % Scan connections
                for coni=1:numCon
                    % Get weight and value
                    actualConi = netKPH2.nodes{nodei}.inputs(coni);
                    aWeight = netKPH2.con{actualConi}.weight;
                    sourceIndex = netKPH2.con{actualConi}.source;
                    if netKPH2.nodes{sourceIndex}.status == 1
                        aValue = netKPH2.nodes{sourceIndex}.value;
                        % Add to sum
                        aSum = aSum + (aWeight*aValue);
                    end
                end
                % Bias
                aSum = aSum + netKPH2.nodes{nodei}.bias;
                % Store current value (result of weight function)
                bufNet.nodes{nodei}.value = aSum;
                
            case 2 % Euclidean distance
                % Initialize sum
                aSum = 0;
                % No auto value
                % Scan through connections
                numCon = size(netKPH2.nodes{nodei}.inputs,2);
                for coni=1:numCon
                    % Square of difference; add to sum
                    actualConi = netKPH2.nodes{nodei}.inputs(coni);
                    aWeight = netKPH2.con{actualConi}.weight;
                    sourceIndex = netKPH2.con{actualConi}.source;
                    if netKPH2.nodes{sourceIndex}.status == 1
                        aValue = netKPH2.nodes{sourceIndex}.value;
                        sqrDiff = (aWeight-aValue)^2;
                        aSum = aSum + sqrDiff;
                    end
                end
                % Compute square root and copy to value
                bufNet.nodes{nodei}.value = sqrt(aSum);
                
            case 3 % higher-order product
                % Initialize product
                prodConstant = 5;
                aProd = 1;
                % Scan through connections
                numCon = size(netKPH2.nodes{nodei}.inputs,2);
                for coni=1:numCon
                    % Multiply
                    actualConi = netKPH2.nodes{nodei}.inputs(coni);
                    sourceIndex = netKPH2.con{actualConi}.source;
                    if netKPH2.nodes{sourceIndex}.status == 1
                        %aValue = netKPH2.nodes{sourceIndex}.value;
                        aValue = prodConstant*netKPH2.con{actualConi}.weight*netKPH2.nodes{sourceIndex}.value;
                        aProd = aProd * aValue;
                    end
                end
                % Copy into value
                bufNet.nodes{nodei}.value = aProd;
                
            case 4 % higher-order subtractive variability
                
               % Initialize sum
                aSum = 0;
                % Scan through connections
                numCon = size(netKPH2.nodes{nodei}.inputs,2);
                if numCon > 1
                    % Get first connection with an "existing" input
                    coni1 = getFirstActiveCon(netKPH2.nodes,netKPH2.con,netKPH2.nodes{nodei}.inputs);
                    if coni1 > 0 && coni1 < numCon
                        % Scan through remaining connections with "existing
                        % inputs".
                        actualCon1 = netKPH2.nodes{nodei}.inputs(coni1);
                        source1 = netKPH2.con{actualCon1}.source;
                        val1 = netKPH2.nodes{source1}.value;
                        for coni2 = coni1+1:numCon
                            % Add the abs of the difference between the "first" input
                            % and every other input
                            actualCon2 = netKPH2.nodes{nodei}.inputs(coni2);
                            source2 = netKPH2.con{actualCon2}.source;
                            if netKPH2.nodes{source2}.status == 1
                                val2 = netKPH2.nodes{source2}.value;
                                aSum = aSum + abs(val1-val2);
                                %aSum = aSum + abs((netKPH2.con{actualCon1}.weight*val1)-(netKPH2.con{actualCon2}.weight*val2));
                            end
                        end
                    end
                end
                
                % Copy aSum to the node's value
                bufNet.nodes{nodei}.value = aSum;
                
            case 5 % Standard deviation weighted by the sum of activeWeights
                
                % Collect all inputs from active nodes
                [activeInVec activeWeights] = getActiveInputs(netKPH2.nodes,netKPH2.con,netKPH2.nodes{nodei}.inputs);
                % Compute standard deviation
                aVal = sum(activeWeights)*std(activeInVec);
                if isnan(aVal)
                    aVal = 0;
                end
                bufNet.nodes{nodei}.value = aVal;
                
            case 6 % MIN
                                
                % Collect all inputs from active nodes
                [activeInVec activeWeights] = getActiveInputs(netKPH2.nodes,netKPH2.con,netKPH2.nodes{nodei}.inputs);
                prodInW = activeInVec.*activeWeights;
                aVal = min(prodInW);
                if isempty(prodInW) | isnan(aVal)
                    aVal = 0;
                end
                bufNet.nodes{nodei}.value = aVal;
                
            otherwise % MAX
                
                % Collect all inputs from active nodes
                [activeInVec activeWeights] = getActiveInputs(netKPH2.nodes,netKPH2.con,netKPH2.nodes{nodei}.inputs);
                prodInW = activeInVec.*activeWeights;
                aVal = max(prodInW);
                if isempty(prodInW) | isnan(aVal)
                    aVal = 0;
                end
                bufNet.nodes{nodei}.value = aVal;
                
        end
        
        % If the node is an input node, add pattern information
        if netKPH2.nodes{nodei}.type == 1
            bufNet.nodes{nodei}.value = bufNet.nodes{nodei}.value + pattern(nodei);
        end
        
        % *** Node function
        switch netKPH2.nodes{nodei}.nodeFunction
            
            case 2 % Sigmoid
                
                bufNet.nodes{nodei}.value = simpleSigmoid(bufNet.nodes{nodei}.value,netKPH2.nodes{nodei}.funcParam(1));
                
            case 3 % Gaussian
                
                bufNet.nodes{nodei}.value = simpleGaussCut(bufNet.nodes{nodei}.value,netKPH2.nodes{nodei}.funcParam(1),netKPH2.nodes{nodei}.funcParam(2));
                
            otherwise % identity
                % nothing
        end
        
        activHist(iter,nodei) = bufNet.nodes{nodei}.value;
        
    end
    % Copy buffer to the actual network
    netKPH2 = bufNet;
    
end

out = extractOutValues2(netKPH2);

funcStat = 0;

end



