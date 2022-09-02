function totDiffic = comp1stOrderDiffic(allDiffic,errPat1,errPat2)

% Compute correct indeces
correctIndeces = getCorrectIndeces(errPat1,errPat2);

% Compute this specific difficulty
totDiffic = 0;
numCorrect = size(correctIndeces,2);
for ci=1:numCorrect
    totDiffic = totDiffic + allDiffic(correctIndeces(ci));
end

totDiffic = totDiffic / numCorrect;

end

