clear

%random
R=randi([0,255],256,256);

for i=1:253
    for j=1:253
        d8r=[R(i,j),R(i,j+1),R(i,j+2),R(i+1,j),R(i+1,j+2),R(i+2,j),R(i+2,j+1),R(i+2,j+2)];
        
        d8r_bin=reshape(dec2bin(d8r, 8).'-'0',8,[]);
        for k=1:7
            error_r(i,j,k)=error_rt8apx2(d8r_bin(k,:),d8r_bin(k+1,:));
        end
    end
end

% bb er
sum(sum(sum(error_r>0)))/(253*253*6)
% bb ED>1
% stall
sum(sum(sum(error_r>1,3)>0))/(253*253)

%avg
%I=im3(:,:,1);
%absdiff
%absdiff=imabsdiff(im3(:,:,1),im5(:,:,1));
%gaussian filter
%[1,3,1, 3,0,3, 1,3,1]

%error=zeros(1000,1000,7);

% im3=imread('image/office_3.jpg');
% im5=imread('image/office_5.jpg');

I = imread('cameraman.tif');

%absdiff=im3(:,:,1);
%absdiff_1=absdiff(:,:,1);


for i=1:253
    for j=1:253
        
        
        % gaussian filter
        d8g=[I(i,j)/2,I(i,j+1),I(i,j+2)/2,I(i+1,j),I(i+1,j+2),I(i+2,j)/2,I(i+2,j+1),I(i+2,j+2)/2];
        
        d8g_bin=reshape(dec2bin(d8g, 8).'-'0',8,[]);
        for k=1:7
            error_g(i,j,k)=error_rt8apx2(d8g_bin(k,:),d8g_bin(k+1,:));
        end
        
        % avg
        d8a=[I(i,j),I(i,j+1),I(i,j+2),I(i+1,j),I(i+1,j+2),I(i+2,j),I(i+2,j+1),I(i+2,j+2)];
        
        d8a_bin=reshape(dec2bin(d8a, 8).'-'0',8,[]);
        for k=1:7
            error_a(i,j,k)=error_rt8apx2(d8a_bin(k,:),d8a_bin(k+1,:));
        end
        
        
    end
end
        
