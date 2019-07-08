%%
function calcPValue(analyzeIndex, dataSize, numMoreParams, chiSquareLessParams, chiSquareMoreParams)
    Fstat = ((chiSquareLessParams - chiSquareMoreParams)/1)/(chiSquareMoreParams/(dataSize - numMoreParams));
    pValue = 1 - fcdf(Fstat, 1, dataSize - numMoreParams);
    
    fileId = fopen(strcat('p-value_', num2str(analyzeIndex), '.txt'), 'w');
    fprintf(fileId, 'Fstat = %.20f \n', Fstat);
    fprintf(fileId, 'pValue = %.20f \n', pValue);
end