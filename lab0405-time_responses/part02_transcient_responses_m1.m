%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part01_lin_analysis_m1.m
% The transient response plots and pole-zero plots of various systems.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t15:00Q
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-03-22t15:00Q
%       found G3(s; 200)

clear

% function handle for system G3(s; p)
G3 = @(p) zpk([], [roots([1 4 25]); p], 25);

G3(-200)