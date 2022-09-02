% TM0: This is the original trimming function from GSO1
% TM1: First attempt of some sort of fitness sharing based on CC. Select
% best solutions in terms of CC error.
% TM2: First 50% of trimmed set are best individual solutions; remaining
% 50% are best paired solutions (with first set) in terms of CC error.
% TM3: Blind random selection of solutions (for comparison purposes).
function sols = trimSolutionsGenNet(sols,memParams)

if memParams.trimMethod ~= 0
    disp('As of 12/03/13 only trim method 0 is implemented.');
end

sols = trimSolutionsNetM0(sols,memParams);


end

