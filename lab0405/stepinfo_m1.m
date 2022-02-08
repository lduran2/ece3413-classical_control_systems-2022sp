% https://github.com/lduran2/ece3413_classical_control_systems/lab0405/stepinfo_m1.m
%
% Finds the roots of various polynomials.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-08t11:25R
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-01-18t12:13R
%       

for a = 1:4
    % display a
    a
    % G1(s; a) := a/(s + a).
    B = [a]
    A = [1 a]
    G1_s = tf(B, A)
    % display settling time, rise time and peak time for G1(s; a)
    G1_s_step = stepinfo(G1_s);
    SettlingTime = G1_s_step.SettlingTime
    RiseTime = G1_s_step.RiseTime
    PeakTime = G1_s_step.PeakTime
end % for a