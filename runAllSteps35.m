%% Run all Steps
% Save their results
% Compare between results
function runAllSteps35()
    fileName_BLG = "OGLE-2008-BLG-001";
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, ...
        Umin, delUmin, Fbl, delFbl, Ibl, delIbl] = getDataFromOgle(fileName_BLG, ".dat");
    
    % Run Step 3 - 3 Params: Tau, Umin, Fbl
    fprintf('Step 3 - 3 Params: Tau, Umin, Fbl (with analyzeIndex = %i) \n', 30);
    step3MinChiSquareVal = runGetMinChiSquare2ParamsAndFblRealData(30, fileName_BLG, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl);

    % Run Step 5 - 4 Params: Tau, Umin, T0, Fbl - fminsearch func
    fprintf('Step 5 - 4 Params: Tau, Umin, T0, Fbl - fminsearch func (with analyzeIndex = %i) \n', 50);
    step5MinChiSquareVal = runGetMinChiSquare3ParamsAndFblFminsearchRealData(50, fileName_BLG, vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl);
    
    % Calc p-value for steps 1 - 2
    fprintf('Calc p-value for steps 3 - 5 \n');
    calcPValue(3, length(vecDataT), 4, step3MinChiSquareVal, step5MinChiSquareVal);
    
    fclose('all');
end