%% Analye results
function [minChiSquareVal, valResX, valResY] = analyzeResults(analyzeIndex, eventName, matrixChiSquare, vecX, vecY, minIndexX, minIndexY, labelX, labelY, realValX, realValY, realValDelX, realValDelY)
    % Extract results values
    minChiSquareVal = matrixChiSquare(minIndexX, minIndexY);
    matrixDeltaChiSquare = matrixChiSquare - minChiSquareVal;
    
    [valResX, valResY, valResDelX, valResDelY] = ...
        calcResultsAndErrors(matrixDeltaChiSquare, vecX, vecY);
    
    % Draw chi^2 contour
    drawChiSquareContour(analyzeIndex, eventName, labelX, labelY, vecX, vecY, matrixDeltaChiSquare, ...
                            valResX, valResY, valResDelX, valResDelY, ...
                            realValX, realValY, realValDelX, realValDelY);
    
    % Print results with errors
    fileId = fopen(strcat('Event_', eventName, '_Res_', num2str(analyzeIndex), '.txt'), 'w');
    
    fprintf(fileId, 'analyzeIndex = %i \n', analyzeIndex);
    fprintf(fileId, 'min chiSquare = %.3f \n', minChiSquareVal);
    fprintf(fileId, '%s = %.5f ± %.5f \n', labelX, valResX, valResDelX);
    fprintf(fileId, '%s = %.5f ± %.5f \n', labelY, valResY, valResDelY);
    
    fclose('all');
end