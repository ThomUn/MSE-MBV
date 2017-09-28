clear all
%%Create arrays with N = 8, 16, 256
t1 = linspace(-2*pi, 2*pi, 8);
t2 = linspace(-2*pi, 2*pi, 16);
t3 = linspace(-2*pi, 2*pi, 512);
t = [linspace(-2*pi, 2*pi, 8),linspace(-2*pi, 2*pi, 16),linspace(-2*pi, 2*pi, 512)];

%%Shift arrays according to exercise
shifted_t1 = circshift(t1,-4,2);
shifted_t2 = circshift(t2,-8,2);
shifted_t3 = circshift(t3,-256,2);

%%Transpose arrays
transposed_t1 = transpose(t1);
transposed_t2 = transpose(t2);
transposed_t3 = transpose(t3);

%%Do a horizontal concatination of the array and the shifted array
horzconcat_t1 = horzcat(t1, shifted_t1);
horzconcat_t2 = horzcat(t2, shifted_t2);
horzconcat_t3 = horzcat(t3, shifted_t3);

%%Do a vertical concatination of the array and the shifted array
vertconcat_t1 = vertcat(t1, shifted_t1);
vertconcat_t2 = vertcat(t2, shifted_t2);
vertconcat_t3 = vertcat(t3, shifted_t3);