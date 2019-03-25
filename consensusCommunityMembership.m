function communityMembers = consensusCommunityMembership(consensusModularityAssinment)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script consensusCommunityMembership.m 
%
% Groups the nodes into the estimated communities and given the roi list 
% labels, also return the grouping list with the anatomical label of the
% ROIs.
% . 
% 
% Input: 
%       - consensusModularityAssignment: Consensus community distribution outcome of the
%       zrand.m function 


% Output:
%       - nodeAllegianceMatrix: Each cell gives the community assignment 
%                               each node in that particular layer under
%                               detected community labels.
%       
%
%      - communityMembers: Each row represents the assignment of nodes in
%                          that particular layer into separate communities,
%                          and each column are represents the number of 
%                          communities in that layer.

% Dependencies:   
%    - zrand.m by Bassett et al. (2013)
%    - genlouvain.m by Mucha et al. (2010)
% 
%
% Isil Bilgin 1/10/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





 for layer = 1:size(consensusModularityAssinment,2)
%     
   numberofCommunity = max(consensusModularityAssinment(:));
      
   for communityIndex = 1: numberofCommunity  
   communityMembers{layer,communityIndex} = find(consensusModularityAssinment(:,layer)== communityIndex);
   end
   
   
end
