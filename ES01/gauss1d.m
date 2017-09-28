%% Write a function gauss1d(x, sigma)
function [ y ] = gauss1d( x, sigma )
    y = (1 / (sqrt(2*pi*sigma)))*exp(-((x.^2)/(2*(sigma.^2))));
end
