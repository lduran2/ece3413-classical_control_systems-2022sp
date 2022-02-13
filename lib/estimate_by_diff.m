% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lib/estimate_by_diff.m
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-12t19:55R
% For       : ECE 3413
% Version   : 1.2.6
%
% CHANGELOG :
%   v1.2.6 - 2022-02-12t19:55R
%       separated to m-file
%
%   v1.2.5 - 2022-02-12t19:40R
%       use offset for `find_ceil`
%       fixed echos
%
%   v1.2.4 - 2022-02-12t17:06R
%       abstracted `find_ceil` and `estimate_by_diff` from `lab03`
%
%   v1.2.3 - 2022-02-12t18:29R
%       corrected rise time by difference

%% estimate_by_diff
% Estimate the correct input from the difference from expected output.
% @param op          = vector of outputs
% @param index       = index of measured output
% @param op_expected = the expected output
% @param ip_measured = the input corresponding to the measured output
% @param delta_ip    = the consistent step in input
function est = estimate_by_diff(op_expected, op, index, ip_measured, delta_ip)
    % delta of input
    delta_op = (op(index) - op(index - 1));
    % difference at index from expected
    op_diff = (op_expected - op(index));
    % use (y - y0) = dy/dx*(x - x0)
    est = (delta_ip/delta_op)*(op_diff) + ip_measured;
end % function estimate_by_diff(v, index, op_expected, ip_measured)
