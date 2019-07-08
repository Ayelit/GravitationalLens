%% Test Parabolic fit
% testParabolicFit(10000, -100.62, 20.35, 8.81, 103, 4)
function testParabolicFit(noOfIterations, a, b, c, testSize, testErr)
    x = (1:testSize)'*(2/testSize) - 1;
    originalY = a*x.^2 + b*x + c;
    deltaY = testErr*(rand(testSize, 1) + 0.5);
    
    aCalculatedResults = zeros(noOfIterations, 1);
    bCalculatedResults = zeros(noOfIterations, 1);
    cCalculatedResults = zeros(noOfIterations, 1);
    chiCalculatedResults = zeros(noOfIterations, 1);
    
    tic;
    for iterationIndex = 1:noOfIterations
        fprintf('Iteration Index = %i \n', iterationIndex);
        
        currY = originalY + deltaY.*randn(testSize, 1);
        
        % fits data to parabolic model and returns coefficients. 
        [coefficients, ~, chiSquare] = parabolicFit(x, currY, deltaY);
        
        % stores coefficients of current iteration in results' array.
        aCalculatedResults(iterationIndex) = coefficients(3);
        bCalculatedResults(iterationIndex) = coefficients(2);
        cCalculatedResults(iterationIndex) = coefficients(1);
        
        % stores calculated chi square values from the coefficients of current
        % iteration.
        chiCalculatedResults(iterationIndex) = chiSquare;
    end
    toc;
    
    % Output module
    aAvg = testAnalyzeRes(1, 'a', aCalculatedResults);
    bAvg = testAnalyzeRes(2, 'b', bCalculatedResults);
    cAvg = testAnalyzeRes(3, 'c', cCalculatedResults);
    testAnalyzeRes(4, '\surd(2{\chi}^2)', sqrt(2*chiCalculatedResults));

    % Print data fitting
    resY = aAvg*x.^2 + bAvg*x + cAvg;
    
    figure(5);
    hold on;
        title('Data fitting');
        
        xlabel('x');
        ylabel('y');
        
        errorbar(x, originalY, deltaY, 'g.-');
        plot(x, resY, 'r--');
    hold off;
end