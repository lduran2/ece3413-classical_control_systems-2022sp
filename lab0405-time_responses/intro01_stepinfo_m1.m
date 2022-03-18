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
tex_table = '';
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

    % find the step response
    [y, t] = step(G1_s);
    % plot the result
    fig = figure
    plot(y, t)
    title(join(['Step response of G_1 for a =' string(a)]))
    xlabel('time, t [s]')
    ylabel('amplitude, G_1(s; a)')

    % create figure name
    figname = sprintf('fig/g1-s-%d.', a);

    % generate LaTeX table
    G1_s_sym = poly2sym(B,s)/poly2sym(A,s)
    tex_table = sprintf('%s\t%d', tex_table, a);
    tex_table = sprintf('%s & %s', tex_table, latex(G1_s_sym));
    tex_table = sprintf('%s & %d', tex_table, SettlingTime);
    tex_table = sprintf('%s & %d', tex_table, RiseTime);
    tex_table = sprintf('%s & %d', tex_table, PeakTime);
    tex_table = sprintf( ...
        join([ ...
            '%s & \\includegraphic[width=\\lineheight]' ...
            '{%seps}\\\\*\n' ...
        ]), ...
        tex_table, figname);
    % end sprintf
    
    % save the figure data
    saveas(fig, sprintf('%sfig', figname));
    % save the figure image
    saveas(fig, sprintf('../doc/lab0405/%seps', figname));
end % for a

% add the tabular environment and headers
tex_table = sprintf(join([ ...
    '\\begin{tabular}{@{}*2l*3Sl@{}}\n' ...
    '\t\\toprule\n' ...
    '\t \\(a\\) & transfer function \\(G_1(s; a)\\) & Setting Time \\(T_s \\brac{\\si\\second}\\) & Rising Time \\(T_r \\brac{\\si\\second}\\) & Peak Time \\(T_p \\brac{\\si\\second}\\) & \\\\*\n' ...
    '\t\\midrule\n' ...
    '%s' ...
    '\t\\bottomrule\n' ...
    '\\end{tabular}'
]), tex_table)

% save the table
table_out = fopen('../doc/lab0405/g1-table','w');
fprintf(table_out, '%s', tex_table);
fclose(table_out);