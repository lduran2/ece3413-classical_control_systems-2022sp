%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/lin_analysis_m1.m
% Menu for function's linear system analyses.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-22t04:35Q
% For       : ECE 3413
% Version   : 1.1.1
%
% CHANGELOG :
%   v1.1.1 - 2022-03-22t04:35Q
%       extra poles, zeros from part III
%
%   v1.1.0 - 2022-03-22t02:50Q
%       linear analysis separated from pole/zero map, pole table
%
%   v1.0.4 - 2022-03-22t12:30Q
%       pole table
%
%   v1.0.3 - 2022-03-22t11:25Q
%       poles of 2nd order, skip part menu
%
%   v1.0.2 - 2022-03-22t10:03Q
%       added (illegal choice, non-exit) response to parts menu
%
%   v1.0.1 - 2022-03-22t04:58Q
%       parts menu
%
%   v1.0.0 - 2022-03-18t19:39Q
%       started linear analysis

clear

%% debug modes
global DO_SKIP_PART_MENU
DO_SKIP_PART_MENU = false

%% constants
global PART_SENTINEL
PART_SENTINEL = -1

%% parameters for part I 02-04 analysis
part0102_reals_m1
part0103_imags_m1
part0104_nat_freqs_m1
% save number of parts
N_PARTS = i_part
% copy tfG into sysG
% allow any type of system
sysG = tfG

%% transfer functions for part I 01 analysis
i_part = 1
% number of transfer functions
N_SYS(i_part) = 4
% loop a
for a=1:N_SYS(i_part)
    sysG{i_part,a} = tf([a], [1 a]);
end % for a=1:n_tfG(i_part)

%% create modified transfer functions for part I 02-04 analysis
% for each part
i_part_tf = 0;
% for each part
for i_part=2:N_PARTS
    % copy n_tfG into N_SYS
    N_SYS(i_part) = n_tfG(i_part)
    for i_tf=2:N_SYS(i_part)
        % build the transfer function
        sysG{i_part, i_tf} = tf( ...
            G_b(i_part, i_tf), ...
            [1 G_a(i_part, i_tf), G_b(i_part, i_tf)] ...
        );
    end % for i_tf
end % for i_part

%% GCF for parts III 01, 02
G3_GCF = tf([25], [1 4 25])

%% systems for part III 01 analysis
N_PARTS = N_PARTS + 1, i_part = N_PARTS
% the additional poles
part0301_poles = [-200, -20, -10, -2]
[~, N_SYS(i_part)] = size(part0301_poles)
N_SYS(i_part) = N_SYS(i_part) + 1
% add the GCF
sysG{i_part,1} = G3_GCF
% loop through poles
for i_pole=2:N_SYS(i_part)
    % add pole to the G3 base
    p = part0301_poles(i_pole - 1)
    sysG{i_part,i_pole} = G3_GCF * zpk([1], p, 1);
end % for i_pole=2:N_SYS(i_part)

%% systems for part III 02 analysis
N_PARTS = N_PARTS + 1, i_part = N_PARTS
% the additional zeros
part0302_zeros = [-200, -50, -20, -10, -5, -2]
[~, N_SYS(i_part)] = size(part0302_zeros)
N_SYS(i_part) = N_SYS(i_part) + 1
% add the GCF
sysG{i_part,1} = G3_GCF
% loop through poles
for i_zero=2:N_SYS(i_part)
    % add zero to the G3 base
    z = part0302_zeros(i_zero - 1)
    sysG{i_part,i_zero} = G3_GCF * zpk(z, [], 1);
end % for i_zero=1:N_SYS(i_part)

%% display tfG
sysG

%% open linear system analyzer for each part
i_part = part_menu(N_SYS);  % initial choice
while (i_part ~= -1)
    linearSystemAnalyzer(sysG{i_part, 1:N_SYS(i_part)})
    i_part = part_menu();   % ask again
end % while ((i_part=part_menu()) ~= -1)

%% report done
disp('Done.')

%% accepts an exercise number
function i_choice = part_menu(n_sys)
    global  DO_SKIP_PART_MENU  PART_SENTINEL  n_sys
    % check whether to skip
    if (DO_SKIP_PART_MENU)
        i_choice = PART_SENTINEL;
        return
    end % if (DO_SKIP_PART_MENU)

    % menu options
    options = [ ...
        "Part I: First-Order Systems" ...
        "Part I: Variable Real Parts" ...
        "Part I: Variable Imaginary Parts" ...
        "Part I: Variable Natural Frequencies" ...
        "Part III: Added Poles" ...
        "Part III: Added Zeros" ...
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
            disp(join([ ...
                '    ' i_option '. ' options(i_option) ...
                ' (' string(n_sys(i_option)) ')'
            ], ''))
        end % for option
        disp(join(['   ' string(PART_SENTINEL) '. exit'], ''))
        % allow user input
        i_choice = input('Choose: ');
    end % function prompt()

    function flag = is_valid(i_choice)
        if (i_choice==PART_SENTINEL)
            % exit option
            flag = true;
        elseif (any(i_choice==1:N_OPTIONS))
            % non-exit menu option: show option
            disp(join(['Choice: ' options(i_choice)], ''))
            flag = true;
        else
            % illegal option: ask again
            flag = false;
        end % if (any(i_choice==1:N_OPTIONS)) ||
            %       (i_choice==PART_SENTINEL) ||
    end % function is_valid(i_choice)
end % function part_menu()
