% Generate complementary classification matrix
% Type 1: sum(min)/numPat; hard constraint on overlap and individual error
% Type 2: sum of all errors ...
% Type 3: Very similar to Type 1 except in the condition of individual
% errors (OR instead of AND, for individual err constraints).
% Type 4: This is not a complementary classification measure. This measure
% represents the error of the best solution; so ccMat-4 is more of a control condition.
% Type 5: This is not a complementary classification measure. This measure
% represents the combined error of each individual solution; so ccMat-5 is more of a control condition. 
function ccMatrix = genCCmatrixGenNet(sols,numPat,ccMatType)

if ccMatType ~= 3
    disp('[12/03/13] Currently, only genCCmatrixNet3 is implemented.');
end

ccMatrix = genCCmatrixNet3(sols,numPat);


   
end

