%% runParabolicFitRealData
% Finds coefficients of mu = aT^2 + bT + c
% include errors
function runParabolicFitRealData(fileName)
    % Define OGLE file name
    if (fileName == "")
        fileName = "OGLE-2008-SMC-001";
    end
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, ...
        ~, ~, ~, ~, ~, ~, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    % Convert I-mag to Mu
    [vecDataMu, vecDataSigmaMu] = ...
        convertImagToMu(vecDataImag, vecDataSigmaImag, Fbl, Ibl, delIbl);

    % Find mu max value & T value respectively
    [~, maxMuIndex] = max(vecDataMu);
    offsetTValue = vecDataT(maxMuIndex);

    % Define the amount of data to try to fit to parabolic graph
    parabolicAddToRight = 10;
    parabolicAddToLeft = 12;

    % Get sub-vectors of the data to try to fit to parabolic graph
    parabolicT = vecDataT(maxMuIndex - parabolicAddToLeft : maxMuIndex + parabolicAddToRight) - offsetTValue;
    parabolicMu = vecDataMu(maxMuIndex - parabolicAddToLeft : maxMuIndex + parabolicAddToRight);
    parabolicDMu = vecDataSigmaMu(maxMuIndex - parabolicAddToLeft : maxMuIndex + parabolicAddToRight);

    % Fits sub-data to parabolic model and returns coefficients
    [coefficients, errors, chiSquare] = parabolicFit(parabolicT, parabolicMu, parabolicDMu);

    % Calc T0
    T0 = -coefficients(2)/(2*coefficients(3));
    dT0 = abs(T0*sqrt((errors(3)/coefficients(3))^2 + (errors(2)/coefficients(2))^2));

    % Print to screen the conclusions
    fprintf('chiSquare = %.3f \n', chiSquare);
    fprintf('data size = %.3f \n', length(parabolicT));
    fprintf('mu = a*(T-Toffset)^2 + b*(T-Toffset) + c \n');
    fprintf('Toffset = %d \n', offsetTValue);
    fprintf('c = %d ± %d \n', coefficients(1), errors(1));
    fprintf('b = %d ± %d \n', coefficients(2), errors(2));
    fprintf('a = %d ± %d \n', coefficients(3), errors(3));
    fprintf('T0 = %.3f ± %.3f \n', T0 + offsetTValue, dT0);

    % Print the graph of the parabolic match found Vs. the original data
    resY = coefficients(1) + coefficients(2).*parabolicT + coefficients(3).*parabolicT.^2;

    figure(1);
    hold on;
        title(strcat(fileName, ' Linear Data Fitting'));
        
        xlabel('T [days]');
        ylabel('\mu') ;

        errorbar(parabolicT + offsetTValue, parabolicMu, parabolicDMu, 'g.');
        plot(parabolicT + offsetTValue, resY, 'ro--');
    hold off;
    
    % Draw Data Fitting Residuals
    residual = (parabolicMu - resY)./parabolicDMu;
    figure(2);
    hold on;
        title(strcat(fileName, ' Fitting Residuals'));
        
        xlabel('T [days]');
        ylabel('Residuals') ;

        errorbar(parabolicT + offsetTValue, residual, parabolicDMu, 'ko');
        plot(parabolicT + offsetTValue, zeros(length(parabolicT)), 'k');
    hold off;
end