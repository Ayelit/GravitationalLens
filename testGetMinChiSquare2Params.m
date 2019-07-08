%% Test Get Min Chi Square with 2 Params
% testGetMinChiSquare2Params(1000, 51, 0.12, 600, 0.03)
function testGetMinChiSquare2Params(noOfIterations, tau, Umin, testSize, testErr)
    T0 = 2E6 + 3*testSize;
    T = (2E6:5:(2E6 + 5*(testSize - 1)))';
    originalMu = generateVectorMu(T, T0, Umin, tau);
    deltaMu = testErr*(rand(testSize, 1) + 0.5);

    UminCalculatedResults = zeros(noOfIterations, 1);
    tauCalculatedResults = zeros(noOfIterations, 1);
    chiCalculatedResults = zeros(noOfIterations, 1);
    
    % Define the values to scan
    vecTau = getVectorValuesToScan(tau, 101, 1, 1);
    vecUmin = getVectorValuesToScan(Umin, 101, 1, 1);
    
    tic;
    for iterationIndex = 1:noOfIterations
        fprintf('Iteration Index = %i \n', iterationIndex);
        
        currMu = originalMu + deltaMu.*randn(length(deltaMu), 1);
        
        % fits data to parabolic model and returns coefficients.
        [matrixChiSquare, minUMinIndex, minTauIndex] = getChiSquareGrid2Params(T, currMu, deltaMu, T0, vecTau, vecUmin);
        
        % stores results
        UminCalculatedResults(iterationIndex) = vecUmin(minUMinIndex);
        tauCalculatedResults(iterationIndex) = vecTau(minTauIndex);
        
        % stores calculated chi square values from the coefficients of current
        % iteration.
        chiCalculatedResults(iterationIndex) = matrixChiSquare(minUMinIndex, minTauIndex);
    end
    toc;
    
    % Output module
    UminAvg = testAnalyzeRes(1, 'u_{min}', UminCalculatedResults);
    tauAvg = testAnalyzeRes(2, '\tau', tauCalculatedResults);
    testAnalyzeRes(3, '\surd(2{\chi}^2)', sqrt(2*chiCalculatedResults));

    % Print data fitting
    resMu = generateVectorMu(T, T0, UminAvg, tauAvg);
    
    figure(4);
    hold on;
        title('Data fitting');
        
        xlabel('T');
        ylabel('\mu');
        
        plot(T, originalMu, 'g-', T, resMu, 'r--');
    hold off;
end