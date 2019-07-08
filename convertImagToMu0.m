function [vecDataMu0, vecDataSigmaMu0] = convertImagToMu0(vecDataImag, vecDataSigmaImag, Ibl, delIbl)
    % Calc Mu & Sigma Mu as if Fbl = 1
    vecDataMu0 = 10.^(0.4*(Ibl - vecDataImag));
    vecDataSigmaMu0 = abs(0.4*log(10)*vecDataMu0.*sqrt(delIbl^2 + vecDataSigmaImag.^2));
end