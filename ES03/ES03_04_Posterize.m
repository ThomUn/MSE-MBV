clear all;

%%
IM=imread('room.jpg');

subplot(2,2,1);
imshow(IM);
title 'original image'

subplot(2,2,2);
imshow(posterize(IM, 10));
title 'posterized image'

subplot(2,2,3);
imhist(IM);
title 'original image histogram'

subplot(2,2,4);
IM_P = posterize(IM);
imhist(IM_P);
title 'posterized image histogram'

function post = posterize(IM, levels) 
    if ~exist('levels')
      levels = 3;
    end
    [m n r]=size(IM);
    IM=double(IM);
    for(i=1:m)
        for(j=1:n)
            for(k=1:3)
                IM(i,j,k)=(round((IM(i,j,k)/255)*levels)*255/levels);
            end
        end
    end
    post=uint8(IM);
end