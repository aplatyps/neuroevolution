% Basic cross-over operator
function pmSols = doProbMingle(sols,memParams)

if memParams.probMingleType == 1
    pmSols = doProbMingle1(sols,memParams);
elseif memParams.probMingleType == 2
    pmSols = doProbMingle2(sols,memParams);
elseif memParams.probMingleType == 3
    pmSols = doProbMingle3(sols,memParams);
elseif memParams.probMingleType == 4
    pmSols = doProbMingle4(sols,memParams); % same as 1 except that solution pairs are chosen probabilistically
else
    pmSols = doProbMingle1(sols,memParams);
end
    

end

