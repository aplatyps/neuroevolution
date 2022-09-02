function val = simpleGaussCut(x,width,cutThresh)

val = exp(-(x^2)/width);

if val >= cutThresh
    val = 1;
end


end

