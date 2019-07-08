%% Run all Steps
% Save their results
% Compare between results
function runAllSteps34()
    fileName_BLG = "OGLE-2008-BLG-001";
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, ...
        Umin, delUmin, Fbl, delFbl, Ibl, delIbl] = getDataFromOgle(fileName_BLG, ".dat");
    
    % Run Step 3 - 3 Params: Tau, Umin, Fbl
%     fprintf('Step 3 - 3 Params: Tau, Umin, Fbl (with analyzeIndex = %i) \n', 30);
%     step3MinChiSquareVal = runGetMinChiSquare2ParamsAndFblRealData(30, fileName_BLG, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl);
    step3MinChiSquareVal = 4.028176077915116e+03;
    
    % Run Step 4 - 4 Params: Tau, Umin, T0, Fbl
    fprintf('Step 4 - 4 Params: Tau, Umin, T0, Fbl (with analyzeIndex = %i) \n', 40);
    step4MinChiSquareVal = runGetMinChiSquare3ParamsAndFblRealData(40, fileName_BLG, vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl);

    % Calc p-value for steps 1 - 2
    fprintf('Calc p-value for steps 3 - 4 \n');
    calcPValue(2, length(vecDataT), 4, step3MinChiSquareVal, step4MinChiSquareVal);
    
    fclose('all');
end