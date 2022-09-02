% Compute frequency of weight and node functions

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

function [numWFs numNFs] = getWFnNF(net)
% Initializations
numWFs = zeros(1,7);
numNFs = zeros(1,3);
% Extract basic information
totNodes = size(net.nodes,2);
% Scan through nodes
for ni=1:totNodes
    
    % If node exists
    if ~nodeUnused2(net.nodes{ni},net.nodes,net.con)  
        % Check weight function and increment counter
        % 1
        if net.nodes{ni}.weightFunction > 0
            numWFs(net.nodes{ni}.weightFunction) = numWFs(net.nodes{ni}.weightFunction) + 1;
        end
%         if net.nodes{ni}.weightFunction == 1
%             numWFs(1) = numWFs(1) + 1;
%         elseif net.nodes{ni}.weightFunction == 2 % 2
%             numWFs(2) = numWFs(2) + 1;
%         elseif net.nodes{ni}.weightFunction == 3 % 3
%             numWFs(3) = numWFs(3) + 1;
%         elseif net.nodes{ni}.weightFunction == 4 % 4
%             numWFs(4) = numWFs(4) + 1;
%         elseif net.nodes{ni}.weightFunction == 5 % 5
%             numWFs(5) = numWFs(5) + 1;
%         elseif net.nodes{ni}.weightFunction == 6 % 6
%             numWFs(6) = numWFs(6) + 1;
%         end
        % Check node function and increment counter
        if net.nodes{ni}.nodeFunction > 0
            numNFs(net.nodes{ni}.nodeFunction) = numNFs(net.nodes{ni}.nodeFunction) + 1;
        end
        
%         if net.nodes{ni}.nodeFunction  == 1
%             numNFs(1) = numNFs(1) + 1;
%         elseif net.nodes{ni}.nodeFunction == 2 % 2
%             numNFs(2) = numNFs(2) + 1;
%         elseif net.nodes{ni}.nodeFunction == 3 % 3
%             numNFs(3) = numNFs(3) + 1;
%         end

    end
end



end

