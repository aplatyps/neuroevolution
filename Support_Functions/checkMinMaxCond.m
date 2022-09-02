% Check whether 
function minMaxCond = checkMinMaxCond(min1,max1,classifMap)

min2 = min(min(classifMap));
max2 = max(max(classifMap));

if min2 <= min1 && max2 >= max1
    minMaxCond = true;
else
    minMaxCond = false;
end


end

