%% Get min Chi Square 2 parameters + Fbl
function [gridChiSquare, minUMinIndex, minTauIndex, minFblIndex] = ...
                getChiSquareGrid2ParamsAndFbl(vecDataT, vecDataMu0, vecDataSigmaMu0, valT0, vecTau, vecUmin, vecFbl)
    UNKNOWN_PARAMETERS_COUNT = 3;
    
    % Generate grid of (Umin x tau x Fbl x T)
    gridMu0 = generateGridMu0(vecDataT, valT0, vecUmin, vecTau, vecFbl);
    [~, ~, ~, gridRealMu0] = ndgrid(1, 1, 1, vecDataMu0);
    [~, ~, ~, gridRealSigmaMu0] = ndgrid(1, 1, 1, vecDataSigmaMu0);

    % Calc chi square matrix - uMin x tau x T0
    gridChiSquare = sum(((gridRealMu0 - gridMu0)./gridRealSigmaMu0).^2, UNKNOWN_PARAMETERS_COUNT + 1);

    % Find chi sqaure min value & it's indexes
    [~, minidx] = min(gridChiSquare(:));
    [minUMinIndex, minTauIndex, minFblIndex, ~] = ind2sub(size(gridChiSquare), minidx);
end

%% Generate Mu grid of (Umin x tau x Fbl x T)
function gridMu0 = generateGridMu0(realT, T0, Umin, tau, fbl)
    [gridUmin, gridTau, gridFbl, gridT] = ndgrid(Umin, tau, fbl, realT);
    
    uGrid = sqrt(gridUmin.^2 + ((gridT - T0)./gridTau).^2);
    gridMu = (2 + uGrid.^2)./(uGrid.*sqrt(4 + uGrid.^2));
    
    gridMu0 = 1 + gridFbl.*(gridMu - 1);
end