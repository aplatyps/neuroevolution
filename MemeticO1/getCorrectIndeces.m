function correctIndeces = getCorrectIndeces(errPat1,errPat2)
numPat = size(errPat1,2);
correctIndeces = [];
for pi=1:numPat
    if errPat1(pi) == 0 || errPat2(pi) == 0
        correctIndeces = [correctIndeces pi];
    end
end

end

