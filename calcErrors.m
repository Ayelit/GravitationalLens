%% Print the final results with errors
function [valResX, valResY, valResDelX, valResDelY] = calcErrors(matrixChiSquare, vecX, vecY)
    % Calc error for tau & u min
    [indexesY, indexesX] = find(matrixChiSquare <= 1.1);
    
    maxValX = vecX(max(indexesX));
    minValX = vecX(min(indexesX));
    maxValY = vecY(max(indexesY));
    minValY = vecY(min(indexesY));

    valResX = (maxValX + minValX)/2;
    valResY = (maxValY + minValY)/2;
    
    valResDelX = (maxValX - minValX)/2;
    valResDelY = (maxValY - minValY)/2;
end