% Compute frequency of weight and node associations

% ------ Weight functions
% 1 - inner product
% 2 - Euclidean distance
% 3 - Higher-order (HO) product
% 4 - HO subtractive "variability"
% 5 - "HO" standard deviation 1
% 6 - "HO" standard deviation 2
% ------ Node functions
% 1 - identity
% 2 - sigmoid
% 3 - Gaussian

% x version: extra statistics

function [weakIndividAssoc strongIndividAssoc individAssoc totalAssoc xstat] = getWFnNFassocsNDM1x()

% Basic parameters
rootfilename = 'resKPH2pap1exp1data';
numDatasets = 10;
numWF = 7;
numNF = 3;

% Initializations
% Give space for "zeros" (undefined WFs and NFs)
totalAssoc = zeros(numWF+1,numNF+1);
xstat.hoprodGaussOut = 0; % num. HO-prod./Gauss. at output node
xstat.hoprodGaussOutGTlarge = 0; % num. HO-prod./Gauss. at output node & GT > 1
for di=1:numDatasets
	individAssoc{di} = zeros(numWF+1,numNF+1);
    weakIndividAssoc{di} = zeros(numWF+1,numNF+1); % association for those networks whose error is > than median
    strongIndividAssoc{di} = zeros(numWF+1,numNF+1); % association for those networks whose error is <= than median
end

% Scan through datasets
for di=1:numDatasets
	% Load data and get number of networks
	data = load([rootfilename int2str(di) '.mat']);
	nets = data.allNets{di};
	numNets = size(nets,2);
    % Compute median 
    medianCost = compMedianCost1(nets);
	% Scan through networks
	for neti=1:numNets
		numNodes = size(nets{neti}.nodes,2);
		% Scan through nodes
		for nodi=1:numNodes
            
            if nodeUnused2(nets{neti}.nodes{nodi},nets{neti}.nodes,nets{neti}.con)
                continue
            end
            
			% Increment WF/NF associations (individual and total)
			aWF = nets{neti}.nodes{nodi}.weightFunction;
            if aWF < 1 | aWF > numWF
                aWF = 0;
            end
			aNF = nets{neti}.nodes{nodi}.nodeFunction;
            if aNF < 1 | aNF > numNF
                aNF = 0;
            end
			individAssoc{di}(aWF+1,aNF+1) = individAssoc{di}(aWF+1,aNF+1) + 1;
			totalAssoc(aWF+1,aNF+1) = totalAssoc(aWF+1,aNF+1) + 1;
            % Associations of weak and strong solutions
            if nets{neti}.propertiesCell.cost > medianCost
                weakIndividAssoc{di}(aWF+1,aNF+1) = weakIndividAssoc{di}(aWF+1,aNF+1) + 1;
            else
                strongIndividAssoc{di}(aWF+1,aNF+1) = strongIndividAssoc{di}(aWF+1,aNF+1) + 1;
            end
            % HO-prod./Gauss at out
            if aWF == 3 && aNF == 3 && nets{neti}.nodes{nodi}.type == 3
                xstat.hoprodGaussOut = xstat.hoprodGaussOut + 1;
            end
            % HO-prod./Gauss at out & GT > 1
            if aWF == 3 && aNF == 3 && nets{neti}.nodes{nodi}.type == 3 && nets{neti}.nodes{nodi}.funcParam(2) > 1
                xstat.hoprodGaussOutGTlarge = xstat.hoprodGaussOutGTlarge + 1;
            end
		end
	end
end

end

