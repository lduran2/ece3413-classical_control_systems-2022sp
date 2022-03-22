%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part0102_reals_m1.m
% Calculates the parameters of a transfer function, modifying the
% real part.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-18t12:56Q
% For       : ECE 3413
% Version   : 1.2.0
%
% CHANGELOG :
%   v1.2.0 - 2022-03-21t12:56Q
%       parameters in arrays
%
%   v1.1.5 - 2022-03-18t13:31Q
%       removed clear so parts can be called together
%
%   v1.1.4 - 2022-03-18t04:08Q
%       a, b output shorter names
%
%   v1.1.3 - 2022-03-18t04:00Q
%       added _m1 suffix
%
%   v1.1.2 - 2022-03-18t02:06Q
%       part 2b, found a, b for (1/2)Re{s0}
%
%   v1.1.1 - 2022-03-18t02:03Q
%       part 2b, found a, b for 2Re{s0}
%
%   v1.1.0 - 2022-03-18t01:43Q
%       used zpk to find poles
%
%   v1.0.0 - 2022-03-17t11:59Q
%       found the roots of G2(s; a, b)

%% part 2a.
i_part = 2

%% parameters of G2(s; a, b) = b/(s^2 + as + b)
a = 4
b = 25

%% transfer function G2(s; a, b)
tfG{i_part,1} = tf([b], [1 a b])

%% number of transfer functions
n_tfG(i_part) = 3

%% find as ZPK function
zpkG2 = zpk(tfG{i_part,1})          % convert to ZPK form
G2_Z = [ zpkG2.Z{:} ]               % original zeros
G2_P = [ zpkG2.P{:} ]               % original poles
G2_K = zpkG2.K                      % original gain

%% find pole parts
G2_P_Re = real(G2_P)                % real parts of poles
G2_P_Im = imag(G2_P)                % imaginary parts of poles

%% 2b.) real part is increased two times over that of task 2a
G2b_P_Re = 2*G2_P_Re                % double real part
G2b_P = (G2b_P_Re) + (G2_P_Im)*j    % combine real, imaginary parts
den_zpkG2b = zpk(G2_Z, G2b_P, G2_K) % make zpk filter for denominator
den_tfG2b = tf(den_zpkG2b)          % convert to standard transfer function

%% extract a and b for 2b (2)
G2b_den_poly = den_tfG2b.Denominator{:}
G_a(i_part,2) = G2b_den_poly(2)
G_b(i_part,2) = G2b_den_poly(3)

%% 2c.)  real part is decreased 1/2 time over that of task 2a
G2c_P_Re = G2_P_Re/2                % double real part
G2c_P = (G2c_P_Re) + (G2_P_Im)*j    % combine real, imaginary parts
den_zpkG2c = zpk(G2_Z, G2c_P, G2_K) % make zpk filter for denominator
den_tfG2c = tf(den_zpkG2c)          % convert to standard transfer function

%% extract a and b for 2c (3)
G2c_den_poly = den_tfG2c.Denominator{:}
G_a(i_part,3) = G2c_den_poly(2)
G_b(i_part,3) = G2c_den_poly(3)
