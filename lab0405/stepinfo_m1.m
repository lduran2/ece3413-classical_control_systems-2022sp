% https://github.com/lduran2/ece3413_classical_control_systems/lab0405/stepinfo_m1.m
%
% Finds the roots of various polynomials.
% By        : Leomar Duran <https://github.com/lduran2>
% When      : 2022-02-08t11:39R
% For       : ECE 3413
% Version   : 1.0.0
%
% CHANGELOG :
%   v1.0.0 - 2022-02-08t11:39R
%       found stepinfo parameters for G1(s; a)

syms s

% for a in (1..4)
as = 1:4
textable = '';
for a=as
    % display a
    disp(join(['%%%% a =' string(a) '%%%%']))
    % G1(s; a) := a/(s + a).
    B = [a]
    A = [1 a]
    G1_s = tf(B, A)

    % display settling time, rise time and peak time for G1(s; a)
    G1_s_step = stepinfo(G1_s);
    SettlingTime = G1_s_step.SettlingTime
    RiseTime = G1_s_step.RiseTime
    PeakTime = G1_s_step.PeakTime

    % generate LaTeX table
    G1_s_sym = poly2sym(B,s)/poly2sym(A,s)
    textable = sprintf('%s\t%d', textable, a);
    textable = sprintf('%s & %s', textable, latex(G1_s_sym));
    textable = sprintf('%s & %d', textable, SettlingTime);
    textable = sprintf('%s & %d', textable, RiseTime);
    textable = sprintf('%s & %d', textable, PeakTime);
    textable = sprintf( ...
        join(['%s & \\includegraphic[width=\\lineheight]' ...
            '{figures/g1-s-%d.eps}\\\\*\n' ]), ...
        textable, a);
    
    
    % find the step response
    [y, t] = step(G1_s);
    % plot the result
    figure
    plot(y, t)
    title(join(['Step response of G_1 for a =' string(a)]))
    xlabel('time, t [s]')
    ylabel('amplitude, G_1(s; a)')
end % for a

disp(textable)