% Part II
% load time and data from 'out.mat'
data = load('out.mat');
t = data.ans.Time;
y = data.ans.Data;

% plot data vs time
figure
plot(t,y)
title('step response, h')
xlabel('time, t [s]')
ylabel('conductance, h(t) [\Omega^{-1}]')
