%% parabolicFit
% Finds coefficients & errors of y = ax^2 + bx + c
% x, y & sigmaY - N-on-1 vectors
function [coefficients, errors, chiSquare] = parabolicFit(x, y, sigmaY)
    inputSize = length(x);
    parabolicFitSize = 3;

    % Calc matrix C
    matrixC = ones(inputSize, parabolicFitSize);
    matrixC = matrixC./sigmaY;

    for colIndex = 1:parabolicFitSize
        matrixC(:, colIndex) = matrixC(:, colIndex).*(x.^(colIndex - 1));
    end

    % Calc matrix C transpose
    matrixCTranspose = matrixC';

    % Calc matrix CC
    matrixCC = matrixCTranspose*matrixC;

    % Calc vector y/sigma
    vectorYSigma = y./sigmaY;

    % Calc vector Cy
    vectorCy = matrixCTranspose*vectorYSigma;

    % Calc coefficients (c, b, a)
    coefficients = matrixCC\vectorCy; % = inv(matrixCC)*vectorCy

    % Calc chi square
    chiSquare = sum(((y - coefficients(3)*x.^2 - coefficients(2).*x - coefficients(1))./sigmaY).^2);

    % Calc matrix Vy
    matrixVy = diag(sigmaY.^2);

    % Calc matrix V coefficients
    matrixVcoefficients = (matrixCTranspose*(matrixVy\matrixC))\diag(ones(parabolicFitSize, 1));
    errors = sqrt(diag(matrixVcoefficients));
end