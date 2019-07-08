%%
function [newValue, newError] = getLeadingDigits(currValue, currError, numOfDigits)
    factor = 10^(floor(log10(currError)) + 1 - numOfDigits);
    
    newError = round(currError/factor)*factor;
    newValue = round(currValue/factor)*factor;
end