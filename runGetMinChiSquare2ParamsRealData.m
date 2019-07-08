%% Get min Chi Square of real data
function minChiSquareVal = runGetMinChiSquare2ParamsRealData(analyzeIndex, eventName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl)
    TAU_LABEL = '\tau [days]';
    U_MIN_LABEL = 'u_{min}';
    
    % Convert I-mag to Mu
    [vecDataMu, vecDataSigmaMu] = ...
        convertImagToMu(vecDataImag, vecDataSigmaImag, Fbl, Ibl, delIbl);
    
    % Define the values to scan
    vecTau = getVectorValuesToScan(tau, 101, 5.3, 2);
    vecUmin = getVectorValuesToScan(Umin, 101, 2, 2);
    
    % Get matrix of min chi square
    [matrixChiSquare, minUMinIndex, minTauIndex] = ...
        getChiSquareGrid2Params(vecDataT, vecDataMu, vecDataSigmaMu, T0, vecTau, vecUmin);

    % Analyze results
    [minChiSquareVal, resUmin, resTau] = ...
        analyzeResults(analyzeIndex, eventName, matrixChiSquare, vecUmin, vecTau, ...
                        minUMinIndex, minTauIndex, U_MIN_LABEL, TAU_LABEL, ...
                        Umin, tau, delUmin, delTau);
    
    % Draw our result to OGLE data fitting
    drawGraphFitting(analyzeIndex + 1, eventName, vecDataT, vecDataImag, vecDataSigmaImag, ...
                        Fbl, Ibl, T0, resUmin, resTau);
end