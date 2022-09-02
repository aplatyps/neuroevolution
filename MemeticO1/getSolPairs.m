function fcoords = getSolPairs(ccMatrix)

% Extract basic information
numSol = size(ccMatrix,1);

% Extract coordinates
coords = [];
for si1=1:(numSol-1)
    for si2=si1+1:numSol
        qual = 1-ccMatrix(si1,si2); % convert error into quality (for prob.)
        aCoord = [qual si1 si2];
        coords = [coords; aCoord];
    end
end

% Sort coordinates
scoords = sortAccordCol(coords,1);
%fcoords = scoords;

% "Eliminate lower half"
numCoords = size(scoords,1);
halfC = round(numCoords/2);
fcoords = scoords(halfC:end,:);
% Normalize
minQual = min(fcoords(:,1));
fcoords(:,1) = fcoords(:,1) - minQual;
maxQual = max(fcoords(:,1));
fac = 1/maxQual;
fcoords(:,1) = fcoords(:,1) * fac;


end

