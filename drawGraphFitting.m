%% Draw our result to OGLE data fitting
function drawGraphFitting(drawIndex, eventName, vecDataT, vecDataImag, vecDataSigmaImag, valFbl, valIbl, valT0, valUmin, valTau)
    % Draw Data Fitting of all the graph
    vecMu = generateVectorMu(vecDataT, valT0, valUmin, valTau);
    vecResImag = convertMuToImag(vecMu, valFbl, valIbl);
    
    drawDataFitting(drawIndex, strcat(eventName, ' Data fitting'), vecDataT, vecDataImag, vecDataSigmaImag, vecResImag);
    
    % Draw Data Fitting of the zoomed-in graph
    [~, minImagIndex] = min(vecDataImag);
    zoominAddToRight = 33;
    zoominAddToLeft = 60;

    zoominT = vecDataT(minImagIndex - zoominAddToLeft : minImagIndex + zoominAddToRight);
    zoominImag = vecDataImag(minImagIndex - zoominAddToLeft : minImagIndex + zoominAddToRight);
    zoominSigmaImag = vecDataSigmaImag(minImagIndex - zoominAddToLeft : minImagIndex + zoominAddToRight);
    zoominResImag = vecResImag(minImagIndex - zoominAddToLeft : minImagIndex + zoominAddToRight);
    
    drawDataFitting(drawIndex + 1, strcat(eventName, ' Data fitting - Zoomed in graph'), zoominT, zoominImag, zoominSigmaImag, zoominResImag);
    
    % Draw Data Fitting Residuals
    drawDataFittingResiduals(drawIndex + 2, strcat(eventName, ' Fitting Residuals - Zoomed in graph'), zoominT, zoominImag, zoominSigmaImag, zoominResImag);
end

%%
function drawDataFitting(drawIndex, figTitle, vecDataT, vecDataImag, vecDataSigmaImag, vecResImag)
    % Draw Data Fitting
    figure(drawIndex);
    hold on;
        title(figTitle);
        
        xlabel('T [days]');
        ylabel('I_{mag}');

        errorbar(vecDataT, vecDataImag, vecDataSigmaImag, 'g.');
        plot(vecDataT, vecResImag, 'r');
        
        set(gca, 'YDir','reverse')
    hold off;
end

%%
function drawDataFittingResiduals(drawIndex, figTitle, vecDataT, vecDataImag, vecDataSigmaImag, vecResImag)
    zoominResidual = (vecDataImag - vecResImag)./vecDataSigmaImag;

    figure(drawIndex);
    hold on;
        title(figTitle);
        
        xlabel('T [days]');
        ylabel('I_{mag}');

        errorbar(vecDataT, zoominResidual, vecDataSigmaImag, 'k.');
        plot(vecDataT, zeros(length(vecDataT)), 'k');
    hold off;
end