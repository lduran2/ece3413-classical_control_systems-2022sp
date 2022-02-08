%% Part I. Step Response
% load time and data from 'out.mat'
data = load('out.mat')
t1 = data.ans.Time;
y2 = data.ans.Data;

% plot data vs time
figure
plot(t1,y2)
title('step response, h')
xlabel('time, t [s]')
ylabel('conductance, h(t) [\Omega^{-1}]')

%% Part II. Sinusoidal Response
t2 = 0:0.001:10;
y2 = 0.5*sin(t2) + 0.3;

% construct timeseries to save
ts2 = timeseries(t2, y2)
save input.mat -v7.3 ts2
