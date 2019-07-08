%% Get min Chi Square of real data
function minChiSquareVal = runGetMinChiSquare3ParamsRealData(analyzeIndex, eventName, vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl)
    TAU_LABEL = '\tau [days]';
    U_MIN_LABEL = 'u_{min}';
    T0_LABEL = 'T_{0}';
    
    % Convert I-mag to Mu
    [vecDataMu, vecDataSigmaMu] = ...
        convertImagToMu(vecDataImag, vecDataSigmaImag, Fbl, Ibl, delIbl);
    
    % Define the values to scan
    vecTau = getVectorValuesToScan(tau, 51, 5.3, 2);
    vecUmin = getVectorValuesToScan(Umin, 51, 2, 2);
    vecT0 = getVectorValuesToScan(T0, 51, 1.15e-5, 1e-5);
    
    % Get matrix of min chi square
    [gridChiSquare, minUMinIndex, minTauIndex, minT0Index] = ...
        getChiSquareGrid3Params(vecDataT, vecDataMu, vecDataSigmaMu, vecT0, vecTau, vecUmin);
    
    % Analyze Tau-To
    matrixChiSquare_TauT0 = squeeze(gridChiSquare(minUMinIndex, :, :));
    [minChiSquareVal, resTau, resT0] = analyzeResults(analyzeIndex, eventName, matrixChiSquare_TauT0, vecTau, vecT0, minTauIndex, minT0Index, TAU_LABEL, T0_LABEL, tau, T0, delTau, delT0);
    
    % Analyze Umin-To
    matrixChiSquare_UminT0 = squeeze(gridChiSquare(:, minTauIndex, :));
    [~, resUmin, ~] = analyzeResults(analyzeIndex + 1, eventName, matrixChiSquare_UminT0, vecUmin, vecT0, minUMinIndex, minT0Index, U_MIN_LABEL, T0_LABEL, Umin, T0, delUmin, delT0);
    
    % Analyze Umin-Tau
    matrixChiSquare_UminTau = squeeze(gridChiSquare(:, :, minT0Index));
    [~, ~, ~] = analyzeResults(analyzeIndex + 2, eventName, matrixChiSquare_UminTau, vecUmin, vecTau, minUMinIndex, minTauIndex, U_MIN_LABEL, TAU_LABEL, Umin, tau, delUmin, delTau);
    
    % Draw our result to OGLE data fitting
    drawGraphFitting(analyzeIndex + 3, eventName, vecDataT, vecDataImag, vecDataSigmaImag, Fbl,Ibl, resT0, resUmin, resTau);
end