%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part0102_reals_m1.m
% Calculates the parameters of a transfer function, modifying the
% real part.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-18t04:08R
% For       : ECE 3413
% Version   : 1.1.4
%
% CHANGELOG :
%   v1.1.4 - 2022-03-18t04:08R
%       a, b output shorter names
%
%   v1.1.3 - 2022-03-18t04:00R
%       added _m1 suffix
%
%   v1.1.2 - 2022-03-18t02:06R
%       part 2b, found a, b for (1/2)Re{s0}
%
%   v1.1.1 - 2022-03-18t02:03R
%       part 2b, found a, b for 2Re{s0}
%
%   v1.1.0 - 2022-03-18t01:43R
%       used zpk to find poles
%
%   v1.0.0 - 2022-03-17t11:59R
%       found the roots of G2(s; a, b)

clear

%% part 2a.

%% parameters of G2(s; a, b) = b/(s^2 + as + b)
a = 4
b = 25

%% transfer function G2(s; a, b)
tfG2 = tf([b], [1 a b])

%% find as ZPK function
zpkG2 = zpk(tfG2)                   % convert to ZPK form
G2_Z = [ zpkG2.Z{:} ]               % original zeros
G2_P = [ zpkG2.P{:} ]               % original poles
G2_K = zpkG2.K                      % original gain

%% find pole parts
G2_P_Re = real(G2_P)                % real parts of poles
G2_P_Im = imag(G2_P)                % imaginary parts of poles

%% 2b.) real part is increased two times over that of task 2a
G2b_P_Re = 2*G2_P_Re                % double real part
G2b_P = (G2b_P_Re) + (G2_P_Im)*j    % combine real, imaginary parts
zpkG2b = zpk(G2_Z, G2b_P, G2_K)     % make zpk filter
tfG2b = tf(zpkG2b)                  % convert to standard transfer function

%% extract a and b for 2b
G2b_den_poly = tfG2b.Denominator{:}
G2b_a = G2b_den_poly(2)
G2b_b = G2b_den_poly(3)

%% 2c.)  real part is decreased 1/2 time over that of task 2a
G2c_P_Re = G2_P_Re/2                % double real part
G2c_P = (G2c_P_Re) + (G2_P_Im)*j    % combine real, imaginary parts
zpkG2c = zpk(G2_Z, G2c_P, G2_K)     % make zpk filter
tfG2c = tf(zpkG2c)                  % convert to standard transfer function

%% extract a and b for 2c
G2c_den_poly = tfG2c.Denominator{:}
G2c_a = G2c_den_poly(2)
G2c_b = G2c_den_poly(3)
