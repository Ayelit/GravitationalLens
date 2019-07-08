%% Draw chi square contour diagram
function drawChiSquareContour(drawIndex, eventName, labelX, labelY, vecX, vecY, matrixChiSquare, valResX, valResY, valResDelX, valResDelY, valRealX, valRealY, valRealDelX, valRealDelY)
    figure(drawIndex);
    hold on;
        title(strcat(eventName, ' - Minimal \chi^2 contour'));
        
        xlabel(labelX);
        ylabel(labelY);

        contour(vecX, vecY, matrixChiSquare, 1:0.5:2, 'ShowText', 'on');
        
        errorbar(valResX, valResY, valResDelX, 'horizontal', 'ro');
        errorbar(valResX, valResY, valResDelY, 'ro');
        
        errorbar(valRealX, valRealY, valRealDelX, 'horizontal', 'go');
        errorbar(valRealX, valRealY, valRealDelY, 'go');
    hold off;
end