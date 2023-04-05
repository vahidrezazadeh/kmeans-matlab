%% K-MEANS CLUSTERING TECHNIQUE
function[codebook,ClusterNum]=kmeans_clustering(s,L,K)
% "s" is the cell of Input Vectors from the source.
% ------------------------------------------------------------------------- 
% % Initializing the K-Vectors (cells) of the codebook.
codebook=cell(1,K);
indx=randsample(length(s),K);
for i=1:K
    codebook{i}=s{indx(i)};
end
% -------------------------------------------------------------------------
% Iterative algorithm to assign the cluster numbers to the source output vectors.
%Initializing the Distortion values.1st element is old value and
%2nd element is the current value.   
vec_dist=cell(1,length(s));
ClusterNum=zeros(1,length(s));
Distortion=[0 0];
iter=0;
while(iter<=2 || (Distortion(1)-Distortion(2))/Distortion(2) > 0.9)
    iter=iter+1;
    
    Distortion(1)=Distortion(2);
    Distortion(2)=0;
    for i=1:length(s)
      
      % VEC_DIST is an array of cells with each cell corresponds to the each input vector. 
      % Each cell is an array of distances of input vector from each of the K-Vectors of Codebook.
      vec_dist{i}=dist(s{i},reshape(cell2mat(codebook),L,length(codebook)));
      ClusterNum(i)=find(vec_dist{i}==min(vec_dist{i}),1);
      Distortion(2)=Distortion(2)+min(vec_dist{i});
      
    end
    Distortion(2)=Distortion(2)/length(s);
    
    %Updating the Codebook Vectors by replacing each of them with the mean of corresponding set of input vectors (whose 
    % Closest Codebook Vector is same as the one to be replaced).
    
    for i=1:K
      temp=reshape(cell2mat(s),L,length(s));
      codebook{i}=mean(temp(:,ClusterNum==i),2)';
    end
    
end