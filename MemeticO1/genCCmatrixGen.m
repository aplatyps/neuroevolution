% Important note [30/04/13] 1. These functions (e.g. genCCmatrix3, etc.) need to be carefully
% redesigned. Especially with regards to error normalization. Look into the
% assumptions of error normalization. What types of data and what types of
% errors can you expect? Think of an error normalization that is fair to as
% many different types of data/error as possible. You also need to look at
% the solution pair selection functions. These functions also have
% assumptions that need to be made more accurate and general.
% -------------------------------------------------
% Generate complementary classification matrix
% Type 1: sum(min)/numPat; hard constraint on overlap and individual error
% Type 2: sum of all errors ...
% Type 3: Very similar to Type 1 except in the condition of individual
% errors (OR instead of AND, for individual err constraints).
% Type 4: This is not a complementary classification measure. This measure
% represents the error of the best solution; so ccMat-4 is more of a control condition.
% Type 5: This is not a complementary classification measure. This measure
% represents the combined error of each individual solution; so ccMat-5 is more of a control condition.
% Type 6: ... N11 * (N10 + N01) ...  [see Q statistic notation] [see
% Freenote notes too]
% Type 7: ... N11 * N10 * N01 ... [see Q statistic notation] [see
% Types 8 to 10: ... with pattern difficulty
% Type 11: N11+N10+N01.
% Freenote notes too]
function ccMatrix = genCCmatrixGen(sols,numPat,ccMatType)

if ccMatType == 1
    ccMatrix = genCCmatrix1(sols,numPat);
elseif ccMatType == 2
    ccMatrix = genCCmatrix2(sols,numPat);
elseif ccMatType == 3
    ccMatrix = genCCmatrix3(sols,numPat);
elseif ccMatType == 4
    ccMatrix = genCCmatrix4(sols,numPat);
elseif ccMatType == 5
    ccMatrix = genCCmatrix5(sols,numPat);
elseif ccMatType == 6
    ccMatrix = genCCmatrix6(sols,numPat);
elseif ccMatType == 7
    ccMatrix = genCCmatrix7(sols,numPat);
elseif ccMatType == 8
    ccMatrix = genCCmatrix8(sols,numPat);
elseif ccMatType == 9
    ccMatrix = genCCmatrix9(sols,numPat);
elseif ccMatType == 10
    ccMatrix = genCCmatrix10(sols,numPat);
elseif ccMatType == 11
    ccMatrix = genCCmatrix11(sols,numPat);
else
    disp('That CC matrix type does not exist.');
end
    

end

