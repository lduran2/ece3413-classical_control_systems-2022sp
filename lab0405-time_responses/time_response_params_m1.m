[1%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/time_response_params_m1.m
% Clears workspace and runs the scripts for parameters for the Time
% Response model.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-28t10:52Q
% For       : ECE 3413
% Version   : 1.1.1
%
% CHANGELOG :
%   v1.1.1 - 2022-03-28t10:52Q
%       save number of parts so far
%
%   v1.1.0 - 2022-03-28t05:14Q
%       gets the parameters for part 03
%
%   v1.0.0 - 2022-03-18t13:37Q
%       gets the parameters for part 01

clear

%% parameters for part 01
part0102_reals_m1
part0103_imags_m1
part0104_nat_freqs_m1
% save number of parts so far
N_PARTS(1) = i_part

%% parameters for part 03
part03_params_m1
N_PARTS(2) = i_part
