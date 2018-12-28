function density = networkDensity(adjMatrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script networkDensity.m 
% Estimates the connection density of the single layered network
% Input: 
%   adjMatrix: NxN binary or weighted, undirected connectivity matrix
% Output: 
% `density: density of the network
% 

% Isil Bilgin 01/07/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numofNodes = size(adjMatrix,2);
potentialConnections = numofNodes*(numofNodes-1) /2;

actualConnections = size(nonzeros(adjMatrix),1);

density  = actualConnections / potentialConnections; 

