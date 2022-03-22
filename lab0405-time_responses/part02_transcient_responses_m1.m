%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part01_lin_analysis_m1.m
% The transient response plots and pole-zero plots of various systems.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t15:19Q
% For       : ECE 3413
% Version   : 1.2.0
%
% CHANGELOG :
%   v1.2.0 - 2022-03-22t15:19Q
%       added all zeroes to analyze
%
%   v1.1.0 - 2022-03-22t15:06Q
%       added all poles to analyze
%
%   v1.0.0 - 2022-03-22t15:00Q
%       found G3(s; 200)

clear

%% G3(s; p, z)
% function handle for producing system G3(s; p)
G3 = @(p, z) zpk(z, [roots([1 4 25]); p], 25)

% poles for G3
G3poles = {-200, -20, -10, -2,   [],  [],  [], [], []}
G3zeros = {  [],  [],  [], [], -200, -50, -20, -5, -2}
[~, N_G3_PARAMS] = size(G3poles)

% for each pole
for i_param=1:N_G3_PARAMS
    G3(G3poles{i_param}, G3zeros{i_param})
end % for for i_poles

disp('Done.')
