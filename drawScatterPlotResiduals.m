%% Scatter plot residuals of linear regression model
function drawScatterPlotResiduals(analyzeIndex, eventName, originalVecX, originalVecY, originalVecSigma, resVecY, labelX, labelY)
    residual = (originalVecY - resVecY)./originalVecSigma;
    
    figure(analyzeIndex);
    hold on;
        title(strcat(eventName, ' Fitting Residuals'));
        
        xlabel(labelX);
        ylabel(labelY) ;

        plot(originalVecX, residual, 'ko:', originalVecX, zeros(length(originalVecX)), 'k');
    hold off;
end