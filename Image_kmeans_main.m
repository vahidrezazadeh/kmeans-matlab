%% K-MEANS CLUSTERING TECHNIQUE FOR IMAGE COMPRESSION.
% Author: Vinay Kumar, Email: tadepalli.vinay@gmail.com
% Goals:-> To compress an Image Memory Footprint on the disk by trading off
% with Image quality.
% Tools:-> K-means clustering Algorithm.
% Inputs:-> Gray-Scale and Color Images, both. :)
%--------------------------------------------------------------------------
clc;
clear all;
close all;
tic; % tic-toc combination is used to find out the program execution time. 
% place the "tic" at the beginning of the program and "toc" at the end of
% the program.
%--------------------------------------------------------------------------
% Read the input parameteres L, K. (Info. about them in the following code :))
L=input('Enter the block size dimension(L):');
K=input('Enter the Codebook size (K):');
%--------------------------------------------------------------------------
% Read the Input Image
Img=imread('Lena.jpg');
Img2D_rows=size(Img,1);
Img2D_cols=size(Img,2);
figure, imshow(Img)
title('Input Image');
%--------------------------------------------------------------------------
%% Checking whether input image is a gray-scale or colour image and
%% implementing k-means for 3 components (R,G,B)if it is a color image.
r1=rem(Img2D_rows,sqrt(L));
r2=rem(Img2D_cols,sqrt(L));
Img1=zeros(Img2D_rows+r1,Img2D_cols+r2);
if length(size(Img))==3
	 for i=1:3
        % -----------------------------------------------------------------
        % The condition instructions below is to check for the dimensions of the
        % image and pad the rows/columns accordingly.
        Img1(1:Img2D_rows,1:Img2D_cols)=Img(:,:,i);
        if r1~=0
            Pad_rows=Img(end,:,i);
            for j=1:r1
                Pad_rows(j,:)=Pad_rows(1,:);
            end
            Img1(Img2D_rows+1:end,1:Img2D_cols)=Pad_rows;
        end
        if r1~=0 && r2~=0
            Pad_cols=Img1(:,Img2D_cols);
            for j=1:r2
                Pad_cols(:,j)=Pad_cols(:,1);
            end
            Img1(1:end,Img2D_cols+1:end)=Pad_cols;
        elseif r2~=0
            Pad_cols=Img(:,Img2D_cols);
            for j=1:sqrt(L)-r2
                Pad_cols(:,j)=Pad_cols(:,1);
            end
            Img1(1:Img2D_rows,Img2D_cols+1:end)=Pad_cols;
        end
        % -----------------------------------------------------------------
        if i==1
            I_re=zeros(size(Img1,1),size(Img1,2),3);
        end
        I_re(:,:,i)=Kmeans_Pre_Post(Img1,L,K);  % Kmeans_Pre_Post is a function for re-arranging 
		% the pixels the image into Input vectors to be used for k-means
		% clustering and reconstructing the Image from the Output Vectors.
   end
    I_re=I_re(1:end-r1,1:end-r2,1:3);
else
    % ---------------------------------------------------------------------
    % The "if-elseif-end" condition below is to check for the dimensions of the
    % image and pad the rows/columns accordingly.
    Img1(1:Img2D_rows,1:Img2D_cols)=Img;
    if r1~=0
      Pad_rows=Img(end,:);
      for j=1:r1
          Pad_rows(j,:)=Pad_rows(1,:);
      end
      Img1(1:Img2D_rows,1:Img2D_cols)=Img;
      Img1(Img2D_rows+1:end,1:Img2D_cols)=Pad_rows;
    end
    if r1~=0 && r2~=0
      Pad_cols=Img1(:,Img2D_cols);
      for j=1:r2
          Pad_cols(:,j)=Pad_cols(:,1);
      end
      Img1(1:end,Img2D_cols+1:end)=Pad_cols;
    elseif r2~=0
      Pad_cols=Img(:,Img2D_cols);
      for j=1:sqrt(L)-r2
          Pad_cols(:,j)=Pad_cols(:,1);
      end
      Img1(1:Img2D_rows,1:Img2D_cols)=Img;
      Img1(1:Img2D_rows,Img2D_cols+1:end)=Pad_cols;
    end
    % ---------------------------------------------------------------------
    I_re=Kmeans_Pre_Post(Img1,L,K);
end
%--------------------------------------------------------------------------
% Displaying the K-MEANS clustered Image.
I_re=uint8(I_re);
figure, imshow(I_re);
title('Image with K-MEANS')
%--------------------------------------------------------------------------
% Displaying the memory occupied by Input and Output Images.
fprintf('Input Image Memory Size = %d bytes',numel(Img));
disp(' ');
fprintf('Output Image Memory Size = %d bytes',K*L+numel(Img1)/L);
disp(' ');
%--------------------------------------------------------------------------
% Clearing the temporary variables.
clear Img1; 
%--------------------------------------------------------------------------
% "toc" command used for calculating program execution time.
toc;