%% Convert Mu values to I-mag values
function vecImag = convertMuToImag(vecMu, Fbl, Ibl)
    % Convert Mu to Mu0
    vecMu0 = 1 + Fbl*(vecMu - 1);
    
    % Convert Mu0 to I mag
    vecImag = Ibl - log(vecMu0)/(0.4*log(10));
end