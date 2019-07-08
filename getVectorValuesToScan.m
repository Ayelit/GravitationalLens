%% Return vector of value to scan
function [vecValues] = getVectorValuesToScan(estimatedValue, stepsAmount, startPercentage, endPercentage)
    % Define the parameter's scan range
    startValue = estimatedValue * (1 - startPercentage/100);
    endValue = estimatedValue * (1 + endPercentage/100);

    % Define the parameter's scan step size
    stepSize = (endValue - startValue)/(stepsAmount - 1);
    
    % Define the parameter's values
    vecValues = startValue:stepSize:endValue;
end