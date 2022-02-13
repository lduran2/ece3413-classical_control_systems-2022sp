% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lib/find_ceil.m
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
