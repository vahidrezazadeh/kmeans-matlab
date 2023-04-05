function[I_re]=Kmeans_Pre_Post(I1,L,K)
%% Creating L-dimension vectors from the Image.
% L is the block-sizes used for clustering technique, but re-arranged in array form.   
% For an Image, L is an integer power of 4.(L=4=>2x2,16=>4x4,64... so on)
% Technically, the block sizes can be anything starting from 1x2, but
% generally, only square block sizes are used. Therefore, my code is
% applicable only for square block sizes (2x2, 4x4,... so on).
% K is the Codebook Size.The larger K is, the more time it takes for
% processing. :)
%--------------------------------------------------------------------------     
% Re-arranging the input image pixel values from matrix form to an array
% form to be stored in "s" cell of arrays.
s=cell(1,numel(I1)/L);
I1_rows=size(I1,1);
for j=1:length(s) 
  for i=1:sqrt(L)
    s{j}=[s{j},I1((i+floor((j-1)*sqrt(L)/I1_rows)*sqrt(L)-1)*I1_rows+1+rem(j-1,I1_rows/sqrt(L))*sqrt(L):(i+floor((j-1)*sqrt(L)/I1_rows)*sqrt(L)-1)*I1_rows+(rem(j-1,I1_rows/sqrt(L))+1)*sqrt(L))];
  end
end
%--------------------------------------------------------------------------
% Calling the actual kmeans_clustering function with the supplied
% parameters.
[codebook,ClusterNum]=kmeans_clustering(s,L,K);
%--------------------------------------------------------------------------
% Reconstructing the Image using the Codebook vectors (Cluster Centres).
s_re=cell(1,length(s));
for i=1:length(s_re)
    s_re{i}=codebook{ClusterNum(i)};
end
I_re=zeros(size(I1));
for j=1:length(s_re) 
  for i=1:sqrt(L)
    I_re((i+floor((j-1)*sqrt(L)/I1_rows)*sqrt(L)-1)*I1_rows+1+rem(j-1,I1_rows/sqrt(L))*sqrt(L):(i+floor((j-1)*sqrt(L)/I1_rows)*sqrt(L)-1)*I1_rows+(rem(j-1,I1_rows/sqrt(L))+1)*sqrt(L))=s_re{j}(1+(i-1)*sqrt(L):i*sqrt(L));
  end
end