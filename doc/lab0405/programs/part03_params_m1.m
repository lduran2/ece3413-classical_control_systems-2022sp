%%
% Canonical : https://github.com/lduran2/
%   ece3413_classical_control_systems/lab0405-time_responses/
%   part0102_reals_m1.m
% Parameters for part III.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-28t10:12Q
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-03-28t10:12Q
%       parameters for part III 01, 02

INIT_I_PART = 7

%% zero padding
% temporarily store G_b and G_a
if (exist('G_b') && exist('G_a'))
    old_G_b = G_b
    old_G_a = G_a
else
    old_G_b = []
    old_G_a = []
end
[N_OLD_PARTS, N_OLD_SYS] = size(old_G_b)
% the new values to insert
new_b = [3   3.01  3.1  3.3  3.5  4.0  0; ...
          30 30.01 30.1 30.5 31   35   40 ]
[~, N_COLS_B] = size(new_b)
% zero padding
pad = zeros(1, N_COLS_B)
G_b = pad
G_a = pad
% copy in old values
G_b(1:N_OLD_PARTS, 1:N_OLD_SYS) = old_G_b
G_a(1:N_OLD_PARTS, 1:N_OLD_SYS) = old_G_a

%% part III 02.
% update indices
i_part = INIT_I_PART
i_b = 1
% multiplicity of new values
N_SYS(i_part) = sum(new_b(i_b, :) ~= 0)
% copy in the new values
G_b(i_part, :) = new_b(i_b, :)
G_a(i_part, 1:N_SYS(i_part)) = new_b(i_b, 1)*ones(1, N_SYS(i_part))

%% part III 03.
% update indices
i_part = (i_part + 1)
i_b = (i_b + 1)
% multiplicity of new values
N_SYS(i_part) = sum(new_b(i_b, :) ~= 0)
% copy in the new values
G_b(i_part, :) = new_b(i_b, :)
G_a(i_part, 1:N_SYS(i_part)) = new_b(i_b, 1)*ones(1, N_SYS(i_part))
