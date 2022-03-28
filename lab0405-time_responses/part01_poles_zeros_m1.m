%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part01_poles_zeros_m1.m
% Displays each function's poles for part I.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-28t02:37Q
% For       : ECE 3413
% Version   : 1.1.0
%
% CHANGELOG :
%   v1.1.0 - 2022-03-28t02:37Q
%       pole/zero map, pole table separated from linear analysis
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

%% parameters for part I 02-04 analysis
part0102_reals_m1
part0103_imags_m1
part0104_nat_freqs_m1
% save number of parts
N_PARTS = i_part

%% transfer functions for part I 01 analysis
i_part = 1
% number of transfer functions
n_tfG(i_part) = 4
% loop a
for a=1:n_tfG(i_part)
    tfG{i_part,a} = tf([a], [1 a]);
end % for a=1:n_tfG(i_part)

%% create modified transfer functions for part I 02-04 analysis
N_POLES_0102_0104_COLS = 2*max(n_tfG(2:N_PARTS))
poles_0102_0104_cols = cell(1, N_POLES_0102_0104_COLS);
poles_0102_0104 = cell(N_PARTS-1, N_POLES_0102_0104_COLS);
% for each part
i_part_tf = 0;
for i_part=2:N_PARTS
    for i_tf=1:n_tfG(i_part)
        % if not tf/col 1
        if (i_tf > 1)
            % increment count
            i_part_tf = i_part_tf + 1
            part_tf_no = i_part_tf
            % build the transfer function
            tfG{i_part, i_tf} = tf( ...
                G_b(i_part, i_tf), ...
                [1 G_a(i_part, i_tf), G_b(i_part, i_tf)] ...
            );
        else
            % otherwise, just label as #1
            part_tf_no = 1
        end % if (i_tf > 1) ||
        tfG_name = join( ...
            ['transfer function 2' ...
                char('`' + part_tf_no) ...
            ] ...
            , '' ...
        )
        % retrieve poles
        tf_poles = zpk(tfG{i_part, i_tf}).P{:}
        pole_row = (i_part - 1)
        pole_col1 = (2*i_tf - 1)
        poles_0102_0104{pole_row, pole_col1    } = tf_poles(1);
        poles_0102_0104{pole_row, pole_col1 + 1} = tf_poles(2);
        % show graph A only once
        if ((i_tf == 1) && (i_part > 2))
            continue
        end %
        % plot poles and zeros
        fig = figure;
        pzmap(tfG{i_part, i_tf})
        title(join([ 'Pole-Zero Map' newline tfG_name ], ''))
        xlim(20*[-1 1])
        ylim(20*[-1 1])
    end % for i_tf
end % for i_part

%% display tfG
tfG

%% show pole table
pole_2nd_ord_table = cell2table(poles_0102_0104, 'VariableNames', [ ...
    "tf a pole+" "tf a pole-" "tf b,d,f pole+" "tf b,d,f pole-" ...
    "tf c,e,g pole+" "tf c,e,g pole-" ...
])

%% report done
disp('Done.')
