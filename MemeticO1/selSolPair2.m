% Select solution pairs with a probability that is inversely proportional
% to their complementary error.
% ccMatrix -> numSol x numSol; normalized to 0 to 1. (0 = zero compl.err)
function [ri1 ri2] = selSolPair2(ccMatrix,memParams)

maxCCerr = memParams.maxCCerr4solsel;

numSol = size(ccMatrix,1);

% Select random value
% If val. >= cc value then keep solution pair. This may need some
% adjustment.

% While a solution has not been found do
% *******************************************************
solFound = false;
validInds = [];
% Extract valid indeces
for si1=1:numSol
    for si2=1:numSol
        if ccMatrix(si1,si2) <= maxCCerr
            coord = [si1 si2];
            validInds = [validInds; coord];
        end
    end
end

numValid = size(validInds,1);
if numValid == 0 % No solution pairs satisfying the constraints
    ri1 = ceil(rand*numSol);
    ri2 = ceil(rand*numSol);
    if ri1 == 0
        ri1 = 1;
    end
    if ri2 == 0
        ri2 = 1;
    end
else
    randSel = ceil(rand*numValid);
    if randSel == 0
        randSel = 1;
    end
    ri1 = validInds(randSel,1);
    ri2 = validInds(randSel,2);
end
% ***********************************************

% ******** Select the min err ***
% coord = [1 1];
% minCC = Inf;
% for si1=1:numSol
%     for si2=1:numSol
%         if ccMatrix(si1,si2) < minCC
%             minCC = ccMatrix(si1,si2);
%             coord = [si1 si2];
%         end
%     end
% end
% ri1 = coord(1);
% ri2 = coord(2);
% *******************************

% while ~solFound
%     % Generate two random indeces
%     ri1 = ceil(rand*numSol);
%     ri2 = ceil(rand*numSol);
%     % Generate a random value
%     %rVal = rand;
%     % If the random val. >= cc. err then keep
%     %if rVal >= ccMatrix(ri1,ri2)
%     %    solFound = true;
%     %end
%     if ccMatrix(ri1,ri2) <= 0.25
%         solFound = true;
%     end
% end



end

