%%
% Canonical : https://github.com/lduran2/
%   ece3413_classical_control_systems/lab0405-time_responses/
%   part0104_nat_freqs_m1.m
% Calculates the parameters of a transfer function, modifying the
% natural frequency.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-18t13:08Q
% For       : ECE 3413
% Version   : 1.1.0
%
% CHANGELOG :
%   v1.1.0 - 2022-03-21t13:08Q
%       parameters in arrays
%
%   v1.0.3 - 2022-03-18t13:31Q
%       removed clear so parts can be called together
%
%   v1.0.2 - 2022-03-18t04:21Q
%       a, b output shorter names, zwab function
%
%   v1.0.1 - 2022-03-18t04:00Q
%       added _m1 suffix
%
%   v1.0.0 - 2022-03-18t03:42Q
%       completed part part 01.04

%% part 4a.
i_part = 4

%% parameters of G4(s; a, b) = b/(s^2 + as + b)
a = 4
b = 25

%% transfer function G4(s; a, b)
tfG{i_part,1} = tf([b], [1 a b])

%% number of transfer functions
n_tfG(i_part) = 3

%% solve for the dampening ratio, natural frequency
syms szeta swn
zwab = @(zeta, wn) [2*zeta.*wn, wn.^2]
[zeta, wn] = solve([a,b]==zwab(szeta, swn), [szeta, swn])

%% 4f.) natural frequency is increased two times over that of task 2a
wn4f = 2*wn
%% update a, b, getting unique answers for 4f (2)
G4f_ab = double(unique(zwab(zeta, wn4f), 'rows'))
G_a(i_part,2) = G4f_ab(:, 1)
G_b(i_part,2) = G4f_ab(:, 2)

%% 4g.) the natural frequency is increased four times over that of task 2a
wn4g = 4*wn
%% update a, b, getting unique answers for 4g (3)
G4g_ab = double(unique(zwab(zeta, wn4g), 'rows'))
G_a(i_part,3) = G4g_ab(:, 1)
G_b(i_part,3) = G4g_ab(:, 2)
