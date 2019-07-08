%% Convert I magnitude to Mu values
function [vecDataMu, vecDataSigmaMu] = convertImagToMu(vecDataImag, vecDataSigmaImag, Fbl, Ibl, delIbl)
    % Calc Mu & Sigma Mu as if Fbl = 1
    [vecDataMu0, vecDataSigmaMu0] = convertImagToMu0(vecDataImag, vecDataSigmaImag, Ibl, delIbl);
    
    % Calc real Mu & Sigma Mu
    if (Fbl ~= 1)
        vecDataMu = 1 + (vecDataMu0 - 1)/Fbl;
        vecDataSigmaMu = vecDataSigmaMu0/Fbl;
    else
        vecDataMu = vecDataMu0;
        vecDataSigmaMu = vecDataSigmaMu0;
    end
end