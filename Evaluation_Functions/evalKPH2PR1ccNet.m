% Optimize relative to some data-set
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
function [cost errPat data funcStat] = evalKPH2PR1ccNet(netKPH2,data)

% *** Tests for imbalanced data-sets
% Note: later elaborate this so that it is more general (e.g. outputs with
% more than one node; outputs with a range of values (not just 0/1) )
doImbalTest = false;
if doImbalTest
    % Count number of 0s and 1s
    [numZeros numOnes] = countZeroesOnes(data.out);
end
% *******************************************
    
% Initializations
funcStat = 1; % error
cost = Inf;
errPat = [];

% Extract basic information
numPatterns = size(data.in,1);
limits = netKPH2.limits;
numNodes = netKPH2.numNodes;

% Check compatibility of num. inputs and data
if numNodes.I ~= size(data.in(1,:),2)
    disp('The number of input nodes is inconsistent with the data.');
    return
end

% Scan through patterns
cost = 0;
for pati=1:numPatterns
    
    % Run pattern through KPH1 network
    [netOut postNetKPH2 funcStat activHist] = runKPH2(data.in(pati,:),netKPH2);
    % Compute error
    anError = computeError1(netOut,data.out(pati,:));
    
    % *** Test imbalanced data
%     if doImbalTest
%         % Assuming one output; values = 0 or 1
%         if data.out(pati,1) == 1
%             anError = anError/numOnes;
%         else
%             anError = anError/numZeros;
%         end
%         
%     end
    % ***********************
    
    % Add to cost
    cost = cost + anError;
    errPat = [errPat anError];
end


cost = cost / numPatterns;

if limits.allWFpresent
    hasWFs = checkHasWFs(limits.weightFunctions, netKPH2);
    if ~hasWFs
        cost = Inf;
    end
end

funcStat = 0; % function completed without errors


end

