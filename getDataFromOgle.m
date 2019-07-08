%% Return data from OGLE
% Read data & metadata from OGLE file
function [vecDataT, vecDataImag, vecDataSigmaImag, T0, delT0, tau, delTau, Umin, delUmin, Fbl, delFbl, Ibl, delIbl] = getDataFromOgle(fileName, fileExtension)
    T_INDEX = 1;
    MAG_INDEX = 2;
    SIGMA_MAG_INDEX = 3;
    
    T0_INDEX = 1;
    DEL_T0_INDEX = 2;
    TAU_INDEX = 3;
    DEL_TAU_INDEX = 4;
    U_MIN_INDEX = 5;
    DEL_U_MIN_INDEX = 6;
    F_BL_INDEX = 7;
    DEL_F_BL_INDEX = 8;
    I_BL_INDEX = 9;
    DEL_I_BL_INDEX = 10;
    
    % Read from OGLE data file
    dataFileName = strcat(fileName, fileExtension);
    data = load(dataFileName);
    
    vecDataT = data(:, T_INDEX);
    vecDataImag = data(:, MAG_INDEX);
    vecDataSigmaImag = data(:, SIGMA_MAG_INDEX);
    
    % Read metadata from OGLE
    metadataFileName = strcat(fileName, "-Metadata", fileExtension);
    metadata = load(metadataFileName);
    
    T0 = metadata(:, T0_INDEX);
    delT0 = metadata(:, DEL_T0_INDEX);
    
    tau = metadata(:, TAU_INDEX);
    delTau = metadata(:, DEL_TAU_INDEX);
    
    Umin = metadata(:, U_MIN_INDEX);
    delUmin = metadata(:, DEL_U_MIN_INDEX);
    
    Fbl = metadata(:, F_BL_INDEX);
    delFbl = metadata(:, DEL_F_BL_INDEX);
    
    Ibl = metadata(:, I_BL_INDEX);
    delIbl = metadata(:, DEL_I_BL_INDEX);
end