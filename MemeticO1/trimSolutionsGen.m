% TM0: This is the original trimming function from GSO1
function sols = trimSolutionsGen(sols,memParams)

if memParams.trimMethod == 0
    sols = trimSolutionsM0(sols,memParams);
else
    sols = trimSolutionsM0(sols,memParams);
end

end

