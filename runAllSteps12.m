%% Run all Steps
% Save their results
% Compare between results
function runAllSteps12()
    fileName_SMC = "OGLE-2008-SMC-001";
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName_SMC, ".dat");
    
    % Run Step 1 - 2 Params: Tau, Umin
    fprintf('Step 1 - 2 Params: Tau, Umin (with analyzeIndex = %i) \n', 10);
    step1MinChiSquareVal = runGetMinChiSquare2ParamsRealData(10, fileName_SMC, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
    
    % Run Step 2 - 3 Params: Tau, Umin, T0
    fprintf('Step 2 - 3 Params: Tau, Umin, T0 (with analyzeIndex = %i) \n', 20);
    step2MinChiSquareVal = runGetMinChiSquare3ParamsRealData(20, fileName_SMC, vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
    
    % Calc p-value for steps 1 - 2
    fprintf('Calc p-value for steps 1 - 2 \n');
    calcPValue(1, length(vecDataT), 3, step1MinChiSquareVal, step2MinChiSquareVal);
    
    fclose('all');
end