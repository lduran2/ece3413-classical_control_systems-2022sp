%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part0103_imags.m
% Calculates the parameters of a transfer function, modifying the
% imaginary part.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-18t02:30R
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-03-18t02:30R
%       completed part part 01.03

clear

%% part 3a.

%% parameters of G3(s; a, b) = b/(s^2 + as + b)
a = 4
b = 25

%% transfer function G3(s; a, b)
tfG3 = tf([b], [1 a b])

%% find as ZPK function
zpkG3 = zpk(tfG3)                   % convert to ZPK form
G3_Z = [ zpkG3.Z{:} ]               % original zeros
G3_P = [ zpkG3.P{:} ]               % original poles
G3_K = zpkG3.K                      % original gain

%% find pole parts
G3_P_Re = real(G3_P)                % real parts of poles
G3_P_Im = imag(G3_P)                % imaginary parts of poles

%% 3d.) imaginary part is increased two times over that of task 2a
G3d_P_Im = 2*G3_P_Im                % double real part
G3d_P = (G3_P_Re) + (G3d_P_Im)*j    % combine real, imaginary parts
zpkG3d = zpk(G3_Z, G3d_P, G3_K)     % make zpk filter
tfG3d = tf(zpkG3d)                  % convert to standard transfer function

%% extract a and b for 3d
G3d_den_poly = tfG3d.Denominator{:}
G3d_P_a = G3d_den_poly(2)
G3d_P_b = G3d_den_poly(3)

%% 3e.) imaginary part is increased four times over that of task 2a
G3e_P_Im = 4*G3_P_Im                % double real part
G3e_P = (G3_P_Re) + (G3e_P_Im)*j    % combine real, imaginary parts
zpkG3e = zpk(G3_Z, G3e_P, G3_K)     % make zpk filter
tfG3e = tf(zpkG3e)                  % convert to standard transfer function

%% extract a and b for 3e
G3e_den_poly = tfG3e.Denominator{:}
G3e_P_a = G3e_den_poly(2)
G3e_P_b = G3e_den_poly(3)
