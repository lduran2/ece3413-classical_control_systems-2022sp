% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab03-lti_systems/part02_transfer_fnc_analysis_m1.m
% Automates simultion of various transfer functions
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-12t18:29R
% For       : ECE 3413
% Version   : 1.2.3
%
% CHANGELOG :
%   v1.2.4 - 2022-02-12t19:38R
%       abstracted `find_ceil` and `estimate_by_diff` to
%           `/lib/find_value.m`
%
%   v1.2.3 - 2022-02-12t18:29R
%       corrected rise time by difference
%
%   v1.2.2 - 2022-02-12t17:58R
%       found the rise time
%
%   v1.2.1 - 2022-02-12t17:39R
%       found settling time
%
%   v1.2.0 - 2022-02-12t17:22R
%       found peak time
%
%   v1.1.4 - 2022-02-12t17:01R
%       closing the target and scope
%
%   v1.1.3 - 2022-02-12t16:45R
%       copying the scope
%
%   v1.1.2 - 2022-02-12t15:08R
%       plotting simulation data
%
%   v1.1.1 - 2022-02-12t14:45R
%       running simulation
%
%   v1.1.0 - 2022-02-12t14:43R
%       create the simulation name
%
%   v1.0.0 - 2022-02-12t14:11R
%       generated transfer function
%
%   v0.0.0 - 2022-02-12t14:07R
%       hello world

clear;
addpath('../lib')   % for find_ceil, estimate_by_diff

%% parameters
TSIM = 10.0; % [s] simulation time

%% model constants
WORD_DELIM = '_';           % part delimiter in filenames
SIM_SUFFIX = 'slx1';        % common suffix for simulations
FILE_SUFFIX = '.slx';       % suffix for the simulation files
SYS_DELIM = '/';            % delimiter for block levels
N_SCOPE = 'Scope';          % the name of the scope

%% output constants
FIG_DIR = '../doc/lab03/fig';   % directory to where figures are saved

%% name of the simulation
% split words by delimiter
source_words = split(mfilename, WORD_DELIM)
% remove the last word and rejoin by '_'
source_base_cell = join({source_words{1:end-1}}, WORD_DELIM)
% break out of cell and add suffixes
sim_name = [ source_base_cell{:} WORD_DELIM SIM_SUFFIX ]
sim_source = [ sim_name FILE_SUFFIX ]

%% transfer function
B = [2];        % the numerator
A = [1 5 9];    % the denominator

% generate the transfer function
Ga_s = tf(B,A)

%% run the simulation
out = sim(sim_source)

%% save the scope image
% open the scope
nScopeSys = [ sim_name SYS_DELIM N_SCOPE ]
open_system(nScopeSys)
% get the scope handle
hScope = findall(0, 'Name', N_SCOPE)
% get a handle for the source plot (opened by `open_system`)
hSrc = findobj(hScope.UserData.Parent, 'Tag', 'VisualizationPanel')
% create the target figure
hTgt = figure;
% do not invert the background in target
set(hTgt, 'InvertHardCopy', 'off')
% copy to target for saving
copyobj(hSrc, hTgt)
% save the result
saveas(hTgt, [ FIG_DIR '/Ga_s.png' ])
% close the target
close(hTgt)

% close the scope
close_system(nScopeSys)

%% get the data and time
y = out.simout.data;
t = out.simout.time;
n_samp = size(y, 1)     % number of samples
delta_t = t(2) - t(1)   % delta of time samples

%% find peak time, Tk
% this is the time that y reaches its max
% get the max and its index
[Y, K] = max(y)
% the corresponding time is peak time
Tk = t(K)   % [s]

%% find settling time, Ts
% this is the time that y is within 5% of the remaining mean
% for each sample
for ks=(K+1):n_samp
    % find the mean of y's from k
    Ey = mean(y(ks:n_samp));
    % stop if y(k) is within 5% of E[y]
    if (abs(y(ks) - Ey) < (0.05 * Ey))
        break
    end % if (abs(y(k) - Ey) < (0.05 * Ey))
end % for ks=1:n_samp
% the corresponding time is settling time
Ts = t(ks)
% save Ey as the final value of y
y_final = Ey

%% find rise time, Tr
y10_exp = 0.1*y_final   % expected 10%ile
y90_exp = 0.9*y_final   % expected 90%ile

% find the indices of each %ile
k10 = find_ceil(y, 1,   n_samp, y10_exp)
k90 = find_ceil(y, k10, n_samp, y90_exp)

% display corresponding measured times
t10_meas = t(k10)
t90_meas = t(k90)

% corresponding y(k)'s are a little high
% estimate the proper values
t10 = estimate_by_diff(y10_exp, y, k10, t10_meas, delta_t)
t90 = estimate_by_diff(y90_exp, y, k90, t90_meas, delta_t)

% the corresponding time difference is the rise time
Tr = t90 - t10

% percent overshoot,
% steady state error

%% display finished
disp('Done.')
