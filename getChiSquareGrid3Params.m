%% Get min Chi Square 3 parameters
function [gridChiSquare, minUMinIndex, minTauIndex, minT0Index] = getChiSquareGrid3Params(vecDataT, vecDataMu, vecDataSigmaMu, vecT0, vecTau, vecUmin)
    UNKNOWN_PARAMETERS_COUNT = 3;

    % Generate grid of (Umin x tau x T0 x T)
    gridMu = generateGridMu(vecDataT, vecT0, vecUmin, vecTau);
    [~, ~, ~, gridRealMu] = ndgrid(1, 1, 1, vecDataMu);
    [~, ~, ~, gridRealSigmaMu] = ndgrid(1, 1, 1, vecDataSigmaMu);

    % Calc chi square matrix - uMin x tau x T0
    gridChiSquare = sum(((gridRealMu - gridMu)./gridRealSigmaMu).^2, UNKNOWN_PARAMETERS_COUNT + 1);

    % Find chi sqaure min value & it's indexes
    [~, minidx] = min(gridChiSquare(:));
    [minUMinIndex, minTauIndex, minT0Index, ~] = ind2sub(size(gridChiSquare), minidx);
end

%% Generate Mu grid of (uMin x tau x T0 x T)
function gridMu = generateGridMu(realT, T0, Umin, tau)
    [gridUmin, gridTau, gridT0, gridT] = ndgrid(Umin, tau, T0, realT);
    uGrid = sqrt(gridUmin.^2 + ((gridT - gridT0)./gridTau).^2);
    gridMu = (2 + uGrid.^2)./(uGrid.*sqrt(4 + uGrid.^2));
end