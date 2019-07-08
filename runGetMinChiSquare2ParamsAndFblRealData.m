%% Get min Chi Square of real data
function minChiSquareVal = runGetMinChiSquare2ParamsAndFblRealData(analyzeIndex, eventName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl)
    TAU_LABEL = '\tau [days]';
    U_MIN_LABEL = 'u_{min}';
    Fbl_LABEL = 'f_{bl}';

    % Convert I-mag to Mu
    [vecDataMu0, vecDataSigmaMu0] = ...
        convertImagToMu0(vecDataImag, vecDataSigmaImag, Ibl, delIbl);
    
    % Define the values to scan
    vecTau = getVectorValuesToScan(tau, 41, 5.3, 2);
    vecUmin = getVectorValuesToScan(Umin, 41, 3, 3);
    vecFbl = getVectorValuesToScan(Fbl, 41, 4, 4);
    
    % Get matrix of min chi square
    [gridChiSquare, minUMinIndex, minTauIndex, minFblIndex] = ...
        getChiSquareGrid2ParamsAndFbl(vecDataT, vecDataMu0, vecDataSigmaMu0, T0, vecTau, vecUmin, vecFbl);
    
    % Analyze Tau-Fbl
    matrixChiSquare_TauFbl = squeeze(gridChiSquare(minUMinIndex, :, :));
    [minChiSquareVal, resTau, resFbl] = analyzeResults(analyzeIndex, eventName, matrixChiSquare_TauFbl, vecTau, vecFbl, minTauIndex, minFblIndex, TAU_LABEL, Fbl_LABEL, tau, Fbl, delTau, delFbl);
    
    % Analyze Umin-Fbl
    matrixChiSquare_UminFbl = squeeze(gridChiSquare(:, minTauIndex, :));
    [~, resUmin, ~] = analyzeResults(analyzeIndex + 1, eventName, matrixChiSquare_UminFbl, vecUmin, vecFbl, minUMinIndex, minFblIndex, U_MIN_LABEL, Fbl_LABEL, Umin, Fbl, delUmin, delFbl);
    
    % Analyze Umin-Tau
    matrixChiSquare_UminTau = squeeze(gridChiSquare(:, :, minFblIndex));
    [~, ~, ~] = analyzeResults(analyzeIndex + 2, eventName, matrixChiSquare_UminTau, vecUmin, vecTau, minUMinIndex, minTauIndex, U_MIN_LABEL, TAU_LABEL, Umin, tau, delUmin, delTau);
    
    % Draw our result to OGLE data fitting
    drawGraphFitting(analyzeIndex + 3, eventName, vecDataT, vecDataImag, vecDataSigmaImag, resFbl, Ibl, T0, resUmin, resTau);
end