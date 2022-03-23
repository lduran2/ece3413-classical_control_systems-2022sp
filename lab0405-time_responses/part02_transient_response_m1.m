%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part02_transient_response_m1.m
% The transient response plots and pole-zero plots of various systems.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-23t01:15Q
% For       : ECE 3413
% Version   : 1.6.1
%
% CHANGELOG :
%   v1.6.1 - 2022-03-23t01:15Q
%       plotting variations of each system together
%
%   v1.6.0 - 2022-03-22t22:30Q
%       added pzmaps as headers
%
%   v1.5.2 - 2022-03-22t22:30Q
%       can new figure after each test
%
%   v1.5.1 - 2022-03-22t22:11Q
%       switched param and test loops
%
%   v1.5.0 - 2022-03-22t21:58Q
%       graphed each transient response
%
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

%% standard test signals for transient response plots
STANDARD_TESTS = ["impulse", "step", "ramp", "parabola"]
[~, N_STANDARD_TESTS] = size(STANDARD_TESTS)

%% the range of the system subscripts
sys_range = 3:5

%% G3(s; p, z)
% function handle for producing system G3(s; p)
G_base{3} = @(p, z) zpk(z, [roots([1 4 25]); p], 25)

% poles and zeroes for G3
the_poles{3,:} = {-200, -20, -10, -2,   [],  [],  [], [], []}
the_zeros{3,:} = {  [],  [],  [], [], -200, -50, -20, -5, -2}
[~, N_PARAMS{3}] = size(the_poles{3,:})

%% G4(s; a, b) and G5(s; a, b) as G45(s; a, b; c)
G_base45 = @(c) (@(a, b) zpk([-a], [-b; roots([1 c])], (c(end)*b/a)))

% G4
G_base{4} = G_base45([4 25])
% poles and zeroes
the_poles{4,:} = { 3.01, 3.1, 3.3, 3.5, 4.0 }
the_zero{4} = 3
[~, N_PARAMS{4}] = size(the_poles{4,:})
the_zeros{4,:} = num2cell( the_zero{4}*ones(1, N_PARAMS{4}) )

% G5
G_base{5} = G_base45([40 2500])
% poles and zeroes
the_poles{5,:} = { 30.01, 30.1, 30.5, 31, 35, 40 }
the_zero{5} = 30
[~, N_PARAMS{5}] = size(the_poles{5,:})
the_zeros{5,:} = num2cell( the_zero{5}*ones(1, N_PARAMS{5}) )

%% analysis
% for each system
for i_sys = sys_range
    % new figure
    fig = figure;
    subplot((N_STANDARD_TESTS + 1), 1, 1)
    hold on
    % for each pole, zero
    for i_param=1:N_PARAMS{i_sys}
        % build the system
        G{i_sys,i_param} = ...
            G_base{i_sys}( ...
                the_poles{i_sys}{i_param}, the_zeros{i_sys}{i_param});
        % plot pole-zero for comparison
        [P, Z] = pzmap(G{i_sys,i_param})
        plt = plot(real(P), imag(P), 'x', real(Z), imag(Z), 'o');
    end % for i_param
    hold off
    % for each test
    for i_test=1:N_STANDARD_TESTS
        % start plotting the test
        subplot((N_STANDARD_TESTS + 1), 1, (1 + i_test))
        hold on
        % for each pole, zero
        for i_param=1:N_PARAMS{i_sys}
            % impulse plot with an additional zero for each test
            impulseplot(G{i_sys,i_param}*zpk([], zeros(1,i_test), 1))
        end % for i_param
        % label the test signal response
        title(join([ ...
            STANDARD_TESTS(i_test) ' response' ...
        ], ''));
        hold off
    end % for i_test
end % for i_sys

%% report done
disp('Done.')
