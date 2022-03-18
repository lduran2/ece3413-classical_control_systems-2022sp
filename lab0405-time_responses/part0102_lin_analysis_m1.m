%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part0102_lin_analysis_m1.m
% Calculates the parameters of a transfer function, modifying the
% real part.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-18t19:39R
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-03-18t19:39R
%       started linear analysis

clear

%% parameters for part I exercise 2 analysis
part0102_reals_m1

%% create modified transfer functions
tfG2b = tf([G2b_b], [1 G2b_a G2b_b])
tfG2c = tf([G2c_b], [1 G2c_a G2c_b])

%% group transfer functions
real_tfs = {tfG2, tfG2b, tfG2c}

%% open linear system analyzer
linearSystemAnalyzer(real_tfs{:})
