%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part02_transient_response_m1.m
% The transient response plots and pole-zero plots of various systems.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t22:30Q
% For       : ECE 3413
% Version   : 1.5.2
%
% CHANGELOG :
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

% whether to show a new figure after each test
new_fig_per_test{3} = false

%% G4(s; a, b) and G5(s; a, b) as G45(s; a, b; c)
G_base45 = @(c) (@(a, b) zpk([-a], [-b; roots([1 c])], (c(end)*b/a)))

% G4
G_base{4} = G_base45([4 25])
% poles and zeroes
the_poles{4,:} = { 3.01, 3.1, 3.3, 3.5, 4.0 }
the_zero{4} = 3
[~, N_PARAMS{4}] = size(the_poles{4,:})
the_zeros{4,:} = num2cell( the_zero{4}*ones(1, N_PARAMS{4}) )
% whether to show a new figure after each response
new_fig_per_test{4} = true

% G5
G_base{5} = G_base45([40 2500])
% poles and zeroes
the_poles{5,:} = { 30.01, 30.1, 30.5, 31, 35, 40 }
the_zero{5} = 30
[~, N_PARAMS{5}] = size(the_poles{5,:})
the_zeros{5,:} = num2cell( the_zero{5}*ones(1, N_PARAMS{5}) )
% whether to show a new figure after each response
new_fig_per_test{5} = true

%% analysis
% for each system
for i_sys = sys_range
    % for each pole, zero
    for i_param=1:N_PARAMS{i_sys}
        % build the system
        G{i_sys,i_param} = ...
            G_base{i_sys}( ...
                the_poles{i_sys}{i_param}, the_zeros{i_sys}{i_param});
    end % for i_param
    % for each test
    for i_test=1:N_STANDARD_TESTS
        % make a new figure if first test, or if should after this test
        if (new_fig_per_test{i_sys} || (i_test==1))
            fig = figure;
        end % if (new_fig_per_test{i_sys} || (i_test==1))
        % for each pole, zero
        for i_param=1:N_PARAMS{i_sys}
            % calculate number of rows and row offset based on
            % whether to make a new figure after each test
            if (new_fig_per_test{i_sys})
                N_ROWS = 1;
                ROW_OFF = 0;
            else
                N_ROWS = N_STANDARD_TESTS;
                ROW_OFF = N_PARAMS{i_sys}*(i_test - 1);
            end % if (new_fig_per_test{i_sys})
            % start plotting
            subplot(N_ROWS, N_PARAMS{i_sys}, (ROW_OFF + i_param))
            % impulse plot with an additional zero for each test
            impulseplot(G{i_sys,i_param}*zpk([], zeros(1,i_test), 1))
            % label the test signal response
            title(join([ ...
                STANDARD_TESTS(i_test) ' response' ...
            ], ''));
            % do not y label after first column
            if (i_param~=1)
                ylabel('')
            end % if (i_param~=1)
            % subtitle to label what zeros and poles on first row
            % include if it's a new figure
            if (new_fig_per_test{i_sys} || (i_test==1))
                subtitle(join([ ...
                    'z={' string(the_zeros{i_sys}{i_param}) '}' newline ...
                    'p={' string(the_poles{i_sys}{i_param}) '}' ...
                ], ''))
            end % if (new_fig_per_test{i_sys} || (i_test==1))
        end % for i_param
    end % for i_test
end % for i_sys

%% report done
disp('Done.')
