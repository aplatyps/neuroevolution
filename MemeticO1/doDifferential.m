% Basic cross-over operator
function difSols = doDifferential(sols,memParams)

if memParams.differentialType == 1
    difSols = doDifferential1(sols,memParams);
elseif memParams.differentialType == 2
    difSols = doDifferential2(sols,memParams);
else
    difSols = doDifferential2(sols,memParams);
end
    

end

