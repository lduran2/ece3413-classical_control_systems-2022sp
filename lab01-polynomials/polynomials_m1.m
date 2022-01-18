% https://github.com/lduran2/ece3413_classical_control_systems/lab01/polynomials_m1.m
%
% Finds the roots of various polynomials.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-01-18t12:13R
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-01-18t12:13R
%       part 1 completed

%% Part 1

% clear the workspace
clear all;

% constants
DEG_PER_RAD = 180/pi;

disp('Part I')

% Given the polynomial
% P(s) = (s^3 + 7s^2 + 10s + 9)(s^4 - 3s^3 + 6s^2 + 2s + 1),

% the factors are
%             4  3  2  1  0
Pfactors = [  0  1  7 10  9;
              1 -3  6  2  1 ]
% We convolve to find polynomial P(s).
P = conv(Pfactors(1,:), Pfactors(2,:))

% The roots are
s = roots(P);

% The phase angles are
ph_deg = (angle(s) * DEG_PER_RAD);

% display roots and angles in a table
table(s, ph_deg)

disp('Done.')