% Function for computing the error relative to a net and a data set
function error = compGlobErrMLP(net,data)
% Get number of patterns
numPatterns = size(data.in,1);
% Scan through patterns
p = data.in';

error = 0;
for pati=1:numPatterns
    % Run network with inputs
    netOut = sim(net,p(:,pati));
    % Compute error and accumulate
    anError = computeError1(netOut,data.out(pati,:));
    error = error + anError;
end

error = error / numPatterns;

end

