function  parameterOptimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script parameterOptimization.m 
%
% Estimates the community similarity, variance, quality function and node
% flexibility across each pair of structural (gamma) and temporal (omega)
% resolution parameters. These estimations will give you a confidence in
% choosing the right pairs of parameters across all subjects to represent
% best community structure in your multilayered network.
%
% Dependencies:   
%    - LouvainCommunutiyEstimate.m by Mucha et al. (2010)
%    - zrand.m by Bassett et al. (2013)
%    - flexibility.m by Bassett et al. (2013)#
%    - optimizationComparisons.m by me ;)
%
% Isil Bilgin 10/07/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
close all;
subjectPool={'01','02','03','04','05','06','07','08','09','10'};
pwd = ' '; % Add a main folder path


gamma =  [0.5:0.1:1.2]; % define the structural resolution parameter interval and the step
omega =  [0.1:0.05:1]; % define the temporal resolution parameter interval and the step

for subjectNum=1:size(subjectPool,2)
mainSubjectFolder =  fullfile(pwd, sprinf('Subject%s',subjectPool{subjectNum}));
load(fullfile(mainSubjectFolder,'multilayeredMatrix.mat'));  

    
% index of each pair of gamma and omega
index=0;

for i=1:size(gamma,2)
    for j=1:size(omega,2)
index = index+1;


% Run multilayered community detection
[realcommAssign,qualityFunc] = LouvainCommunutiyEstimate(multiMatrix,gamma(i), omega(j));


% Estimate similarity scores across 100 optimization of the community
% detections
[zscore_all,viscore_all]=optimizationComparisons(realcommAssign);


similarityEstimations(index,1) = zscore_all;
similarityEstimations(index,2)= viscore_all;
similarityEstimations(index,3)=mean(qualityFunc);

communityAssignments{index,1} = realcommAssign;
communityAssignments{index,2} =qualityFunc;

for opt=1:100
flexibilityEstimates{index,opt} = flexibility(realcommAssign{1,opt}', 'temp');
end
 
% Save the parameters    
  filename = 'gammaomegaparameter.mat';
   save(fullfile(mainSubjectFolder,filename),'similarityEstimations');

   filename1 = 'communityAssignments.mat';
   save(fullfile(mainSubjectFolder,filename1), 'communityAssignments','flexibilityEstimates','commNumber');
   
    end  
end
     
clear similarityEstimations communityAssignments flexibilityEstimates 
     end


   
