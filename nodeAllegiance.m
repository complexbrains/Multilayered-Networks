function [nodeAllegianceMatrix,nodeAllegianceMatrixROIs] = nodeAllegiance(consensusModularityAssignment,roiList)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script nodeAllegiance.m 
%
% Groups the nodes into the estimated communities and given the roi list 
% labels, also return the grouping list with the anatomical label of the
% ROIs.
% . 
% 
% Input: 
%       - consensusModularityAssignment: Consensus community distribution outcome of the
%       zrand.m function 
%        - roiList: A cell array of ROIs(nodes) that has been used in connectivity
%        estimation.
%
% Output:
%       - nodeAllegianceMatrix: Each cell gives the community assignment 
%                               each node in that particular layer under
%                               detected community labels.
%       
%
%      - nodeAllegianceMatrixROIs: Each cell gives the community assignment 
%                                  each node label in that particular layer
%                                  under detected community labels.
%     

% Dependencies:   
%    - zrand.m by Bassett et al. (2013)
%    - genlouvain.m by Mucha et al. (2010)
% 
%
% Isil Bilgin 1/10/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for layer = 1: size(consensusModularityAssignment,2)
    
    communitySizeofLayer = max(consensusModularityAssignment(:,layer));

        
        for commSize=1:communitySizeofLayer
                k=1;
    for node=1:size(consensusModularityAssignment,1)
        
        
        if consensusModularityAssignment(node,layer)==commSize
            nodeAllegianceMatrix{layer}{k,commSize}=node;
            k=k+1;
        end
    end
        end
end

nodeAllegianceMatrixROIs = {};

for layer=1:size(nodeAllegianceMatrix,2)
    for commSize=1:size(nodeAllegianceMatrix{1,layer},2)
        for nodeNum = 1:size(nodeAllegianceMatrix{1,layer}(:,commSize),1)
            
            if isempty(nodeAllegianceMatrix{1,layer}{nodeNum,commSize})~=1
        nodeAllegianceMatrixROIs{1,layer}{nodeNum,commSize}= roiList{nodeAllegianceMatrix{1,layer}{nodeNum,commSize},1};
            end
        end
    end
end
        




