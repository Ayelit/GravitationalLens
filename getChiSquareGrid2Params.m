%% Get min Chi Square 2 parameters
function [matrixChiSquare, minUMinIndex, minTauIndex] = getChiSquareGrid2Params(vecDataT, vecDataMu, vecDataSigmaMu, valDataT0, vecTau, vecUmin)
    UNKNOWN_PARAMETERS_COUNT = 2;

    % Generate grid of (Umin x tau x T)
    gridMu = generateGridMu(vecDataT, valDataT0, vecUmin, vecTau);
    [~, ~, gridRealMu] = ndgrid(1, 1, vecDataMu);
    [~, ~, gridRealSigmaMu] = ndgrid(1, 1, vecDataSigmaMu);

    % Calc chi square matrix - uMin x tau
    matrixChiSquare = sum(((gridRealMu - gridMu)./gridRealSigmaMu).^2, UNKNOWN_PARAMETERS_COUNT + 1);

    % Find chi sqaure min value & it's indexes
    [~, minidx] = min(matrixChiSquare(:));
    [minUMinIndex, minTauIndex, ~] = ind2sub(size(matrixChiSquare), minidx);
end

%% Generate Mu grid of (uMin x tau x T)
function gridMu = generateGridMu(realT, T0, Umin, tau)
    [gridUmin, gridTau, gridT] = ndgrid(Umin, tau, realT);
    uGrid = sqrt(gridUmin.^2 + ((gridT - T0)./gridTau).^2);
    gridMu = (2 + uGrid.^2)./(uGrid.*sqrt(4 + uGrid.^2));
end