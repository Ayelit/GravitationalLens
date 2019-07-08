%% Run all Steps
% Save their results
% Compare between results
function runAll()
    fileName_SMC = "OGLE-2008-SMC-001";
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName_SMC, ".dat");
    
    % Run Step 1 - 2 Params: Tau, Umin
    fprintf('Step 1 - 2 Params: Tau, Umin (with analyzeIndex = %i) \n', 10);
    step1MinChiSquareVal = runGetMinChiSquare2ParamsRealData(10, fileName_SMC, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
    fclose('all');
    
    % Run Step 2 - 3 Params: Tau, Umin, T0
    fprintf('Step 2 - 3 Params: Tau, Umin, T0 (with analyzeIndex = %i) \n', 20);
    step2MinChiSquareVal = runGetMinChiSquare3ParamsRealData(20, fileName_SMC, vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
    fclose('all');
    
    % Calc p-value for steps 1 - 2
    fprintf('Calc p-value for steps 1 - 2 \n');
    calcPValue(1, length(vecDataT), 3, step1MinChiSquareVal, step2MinChiSquareVal);
    fclose('all');
    
    fileName_BLG = "OGLE-2008-BLG-001";
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, ...
        Umin, delUmin, Fbl, delFbl, Ibl, delIbl] = getDataFromOgle(fileName_BLG, ".dat");
    
    % Run Step 3 - 3 Params: Tau, Umin, Fbl
    fprintf('Step 3 - 3 Params: Tau, Umin, Fbl (with analyzeIndex = %i) \n', 30);
    step3MinChiSquareVal = runGetMinChiSquare2ParamsAndFblRealData(30, fileName_BLG, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl);
    fclose('all');

    % Run Step 4 - 4 Params: Tau, Umin, T0, Fbl
    fprintf('Step 4 - 4 Params: Tau, Umin, T0, Fbl (with analyzeIndex = %i) \n', 40);
    step4MinChiSquareVal = runGetMinChiSquare3ParamsAndFblRealData(40, fileName_BLG, vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl);
    fclose('all');

    % Calc p-value for steps 1 - 2
    fprintf('Calc p-value for steps 3 - 4 \n');
    calcPValue(2, length(vecDataT), 4, step3MinChiSquareVal, step4MinChiSquareVal);
    fclose('all');
    
    % Run Step 5 - 4 Params: Tau, Umin, T0, Fbl - fminsearch func
    fprintf('Step 5 - 4 Params: Tau, Umin, T0, Fbl - fminsearch func (with analyzeIndex = %i) \n', 50);
    step5MinChiSquareVal = runGetMinChiSquare3ParamsAndFblFminsearchRealData(50, fileName_BLG, vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl);
    fclose('all');
    
    % Calc p-value for steps 1 - 2
    fprintf('Calc p-value for steps 3 - 5 \n');
    calcPValue(3, length(vecDataT), 4, step3MinChiSquareVal, step5MinChiSquareVal);
    fclose('all');
end