%% Run all Steps
% Save their results
% Compare between results
function runAllSteps2()
    % ---------- Run 1 ----------
    fileName = "OGLE-2008-SMC-001";
    analyzeIndex = 10;
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, ~, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    fprintf('Run %i - %s \n', (analyzeIndex/10), fileName);
    runGetMinChiSquare2ParamsRealData(analyzeIndex, fileName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
   
    % ---------- Run 2 ----------
    fileName = "OGLE-2008-BLG-004";
    analyzeIndex = 20;
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, ~, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    fprintf('Run %i - %s \n', (analyzeIndex/10), fileName);
    runGetMinChiSquare2ParamsRealData(analyzeIndex, fileName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
   
    % ---------- Run 3 ----------
    fileName = "OGLE-2008-BLG-005";
    analyzeIndex = 30;
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, ~, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    fprintf('Run %i - %s \n', (analyzeIndex/10), fileName);
    runGetMinChiSquare2ParamsRealData(analyzeIndex, fileName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
   
    % ---------- Run 4 ----------
    fileName = "OGLE-2008-BLG-006";
    analyzeIndex = 40;
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, ~, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    fprintf('Run %i - %s \n', (analyzeIndex/10), fileName);
    runGetMinChiSquare2ParamsRealData(analyzeIndex, fileName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
   
    % ---------- Run 5 ----------
    fileName = "OGLE-2008-BLG-007";
    analyzeIndex = 50;
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, ~, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    fprintf('Run %i - %s \n', (analyzeIndex/10), fileName);
    runGetMinChiSquare2ParamsRealData(analyzeIndex, fileName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
   
    % ---------- Run 6 ----------
    fileName = "OGLE-2008-BLG-045";
    analyzeIndex = 60;
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, ~, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    fprintf('Run %i - %s \n', (analyzeIndex/10), fileName);
    runGetMinChiSquare2ParamsRealData(analyzeIndex, fileName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
   
    % ---------- Run 7 ----------
    fileName = "OGLE-2008-BLG-036";
    analyzeIndex = 70;
    
    % Read from OGLE data file
    [vecDataT, vecDataImag, vecDataSigmaImag, T0, ~, tau, delTau, ...
        Umin, delUmin, Fbl, ~, Ibl, delIbl] = getDataFromOgle(fileName, ".dat");
    
    fprintf('Run %i - %s \n', (analyzeIndex/10), fileName);
    runGetMinChiSquare2ParamsRealData(analyzeIndex, fileName, vecDataT, vecDataImag, vecDataSigmaImag, T0, tau, delTau, Umin, delUmin, Fbl, Ibl, delIbl);
   
    % ---------- DONE ----------
    
    fclose('all');
end