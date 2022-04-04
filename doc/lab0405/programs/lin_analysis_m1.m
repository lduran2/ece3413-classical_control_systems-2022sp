%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/lin_analysis_m1.m
% Menu for function's linear system analyses.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-28t19:16Q
% For       : ECE 3413
% Version   : 1.3.1
%
% CHANGELOG :
%   v1.3.1 - 2022-03-28t19:16Q
%       normalize poles, zeroes to steady state value (III-02)
%
%   v1.3.0 - 2022-03-28t13:56Q
%       normalize poles to steady state value (III-01)
%
%   v1.2.0 - 2022-03-28t12:32Q
%       parametric systems from part III
%
%   v1.1.1 - 2022-03-28t04:35Q
%       extra poles, zeros from part III
%
%   v1.1.0 - 2022-03-28t02:50Q
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

%% parameters for analysis
% time_response_params_m1
time_response_params_m1
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
for i_part=2:N_PARTS(1)
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
G3_gcf = tf([25], [1 4 25])

%% systems for part III 01, 02 analysis
% the additional poles and zeros
part0301_poles = [-200, -20, -10, -2]
part0302_zeros = [-200, -50, -20, -10, -5, -2]
[~, N_SYS(i_part + 1)] = size(part0301_poles)
[~, N_SYS(i_part + 2)] = size(part0302_zeros)
% create cells of poles and zeros
part030102_poles{1,:} = arrayfun(@(v) v, part0301_poles, 'UniformOutput', false)
part030102_poles{2,:} = arrayfun(@(v) [], part0302_zeros, 'UniformOutput', false)
part030102_zeros{1,:} = arrayfun(@(v) [], part0301_poles, 'UniformOutput', false)
part030102_zeros{2,:} = arrayfun(@(v) v, part0302_zeros, 'UniformOutput', false)
% for each of part III 01, 02
for i_ex=1:2
    % combined part exercise count
    i_part_ex = i_part + i_ex
    % add the GCF
    N_SYS(i_part_ex) = N_SYS(i_part_ex) + 1
    sysG{i_part_ex,1} = G3_gcf;
    % loop through poles
    for i_pole=2:N_SYS(i_part_ex)
        % add pole, zero to the G3 base
        p = part030102_poles{i_ex}{(i_pole - 1)}
        z = part030102_zeros{i_ex}{(i_pole - 1)}
        sysG{i_part_ex,i_pole} = G3_gcf * zpk(z, p, 1);
        % convert to symbolic expression in terms of s
        syms s
        symG_s = sys2sym(sysG{i_part_ex,i_pole})
        % find steady state value
        vss = double(limit(symG_s, s, 0))
        % normalize sysG to steady state value
        norm_sysG = (sysG{i_part_ex,i_pole} / vss)
        sysG{i_part_ex,i_pole} = norm_sysG;
    end % for i_pole=2:N_SYS(i_expart)
end % for i_ex=1:2
% update N_PARTS(1)
N_PARTS(1) = i_part_ex, i_part = N_PARTS(1)

%% GCF for parts III 03, 04
G45_gcf{1} = G3_gcf;
G45_gcf{2} = tf([2500], [1 40 2500]);
[~, N_G34_GCF] = size(G45_gcf)
% loop through GCFs
for i_gcf=1:N_G34_GCF
    % calculate i_part from i_gcf
    i_gcf_part = i_part + i_gcf
    % for each system for this part
    for i_sys=1:N_SYS(i_gcf_part)
        % current parameters
        curr_b = G_b(i_gcf_part, i_sys)
        curr_a = G_a(i_gcf_part, i_sys)
        % current G/GCF
        curr_zpk = zpk([-curr_a], [-curr_b], curr_b/curr_a)
        % create the full function
        sysG{i_gcf_part, i_sys} = G45_gcf{i_gcf} * curr_zpk;
    end % for i_sys=1:N_SYS(i_gcf_part)
end % for i_gcf=1:N_G34_GCF
% update N_PARTS(1)
N_PARTS(1) = N_PARTS(1) + N_G34_GCF, i_part = N_PARTS(1)

%% display tfG
sysG

%% open linear system analyzer for each part
i_part = part_menu(N_SYS);  % initial choice
while (i_part ~= -1)
    linearSystemAnalyzer(...
        sysG{i_part, 1:N_SYS(i_part)}, ...
        ... guidelines: y = 0.02, y = 0.9, y = 0.1
        tf([0.02],[1]), tf([0.9],[1]), tf([0.1],[1]) ...
    )
    i_part = part_menu(N_SYS);   % ask again
end % while ((i_part=part_menu()) ~= -1)

%% report done
disp('Done.')

%% accepts an exercise number
function i_choice = part_menu(n_sys)
    global DO_SKIP_PART_MENU
    global PART_SENTINEL
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
        "Part III: Parametric Transfer Function I" ...
        "Part III: Parametric Transfer Function II" ...
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
            CURR_N_SYS = n_sys(i_option);
            disp(join([ ...
                '    ' i_option '. ' options(i_option) ...
                ' (' string(CURR_N_SYS) ')' ...
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
