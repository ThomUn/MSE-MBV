%% 2D matrix with values between 1 and 500 and 100x100
clear all;
m = randi([1 500],100);

%%calculate and print
sumOfRows = sum(m,2);
sumOfColumns = sum(m);
meanOfRows = mean(m,2);
meanOfColumns = mean(m);
countOfValuesSmaller50 = sum(m < 50, 2);
meanOfValuesSmaller50 = mean(m<50,2);

%% substitute all values below a threshhold with a different value
oldM = m;
m (m<30)=0;

%% transpose the matrix
transposedMatrix = m';

%% reshape to a 2xn matrix
reshaped = reshape(m,2,[]);

%% add random noise to the data
m_noise = m * rand(100);

%% create a neat plot of all calculated values
hold on;
plot(sumOfRows,'b');
plot(sumOfColumns,'r');
plot(meanOfRows,'y');
plot(meanOfColumns,'g');
plot(countOfValuesSmaller50,'c');
plot(meanOfValuesSmaller50,'k');
plot(m, 'g');
plot(transposedMatrix);
plot(reshaped, 'b');
plot(m_noise, 'r');
hold off;
legend('sumOfRows', 'sumOfColumns', 'meanOfRows', 'meanOfColumns', 'countOfValuesSmaller50', 'meanOfValuesSmaller50', 'm', 'transposedMatrix');
