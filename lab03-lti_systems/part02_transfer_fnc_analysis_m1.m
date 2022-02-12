% Canonical https://github.com/lduran2/ece3413_classical_control_systems/lab03-lti_systems/part02_transfer_fnc_analysis_m1.m
% Automates simultion of various transfer functions
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-12t14:11R
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-02-12t14:11R
%       generated transfer function
%
%   v0.0.0 - 2022-02-12t14:07R
%       hello world

%% transfer function
B = [2];        % the numerator
A = [1 5 9];    % the denominator

Ga_s = tf(B,A)

% display finished
disp('Done.')