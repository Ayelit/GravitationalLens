%% Test Get Min Chi Square with 2 Params with Fbl
% testGetMinChiSquare3ParamsAndFbl(3000, 51, 0.12, 2000300, 1, 100, 0.003)
% testGetMinChiSquare3ParamsAndFbl(1000, 51, 0.12, 2000300, 1, 100, 0.005)
function testGetMinChiSquare3ParamsAndFbl(noOfIterations, tau, Umin, T0, Fbl, testSize, testErr)
    T = (2E6:5:(2E6 + 5*(testSize - 1)))';
    originalMu = generateVectorMu(T, T0, Umin, tau);
    deltaMu = testErr*(rand(testSize, 1) + 0.5);

    UminCalculatedResults = zeros(noOfIterations, 1);
    tauCalculatedResults = zeros(noOfIterations, 1);
    T0CalculatedResults = zeros(noOfIterations, 1);
    FblCalculatedResults = zeros(noOfIterations, 1);
    chiCalculatedResults = zeros(noOfIterations, 1);
    
    % Define the values to scan
    vecTau = getVectorValuesToScan(tau, 21, 1, 1);
    vecUmin = getVectorValuesToScan(Umin, 21, 1, 1);
    vecT0 = getVectorValuesToScan(T0, 21, 1e-6, 1e-6);
    vecFbl = getVectorValuesToScan(Fbl, 21, 1, 1);
    
    tic;
    for iterationIndex = 1:noOfIterations
        fprintf('Iteration Index = %i \n', iterationIndex);
        
        currMu = originalMu + deltaMu.*randn(length(deltaMu), 1);
        
        % fits data to parabolic model and returns coefficients.
        [gridChiSquare, minUMinIndex, minTauIndex, minT0Index, minFblIndex] = ...
                getChiSquareGrid3ParamsAndFbl(T, currMu, deltaMu, vecT0, vecTau, vecUmin, vecFbl);
        
        % stores results
        UminCalculatedResults(iterationIndex) = vecUmin(minUMinIndex);
        tauCalculatedResults(iterationIndex) = vecTau(minTauIndex);
        T0CalculatedResults(iterationIndex) = vecT0(minT0Index);
        FblCalculatedResults(iterationIndex) = vecFbl(minFblIndex);
        
        % stores calculated chi square values from the coefficients of current
        % iteration.
        chiCalculatedResults(iterationIndex) = gridChiSquare(minUMinIndex, minTauIndex, minT0Index, minFblIndex);
    end
    toc;
    
    % Output module
    UminAvg = testAnalyzeRes(1, 'u_{min}', UminCalculatedResults);
    tauAvg = testAnalyzeRes(2, '\tau', tauCalculatedResults);
    T0Avg = testAnalyzeRes(3, 'T_{0}', T0CalculatedResults);
    testAnalyzeRes(4, 'f_{bl}', FblCalculatedResults);
    testAnalyzeRes(5, '\surd(2{\chi}^2)', sqrt(2*chiCalculatedResults));

    % Print data fitting
    resMu = generateVectorMu(T, T0Avg, UminAvg, tauAvg);
    
    figure(6);
    hold on;
        title('Data fitting');
        
        xlabel('T');
        ylabel('\mu');
        
        plot(T, originalMu, 'g-', T, resMu, 'r--');
    hold off;
end