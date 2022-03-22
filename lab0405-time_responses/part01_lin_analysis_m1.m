%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part01_lin_analysis_m1.m
% Displays each linear system analysis.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t10:03Q
% For       : ECE 3413
% Version   : 1.0.2
%
% CHANGELOG :
%   v1.0.2 - 2022-03-22t10:03Q
%       added (illegal choice, non-exit) response to parts menu
%
%   v1.0.1 - 2022-03-22t04:58Q
%       parts menu
%
%   v1.0.0 - 2022-03-18t19:39Q
%       started linear analysis

clear

%% parameters for part I 02-04 analysis
part0102_reals_m1
part0103_imags_m1
part0104_nat_freqs_m1

%% transfer functions for part I 01 analysis
i_part = 1
% number of transfer functions
n_tfG(i_part) = 4
% loop from a=1 to 4
for a=1:n_tfG(i_part)
    tfG{i_part,a} = tf([a], [1 a]);
end % for a=1:n_tfG(i_part)

%% create modified transfer functions for part I 02-04 analysis
% for each part of 
for i_part=2:4
    for i_tf=2:n_tfG(i_part)
        tfG{i_part, i_tf} = tf( ...
            G_b(i_part, i_tf), ...
            [1 G_a(i_part, i_tf), G_b(i_part, i_tf)] ...
        );
    end % for i_tf
end % for i_part

%% display tfG
tfG

%% open linear system analyzer for each part
i_part = part_menu();       % initial choice
while (i_part ~= -1)
    linearSystemAnalyzer(tfG{i_part, 1:n_tfG(i_part)})
    i_part = part_menu();   % ask again
end % while ((i_part=part_menu()) ~= -1)

%% report done
disp('Done.')

%% accepts an exercise number
function i_choice = part_menu()
    % menu options
    options = [ ...
        "First-Order Systems" ...
        "Variable Real Parts" ...
        "Variable Imaginary Parts" ...
        "Variable Natural Frequencies" ...
    ];
    [~, N_OPTIONS] = size(options);

    % loop until valid choice
    i_choice = prompt();
    while (~is_valid(i_choice))
        disp(newline)
        disp('Illegal option: please try again.')
        i_choice = prompt();
    end % while (~is_valid(i_choice))

    % repeated prompt
    function i_choice = prompt()
        disp('Exercises:')
        for i_option=1:N_OPTIONS
            disp(join(['    ' i_option '. ' options(i_option)], ''))
        end % for option
        disp('   -1. exit')
        % allow user input
        i_choice = input('Choose: ');
    end % function prompt()

    function flag = is_valid(i_choice)
        % non-exit menu option
        if (any(i_choice==1:N_OPTIONS))
            % show option
            disp(join(['Choice: ' options(i_choice)], ''))
            flag = true;
        % exit
        elseif (i_choice==-1)
            flag = true;
        % ask again
        else
            flag = false;
        end % if (any(i_choice==1:N_OPTIONS)) || (i_choice==-1) ||
    end % function is_valid(i_choice)
end % function part_menu()
