% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab03-lti_systems/part02_transfer_fnc_analysis_m1.m
% Automates simultion of various transfer functions
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-12t17:01R
% For       : ECE 3413
% Version   : 1.1.4
%
% CHANGELOG :
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
mkdir('fig')
saveas(hTgt, [ FIG_DIR '/Ga_s.png' ])
% close the target
close(hTgt)

% close the scope
close_system(nScopeSys)

%% get the data and time
y = out.simout.data;
t = out.simout.time;

%% display finished
disp('Done.')
