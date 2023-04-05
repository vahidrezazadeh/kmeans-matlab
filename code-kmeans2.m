%%%%%%%%%%%%%%%%%%%% Initialize Work Space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%% Definition Matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
x1=imread('1.jpg');
%x1=rgb2gray(x1);
x=imresize(x1,[300,300]);
%x=histeq(x,4);
%%
%%%%%%%%%%%%%%%%%%%%%random weight%%%%%%%%%%%%%%%%%%%%
%x=imnoise(x,'salt & pepper',.25);
imshow(x);
%x=imnoise(x,'gaussian',.1,0.01);
x=double(x);
 [m,n]=size(x);
len=m;

k=2;
m=zeros(k,1);
mm=zeros(k,2);


for i=1:k
    m(i,1)=x(randi(len-1),randi(len-1));
end

x(:,:,3)=0;
x2=x;

temp=zeros(1,k);
s=0;
epoch=0;
while s==0
    epoch=epoch+1;
    for i=1 :len
        for i2=1 :len
        for j=1:k
            temp(j)=sqrt(abs(m(j,1)-x(i,i2))^2);
        end
        z1=find(temp==min(temp));
        x(i,i2,3)=z1(1);
        end
    end
    %%%%%%%%%%%%%%%%%mohasebe jame har cluster va tedad an %%%%%%%%%%%%%%%%%%%%%%
    for i=1:len
        for i2=1:len
            mm(x(i,i2,3),1)=mm(x(i,i2,3),1)+x(i,i2);
            %calculet the numeber of pixle in each cluster
            mm(x(i,i2,3),2)=mm(x(i,i2,3),2)+1; 
        end
    end
    for l=1:k
        m(l,1)=mm(l,1)/mm(l,2);
    end
    
    
       
    if(x==x2)
        s=1;
    else
        x2=x;
    end
    
end

for i=1:len
    for i2=1:len
        x2(i,i2)=x(i,i2,3)*50;
    end
end
x2(:,:,2:3)=[];
figure
imshow(uint8(x2));