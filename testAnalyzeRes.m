%% 
function resAvg = testAnalyzeRes(analyzeIndex, analyzedParam, paramAllRes)
    resPd = fitdist(paramAllRes, 'Normal');
    resAvg = resPd.mu;
    resStd = resPd.sigma;
    resNormalized = (paramAllRes - resAvg)/resStd;
    
    figure(analyzeIndex);
    hold on;
        [titleAvg, titleErr] = getLeadingDigits(resAvg, resStd, 2);
        
        title({'Histogram of normalized param:', ...
                strcat(analyzedParam, '=', num2str(titleAvg), '±', num2str(titleErr))});
        
        xlabel('Error in \sigma units');
        ylabel('Number of runs');

        histfit(resNormalized, round(0.5*sqrt(length(resNormalized))));
    hold off;
    
    figure(analyzeIndex + 10);
    hold on;
        [titleAvg, titleErr] = getLeadingDigits(resAvg, resStd, 2);
        
        title({'Histogram of normalized param:', ...
                strcat(analyzedParam, '=', num2str(titleAvg), '±', num2str(titleErr))});
        
        xlabel('Error in \sigma units');
        ylabel('Number of runs');

        histogram(resNormalized);
    hold off;
end