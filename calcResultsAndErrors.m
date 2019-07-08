%% Print the final results with errors
function [valResX, valResY, valResDelX, valResDelY] = calcResultsAndErrors(matrixChiSquare, vecX, vecY)
    % Calc the contour matrix
    matrixContour = contourc(vecX, vecY, matrixChiSquare, 1:2);
    
    % Find results
    [vecFirstLevelX, vecFirstLevelY] = analyzeMatrixContour(matrixContour);
    maxValX = max(vecFirstLevelX);
    minValX = min(vecFirstLevelX);
    maxValY = max(vecFirstLevelY);
    minValY = min(vecFirstLevelY);

    valResX = (maxValX + minValX)/2;
    valResY = (maxValY + minValY)/2;
    
    valResDelX = (maxValX - minValX)/2;
    valResDelY = (maxValY - minValY)/2;
end