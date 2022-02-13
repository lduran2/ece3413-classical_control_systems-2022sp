% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lib/find_value.m
% Functions for finding an expected value in a vector.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-12t19:40R
% For       : ECE 3413
% Version   : 1.2.5
%
% CHANGELOG :
%   v1.2.5 - 2022-02-12t19:40R
%       use offset for `find_ceil`
%       fixed echos
%
%   v1.2.4 - 2022-02-12t17:06R
%       abstracted `find_ceil` and `estimate_by_diff` from `lab03`
%
%   v1.2.3 - 2022-02-12t18:29R
%       corrected rise time by difference

%% find_ceil
% Returns the ceiling index of the given key in the N-element vector
% starting from offset off.
% @param v   = vector to search
% @param off = offset at which to start searching
% @param N   = length of vector
% @param key = for which to search
% returns the index of the first element greater than or equal to the
% given key.
function index = find_ceil(v, off, N, key)
    % for each sample
    for k=off:N
        % stop if 10%ile
        if (v(k) >= key)
            break
        end % if (v(k) >= key)
    end % for k
end % function find_ceil(v, off, N, key)

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
