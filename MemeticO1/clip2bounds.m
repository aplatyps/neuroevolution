function aVal = clip2bounds(aVal,minVal,maxVal)
if aVal < minVal
    aVal = minVal;
elseif aVal > maxVal
    aVal = maxVal;
end

end

