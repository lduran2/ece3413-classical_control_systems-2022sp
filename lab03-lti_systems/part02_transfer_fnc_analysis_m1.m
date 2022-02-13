% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lab03-lti_systems/part02_transfer_fnc_analysis_m1.m
% Automates simultion of various transfer functions
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-12t21:34R
% For       : ECE 3413
% Version   : 1.4.1
%
% CHANGELOG :
%   v1.4.1 - 2022-02-12t21:34R
%       using vectors for analysis outputs, instead of cells
%
%   v1.4.0 - 2022-02-12t21:27R
%       storing analysis outputs
%
%   v1.3.2 - 2022-02-12t21:12R
%       label generated figures
%
%   v1.3.1 - 2022-02-12t21:01R
%       all tfs analyzed with has_overshoot
%
%   v1.3.0-alpha03 - 2022-02-12t20:53R
%       fixed looping through tfs, subscripts
%
%   v1.3.0-alpha02 - 2022-02-12t20:47R
%       analyze_filter function
%
%   v1.3.0-alpha00 - 2022-02-12t20:30R
%       multiple transport functions
%
%   v1.2.7 - 2022-02-12t20:18R
%       found the steady state error
%
%   v1.2.6 - 2022-02-12t20:16R
%       found the percent overshoot
%
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
global SYS_DELIM  N_SCOPE  FIG_DIR
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

%% transfer functions
transfer_fncs = {
    [2], [ 1 5 9 ];
    [5], [ 1 9 9 ];
    [9], [ 1 0 9 ];
    [7], [ 1 6 9 ]
}
Ntfs = size(transfer_fncs, 1)   % number of transfer functions

%% analysis outputs
Tks = zeros(Ntfs, 1);   % [s] peak times
Tss = zeros(Ntfs, 1);   % [s] settling times
Trs = zeros(Ntfs, 1);   % [s] rise times
pcOSs = zeros(Ntfs, 1); % [%] overshoot rates
Esss = zeros(Ntfs, 1);  % <1> steady state errors

%% analyze each transfer function
% loop through the transfer functions
for iG=1:Ntfs
    % get the coefficients at row iG
    % B := the numerator
    % A := the denominator
    [B, A] = transfer_fncs{iG, :}
    % calculate the subscript
    sbx = ('a' + iG - 1)
    % analyze the filter given by iG
    [ Tks(iG), Tss(iG), Trs(iG), pcOSs(iG), Esss(iG) ] = ...
        analyze_filter(sbx, sim_name, sim_source);
end % for iG

table(Tks, Tss, Trs, pcOSs, Esss)

%% display finished
disp('Done.')

%% analyze_filter
function [Tk, Ts, Tr, pcOS, Ess] = ...
        analyze_filter(sbx, sim_name, sim_source)
    %% constants
    global SYS_DELIM  N_SCOPE  FIG_DIR

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
    fig_path = [ FIG_DIR '/gen_G' sbx '_s.png' ]
    saveas(hTgt, fig_path)
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
    % some filters do not have overshoot, for example Gb(s)

    % if K is not the last index, we have an overshoot
    has_overshoot = (K ~= n_samp)

    % if overshoot
    if (has_overshoot)
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
    else    % if (has_overshoot)
        % otherwise
        % settling time IS peak time
        Ts = Tk
        % max{y} is the final value
        y_final = Y
    end     % if (has_overshoot)

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

    %% find percent overshoot, %OS
    pcOS = (Y - y_final)/y_final * 100 % [%]

    %% find steady state error
    Ess = 1 - y_final
end % function analyze_filter(B, A, sbx)