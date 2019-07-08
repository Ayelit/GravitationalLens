%% Generates Mu vector values
function vecMu = generateVectorMu(vecT, valT0, valUmin, valTau)
    u = sqrt(valUmin^2 + ((vecT - valT0)/valTau).^2);
    vecMu = (2 + u.^2)./(u.*sqrt(4 + u.^2));
end