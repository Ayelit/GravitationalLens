%% Return the values of the first level of the contour
function [vecX, vecY] = analyzeMatrixContour(matrixContour)
    valsCount = matrixContour(2, 1);
    
    vecX = matrixContour(1, 2:(1 + valsCount));
    vecY = matrixContour(2, 2:(1 + valsCount));
end