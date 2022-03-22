%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part01_lin_analysis_m1.m
% Displays each linear system analysis.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t04:58R
% For       : ECE 3413
% Version   : 1.0.1
%
% CHANGELOG :
%   v1.0.1 - 2022-03-22t04:58R
%       parts menu
%
%   v1.0.0 - 2022-03-18t19:39R
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

%% accepts an exercise number
function i_choice = part_menu()
    i_choice = 0;           % initial invalid choice
    % loop until value choice
    while (all(i_choice ~= [1:4, -1]))
        disp('Exercises:')
        disp('    1. First-Order Systems')
        disp('    2. Variable Real Parts')
        disp('    3. Variable Imaginary Parts')
        disp('    4. Variable Natural Frequencies')
        disp('   -1. exit')
        % allow user input
        i_choice = input('Choose: ');
    end % while (~any(i_choice==[1:4]))
end % function part_menu()
