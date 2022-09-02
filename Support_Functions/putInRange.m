% Function for normalizing parameters into specified ranges
function normParam = putInRange(rawParam,minR,maxR)
diffRange = maxR-minR;
normParam = minR+(rawParam*diffRange);

end

