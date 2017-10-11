%%Create figure 1
figure(1)
subplot(2,2,1)
x = (-10:0.02:10);
hold on

%% Show different variations of subplots
plot(x, gauss1d(x, 1))
grid minor
ylabel('gauss1d')
title('sigma=1')
hold on

subplot(2,2,2)
plot(x, gauss1d(x, 3))
grid minor
ylabel('gauss1d')
title('sigma=3')
hold on

subplot(2,2,3)
plot(x, gauss1d(x, 6))
grid minor
ylabel('gauss1d')
title('sigma=6')
hold on

%% Show all graphs in one subplot
subplot(2,2,4)
plot(x, gauss1d(x, 0.1), 'black', x, gauss1d(x, 1), 'red', x, gauss1d(x, 3), 'blue', x, gauss1d(x, 6), 'green')
grid minor
ylabel('gauss1d')
title('all together')
legend('sigma=0.1','sigma=1', 'sigma=3', 'sigma=6')