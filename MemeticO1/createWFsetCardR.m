function weightFunctions = createWFsetCardR(WFs,aCard)
numWF = size(WFs,2);
rpvec = randperm(numWF);
weightFunctions = [];
for ci=1:aCard
    weightFunctions = [weightFunctions WFs(rpvec(ci))];
end
weightFunctions = sort(weightFunctions);

end

