clear all
%%base = linspace(-2*pi, 2*pi, 1);
%%t1 = linspace(-2*pi, 2*pi, 8);
%%t2 = linspace(-2*pi, 2*pi, 16);
%%t3 = linspace(-2*pi, 2*pi, 512);

t = [linspace(-2*pi, 2*pi, 8),linspace(-2*pi, 2*pi, 16),linspace(-2*pi, 2*pi, 512)];
%%Plot figure 1
figure(1)
hold on 
grid on
grid minor
plot(t(1:8), sin((t(1:8))), 'g');
plot(t(9:24), sin((t(9:24))), 'b');
plot(t(25:end), sin((t(25:end))), 'r');
hold off

%%Reset negative values with same positive value
logicalT = logical(t<0);
t(logicalT) = t(logicalT) * -1;

%%Plot figure 2
figure(2)
hold on
plot(t(1:8), sin((t(1:8))), 'g');
plot(t(9:24), sin((t(9:24))), 'b');
plot(t(25:end), sin((t(25:end))), 'r');
hold off
