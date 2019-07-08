%% Get min Chi Square of real data
function minChiSquareVal = runGetMinChiSquare3ParamsAndFblRealData()
    TAU_LABEL = '\tau [days]';
    U_MIN_LABEL = 'u_{min}';
    F_BL_LABEL = 'f_{bl}';
    T0_LABEL = 'T_{0}';
    
    eventName = "OGLE-2008-BLG-001";
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, ...
        Umin, delUmin, Fbl, delFbl, Ibl, delIbl] = getDataFromOgle(eventName, ".dat");

    % Convert I-mag to Mu
    [vecDataMu0, vecDataSigmaMu0] = ...
        convertImagToMu0(vecDataImag, vecDataSigmaImag, Ibl, delIbl);
    
    % Define the values to scan
    dataSize = 25;
    vecTau = getVectorValuesToScan(tau, dataSize, 5.3, 2);
    vecUmin = getVectorValuesToScan(Umin, dataSize, 3, 3);
    vecT0 = getVectorValuesToScan(T0, dataSize, 1.15e-5, 1e-5);
    vecFbl = getVectorValuesToScan(Fbl, dataSize, 4, 4);
    
    % Get grid of min chi square (Umin x tau x T0 x Fbl)
    [gridChiSquare, minUminIndex, minTauIndex, minT0Index, minFblIndex] = ...
                getChiSquareGrid3ParamsAndFbl(vecDataT, vecDataMu0, vecDataSigmaMu0, vecT0, vecTau, vecUmin, vecFbl);
    
	analyzeIndex = 40;
            
    % Analyze T0-Fbl
    matrixChiSquare_T0Fbl = squeeze(gridChiSquare(minUminIndex, minTauIndex, :, :));
    [minChiSquareVal, resT0, resFbl] = analyzeResults(analyzeIndex, eventName, matrixChiSquare_T0Fbl, vecT0, vecFbl, minT0Index, minFblIndex, T0_LABEL, F_BL_LABEL, T0, Fbl, delT0, delFbl);
    
    % Analyze Tau-Fbl
    matrixChiSquare_TauFbl = squeeze(gridChiSquare(minUminIndex, :, minT0Index, :));
    [~, resTau, ~] = analyzeResults(analyzeIndex + 1, eventName, matrixChiSquare_TauFbl, vecTau, vecFbl, minTauIndex, minFblIndex, TAU_LABEL, F_BL_LABEL, tau, Fbl, delTau, delFbl);
    
    % Analyze Tau-T0
    matrixChiSquare_TauT0 = squeeze(gridChiSquare(minUminIndex, :, :, minFblIndex));
    [~, ~, ~] = analyzeResults(analyzeIndex + 2, eventName, matrixChiSquare_TauT0, vecTau, vecT0, minTauIndex, minT0Index, TAU_LABEL, T0_LABEL, tau, T0, delTau, delT0);
    
    % Analyze Umin-Fbl
    matrixChiSquare_UminFbl = squeeze(gridChiSquare(:, minTauIndex, minT0Index, :));
    [~, resUmin, ~] = analyzeResults(analyzeIndex + 3, eventName, matrixChiSquare_UminFbl, vecUmin, vecFbl, minUminIndex, minFblIndex, U_MIN_LABEL, F_BL_LABEL, Umin, Fbl, delUmin, delFbl);
    
    % Analyze Umin-T0
    matrixChiSquare_UminT0 = squeeze(gridChiSquare(:, minTauIndex, :, minFblIndex));
    [~, ~, ~] = analyzeResults(analyzeIndex + 4, eventName, matrixChiSquare_UminT0, vecUmin, vecT0, minUminIndex, minT0Index, U_MIN_LABEL, T0_LABEL, Umin, T0, delUmin, delT0);
   
    % Analyze Umin-Tau
    matrixChiSquare_UminTau = squeeze(gridChiSquare(:, :, minT0Index, minFblIndex));
    [~, ~, ~] = analyzeResults(analyzeIndex + 5, eventName, matrixChiSquare_UminTau, vecUmin, vecTau, minUminIndex, minTauIndex, U_MIN_LABEL, TAU_LABEL, Umin, tau, delUmin, delTau);
    
    % Draw our result to OGLE data fitting
    drawGraphFitting(analyzeIndex + 6, eventName, vecDataT, vecDataImag, vecDataSigmaImag, resFbl, Ibl, resT0, resUmin, resTau);
end