% Canonical https://github.com/lduran2/ece3413_classical_control_systems/lab03-lti_systems/part02_transfer_fnc_analysis_m1.m
% Automates simultion of various transfer functions
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-12t14:45R
% For       : ECE 3413
% Version   : 1.1.1
%
% CHANGELOG :
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

%% constants
tsim = 10.0; % [s] simulation time

%% name of the simulation
word_delim = '_';           % part delimiter in filenames
sim_suffix = 'slx1.slx';    % common suffix for simulation files
% split words by delimiter
source_words = split(mfilename, word_delim)
% remove the last word and rejoin by '_'
source_base_cell = join({source_words{1:end-1}}, word_delim)
% break out of cell and add simulation suffix
sim_source = [ source_base_cell{:} word_delim sim_suffix ]

%% transfer function
B = [2];        % the numerator
A = [1 5 9];    % the denominator

% generate the transfer function
Ga_s = tf(B,A)

% run the simulation
sim(sim_source)

% display finished
disp('Done.')