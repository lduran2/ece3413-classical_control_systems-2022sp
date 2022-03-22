%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part02_transient_response_m1.m
% The transient response plots and pole-zero plots of various systems.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t15:45Q
% For       : ECE 3413
% Version   : 1.3.0
%
% CHANGELOG :
%   v1.3.0 - 2022-03-22t15:45Q
%       added G4(s; 3, 3.01), G5(s; 30, 30.01)
%
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

%% G4(s; a, b) and G5(s; a, b) as G45(s; a, b; c)
G45 = @(c) (@(a, b) zpk([-a], [-b; roots([1 c])], (c(end)*b/a)))
G4 = G45([4 25])
G5 = G45([40 2500])

% poles for G3
G3poles = {-200, -20, -10, -2,   [],  [],  [], [], []}
G3zeros = {  [],  [],  [], [], -200, -50, -20, -5, -2}
[~, N_G3_PARAMS] = size(G3poles)

% for each pole
for i_param=1:N_G3_PARAMS
    G3(G3poles{i_param}, G3zeros{i_param})
end % for for i_poles

G4(3, 3.01)
G5(30, 30.01)

disp('Done.')
