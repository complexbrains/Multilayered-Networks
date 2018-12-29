function  [zscore_all,viscore_all] = optimizationComparisons(realcommAssign, layerNum)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script optimizationComparisons.m 
%
% Estimates the similarity of the community distributions across 100
% optimization outcomes of Louvain multilayered community estimaation
% algorithm. 
% 
% Input: 
%       - realcommAssign: Community distribution outcome of the
%       LouvainCommunutiyEstimate.m function
%        - layerNum: The number of layers
% Output:
%       - zscore_all: Mean similarity across optimizations of community 
%                     detections. Higher the zscore, similar the 
%                     optimizations, better the community detection 
%                     estimation is. 
%
%       
%
%      - viscore_all: Mean variation across optimization of community
%                     detections. Smaller the viscore, similar the 
%                     optimizations, better the community detection.
%
% In this current code below two outputs of zrand.m function is not investigated.
% You can also look at those results.
%
%      - sscore_all: Rand similarity coefficient
%      - sarscore_all: Adjusted Rand similarity coefficient
% 

% Dependencies:   
%    - zrand.m by Bassett et al. (2013)
% 
%
% Isil Bilgin 10/07/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bring the matrix to the required format for the similarity estimations
for layer=1:layerNum
    for nodeNum=1:size(realcommAssign{1,1},1)
        for opt=1:100
            commAssignLayer{1,layer}(opt,nodeNum) = realcommAssign{1,opt}(nodeNum,layer);
        end
    end
end


% Loop for each layer
for layer =1:layerNum
    
    commAssign =  commAssignLayer{1,layer};
    numOpt = size(commAssign, 1);
    
    
    % Estimate the similarities across each pair of optimized community detections.
    for i=1:numOpt
        for j=1:numOpt
            
            [zRand,SR,SAR,VI] =  zrand(commAssign(i,:),commAssign(j,:));
            
            zscores{1,layer}(i,j) = zRand;
            sscore{1,layer}(i,j) = SR;
            sarscore{1,layer}(i,j) = SAR;
            viscore{1,layer}(i,j) = VI;
            
        end
    end
end


for layer =1:layerNum
    zscores{1,layer}(isnan(zscores{1,layer})) = 0;
    meanZscore{1,layer} = mean(mean(triu(zscores{1,layer})));
    
    sscore{1,layer}(isnan (sscore{1,layer})) = 0;
    meansscore{1,layer} = mean(mean(triu(sscore{1,layer})));
    
    sarscore{1,layer}(isnan(sarscore{1,layer})) = 0;
    meansarscore{1,layer} = mean(mean(triu(sarscore{1,layer})));
    
    viscore{1,layer}(isnan(sarscore{1,layer})) = 0;
    meanviscore{1,layer} = mean(mean(triu(viscore{1,layer})));
end

%% We are interested in mean similarity scores across layers
zscore_all = 0;
sscore_all = 0;
sarscore_all = 0;
viscore_all = 0;

for layer=1:layerNum
    zscore_all =   zscore_all + meanZscore{1,layer};
    sscore_all = sscore_all + meansscore{1,layer} ;
    sarscore_all = sarscore_all + meansarscore{1,layer};   
    viscore_all = viscore_all + meanviscore{1,layer} ;
end

zscore_all =  zscore_all /layerNum;
sscore_all = sscore_all /layerNum;
sarscore_all = sarscore_all /layerNum;
viscore_all = viscore_all /layerNum;