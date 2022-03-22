%%
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab0405-time_responses/part0103_imags_m1.m
% Calculates the parameters of a transfer function, modifying the
% imaginary part.
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
%   v1.0.2 - 2022-03-18t04:12Q
%       a, b output shorter names
%
%   v1.0.1 - 2022-03-18t04:00Q
%       added _m1 suffix
%
%   v1.0.0 - 2022-03-18t02:30Q
%       completed part part 01.03

%% part 3a.
i_part = 3

%% parameters of G3(s; a, b) = b/(s^2 + as + b)
a = 4
b = 25

%% transfer function G3(s; a, b)
tfG{i_part,1} = tf([b], [1 a b])

%% number of transfer functions
n_tfG(i_part) = 3

%% find as ZPK function
zpkG3 = zpk(tfG{i_part,1})          % convert to ZPK form
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

%% extract a and b for 3d (2)
G3d_den_poly = tfG3d.Denominator{:}
G_a(i_part,2) = G3d_den_poly(2)
G_b(i_part,2) = G3d_den_poly(3)

%% 3e.) imaginary part is increased four times over that of task 2a
G3e_P_Im = 4*G3_P_Im                % double real part
G3e_P = (G3_P_Re) + (G3e_P_Im)*j    % combine real, imaginary parts
zpkG3e = zpk(G3_Z, G3e_P, G3_K)     % make zpk filter
tfG3e = tf(zpkG3e)                  % convert to standard transfer function

%% extract a and b for 3e (3)
G3e_den_poly = tfG3e.Denominator{:}
G_a(i_part,3) = G3e_den_poly(2)
G_b(i_part,3) = G3e_den_poly(3)
