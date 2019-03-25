function communityCommonality= communityAssignmentCommonality(nodeAllegianceMatrix,nodeNum)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script communityAssignmentCommonality.m 
%
% Extracts a commonality adjecency matrix giving the count of how many 
% times two node appears within the same community together across all N
% layers.
% . 
% 
% Input: 
%       
%       - nodeAllegianceMatrix: Each cell gives the community assignment 
%                               each node in that particular layer under
%                               detected community labels. Obtained via
%                               nodeAllegiance.m function.
%       - nodeNum: Number of nodes in the adjecency matrix
%       
%       
% Output:
%
%      - communityCommonality: nodeNum x nodeNum adjacency matrix, each
%      index giving how many times those two nodes appeared in the same
%      community across those layers. 
%     

% Dependencies:   
%    - nodeAllegiance.m by Isil Bilgin (2018)
% 
%
% Isil Bilgin 1/10/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



communityCommonalityMatrixSum = zeros(nodeNum, nodeNum);
for layer = 1:size(nodeAllegianceMatrix,2)
    communityCommonalityMatrix = [];
    for commNum=1:size(nodeAllegianceMatrix{1,layer},2)
        for i=1:size(nodeAllegianceMatrix{1,layer}(:,commNum),1)
            for j=1:size(nodeAllegianceMatrix{1,layer}(:,commNum),1)
                
                communityCommonalityMatrix(nodeAllegianceMatrix{1,layer}{i,commNum},nodeAllegianceMatrix{1,layer}{j,commNum}) =1;
           
            end
        end
    end
        
    communityCommonalityMatrixSum = communityCommonalityMatrix + communityCommonalityMatrix;


communityCommonality=communityCommonalityMatrixSum - diag(diag(communityCommonalityMatrixSum));
end