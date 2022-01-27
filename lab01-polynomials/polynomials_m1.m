% Canonical https://github.com/lduran2/
%   ece3413_classical_control_systems/
%   lab01-polynomials/polynomials_m1.m
%
% Finds the roots of various polynomials.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-01-26t10:59R
% For       : ECE 3413
% Version   : 1.1.3
%
% CHANGELOG :
%   v1.1.3 - 2022-01-26t10:59R
%       using `pole` to find the poles
%
%   v1.1.2 - 2022-01-18t20:37R
%       revert finding `polesH`, no assert
%
%   v1.1.1 - 2022-01-18t20:18R
%       using `zero` to find poles, zeros
%
%   v1.1.0 - 2022-01-18t19:54R
%       found poles, zeros of `H` (part 2)
%
%   v1.0.0 - 2022-01-18t12:13R
%       part 1 completed

%% Part 1

% clear the workspace
clear all;

% constants
DEG_PER_RAD = 180/pi;

disp('Part I')

% Given the polynomial
%   P(s) := (s^3 + 7s^2 + 10s + 9)(s^4 - 3s^3 + 6s^2 + 2s + 1),

% the factors are
% x-order :   4  3  2  1  0
B =        [     1  7 10  9 ]
A =        [  1 -3  6  2  1 ]
% We convolve to find polynomial `P(s)`.
P = conv(B, A)

% The roots are
s = roots(P);

% The phase angles are
ph_deg = (angle(s) * DEG_PER_RAD);

% display roots and angles in a table
table(s, ph_deg)

%% Part 2

disp('Part II')

% Given the transfer function
%   H(s) := \frac{s^3 + 7s^2 + 10s + 9}{s^4 - 3s^3 + 6s^2 + 2s + 1},
% (Note that the numerator and denominator are the same as the factors
%  of P.)
H = tf(B, A)

% Find the poles (roots of the denominator) of `H`.
polesH = pole(H)
% Find the zeros and gain using `zero`.
[zerosH, G] = zero(H)

disp('Done.')
