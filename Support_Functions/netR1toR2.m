% Convert a network from representation R1 to representation R1
% Main differences to R1:
%  1- nodes are separated by type (indeces for I and O are stable)
%  2- the connection matrix is no longer used
%  3- each neuron, has to specify to which types of neurons their
%  inputs/outputs refer to
%  4- each neuron keeps information on the input weight too
function netR2 = netR1toR2(netR1)

    % *** Abandoned (08 Feb 13): decided on a simpler method for fusion

    % Separate nodes
    %[nodesI nodesM nodesO] = sepNodesR1toR2(netR1.nodes,netR1.numNodes.I,netR1.numNodes.M,netR1.numNodes.O);
    % Adjust indeces
    % Fix inputs/outputs
    % Add input weights
    % Delete raw-param
    % Delete connections



end

