%read image
%imshow
%im = rgb2grey();
IM = imread('ES03/room.jpg');
IM = rgb2gray(IM); 
%itf = uint8(255:-1:0);
plot(itf);
%imshow(itf(IM+1));



%imhist(IM);
[x,n] = imhist(IM);
cum_hist = cumsum(x)/numel(IM);

%plot(n,x);
%hold on
%plot(n, cumsum(x)/numel(itf(IM+1)));

%plot(cum_hist);
imshow(applyITF(IM, cum_hist));

%plot(cumsum(x)/numel(IM));
function image = applyITF(image, itf)
    image = itf(image+1);
end

function window = window(center, width)

end
%gamma(rho, center, width) %the latter two arguments are optional
%sigmoid(center, width)
%applyITF(image, itf)