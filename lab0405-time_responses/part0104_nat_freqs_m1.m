%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part0104_nat_freqs_m1.m
% Calculates the parameters of a transfer function, modifying the
% natural frequency.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-18t04:00R
% For       : ECE 3413
% Version   : 1.0.1
%
% CHANGELOG :
%   v1.0.1 - 2022-03-18t04:00R
%       added _m1 suffix
%
%   v1.0.0 - 2022-03-18t03:42R
%       completed part part 01.04

clear

%% part 4a.

%% parameters of G4(s; a, b) = b/(s^2 + as + b)
a = 4
b = 25

%% transfer function G4(s; a, b)
tfG4 = tf([b], [1 a b])

%% solve for the dampening ratio, natural frequency
syms szeta swn
[zeta, wn] = solve([a==2*szeta*swn, b == swn^2], [szeta, swn])

%% 4f.) natural frequency is increased two times over that of task 2a
wn4f = 2*wn
%% update a, b, getting unique answers
G4f_P_ab = unique([2*zeta.*wn4f, wn4f.^2], 'rows')
G4f_P_a = G4f_P_ab(:, 1)
G4f_P_b = G4f_P_ab(:, 2)

%% 4g.) the natural frequency is increased four times over that of task 2a
wn4g = 4*wn
%% update a, b, getting unique answers
G4g_P_ab = unique([2*zeta.*wn4g, wn4g.^2], 'rows')
G4g_P_a = G4g_P_ab(:, 1)
G4g_P_b = G4g_P_ab(:, 2)
