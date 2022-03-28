%% sys2sym(sys)
% Canonical : https://github.com/lduran2/ece3413_classical_control_systems/lib/sys2sym.m
% Converts a given matrix of systems into a matrix of symbolic
% equations.
% @params sys = the matrix systems
% @return array of symbolic equations representing the given systems
%
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-03-18t13:37Q
% For       : ECE 3412
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-03-18t13:37Q
%       initial version
function sym = sys2sym(sys)
    % get the numerator and denominator data from the system
    [numcell, dencell] = tfdata(sys);
    % combine to an array
    frac_parts = { numcell, dencell };
    % in terms of s, convert each fraction cell to symbolic
    syms s
    % for each (part) of numerator, denominator
    frac_sym = cellfun(@(part) ...
        ... for part (ofsys) of each system
        cellfun(@(ofsys) poly2sym(ofsys, s), part), ...
        frac_parts, 'UniformOutput', false);
    % divide for the symbolic equation
    sym = frac_sym{1}./frac_sym{2};
end % function sym = sys2sym(sys)
