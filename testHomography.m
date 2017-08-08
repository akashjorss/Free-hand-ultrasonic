load('C:\Users\Laser\Desktop\0621\data\H.mat');
load('C:\Users\Laser\Desktop\0621\data\d.mat');
% d = permute(d,[2 1 3]);
PI = zeros(380,300,400);
for i=1:400
% t = maketform('projective',H(:,:,i));
% PI(:,:,i) = imtransform(squeeze(d(:,:,i)),t);    
    for j = 1:300
        for k = 1:380
           X = H(:,:,i)*d(j,k,i);
           if(abs(floor(X(1))) < 380 && abs(floor(X(1))) > 0 && abs(floor(X(2))) < 300 && abs(floor(X(2))) > 0)
               PI(abs(floor(X(1))),abs(floor(X(2))),i) = d(j,k,i);     
           end
        end
    end
end
imshow(d(:,:,100),[])
imshow(PI(:,:,100),[]);