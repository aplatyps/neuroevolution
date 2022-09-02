% Divide the data-set into mutually excluse training and test sets
function [trainData testData] = createTrainTestData(data,propTrain)

if propTrain == 1
    trainData = data;
    testData = data;
    trainData.limits = data.limits;
    testData.limits = data.limits;
    return
end

% Extract basic information
numPat = size(data.in,1);
numIn = size(data.in,2);
numOut = size(data.out,2);
numTrain = round(propTrain*numPat);
numTest = numPat-numTrain;


% Create a random vector of pattern indeces
randIndeces = randperm(numPat);

% Initializations
trainData.in = zeros(numTrain,numIn);
trainData.out = zeros(numTrain,numOut);
testData.in = zeros(numTest,numIn);
testData.out = zeros(numTest,numOut);

% Scan through training patterns and add to trainData
for pi=1:numTrain
    randIndex = randIndeces(pi);
    trainData.in(pi,:) = data.in(randIndex,:);
    trainData.out(pi,:) = data.out(randIndex,:);
end

% Scan through test patterns and add to testData
testIndex = 1;
for pi=numTrain+1:numPat
    randIndex = randIndeces(pi);
    testData.in(testIndex,:) = data.in(randIndex,:);
    testData.out(testIndex,:) = data.out(randIndex,:);
	testIndex=testIndex+1;
end

trainData.limits = data.limits;
testData.limits = data.limits;



end

