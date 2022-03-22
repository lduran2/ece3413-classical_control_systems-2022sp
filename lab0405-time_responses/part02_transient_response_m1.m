%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part02_transient_response_m1.m
% The transient response plots and pole-zero plots of various systems.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t16:21Q
% For       : ECE 3413
% Version   : 1.4.0
%
% CHANGELOG :
%   v1.4.0 - 2022-03-22t16:21Q
%       looping through all parameters for all systems
%
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

%% the range of the system subscripts
sys_range = 3:5

%% G3(s; p, z)
% function handle for producing system G3(s; p)
G{3} = @(p, z) zpk(z, [roots([1 4 25]); p], 25)

% poles and zeroes for G3
the_poles{3,:} = {-200, -20, -10, -2,   [],  [],  [], [], []}
the_zeros{3,:} = {  [],  [],  [], [], -200, -50, -20, -5, -2}
[~, N_PARAMS{3}] = size(the_poles{3,:})

%% G4(s; a, b) and G5(s; a, b) as G45(s; a, b; c)
G45 = @(c) (@(a, b) zpk([-a], [-b; roots([1 c])], (c(end)*b/a)))

% G4
G{4} = G45([4 25])
% poles and zeroes
the_poles{4,:} = { 3.01, 3.1, 3.3, 3.5, 4.0 }
the_zero{4} = 3
[~, N_PARAMS{4}] = size(the_poles{4,:})
the_zeros{4,:} = num2cell( the_zero{4}*ones(1, N_PARAMS{4}) )

% G5
G{5} = G45([40 2500])
% poles and zeroes
the_poles{5,:} = { 30.01, 30.1, 30.5, 31, 35, 40 }
the_zero{5} = 30
[~, N_PARAMS{5}] = size(the_poles{5,:})
the_zeros{5,:} = num2cell( the_zero{5}*ones(1, N_PARAMS{5}) )

%% analysis
% for each system
for i_sys = sys_range
    % for each pole
    for i_param=1:N_PARAMS{i_sys}
        G{i_sys}(the_poles{i_sys}{i_param}, the_zeros{i_sys}{i_param})
    end % for for i_param
end % for i_sys

%% report done
disp('Done.')
