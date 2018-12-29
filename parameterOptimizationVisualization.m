function parameterOptimizationVisualization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script parameterOptimizationVisualization.m 
%
% Creates the matrix format of the variation, zscore, quality function and 
% flexibility estimations across each pairwise parameter estimates of 
% individual participant and plots the matrices. This helps for a visual
% inspection to find out which parameter pairs are giving you the highest
% z-score, lowest variability, highest quality estimation and moderate
% level flexibility estimation across all optimizations of the multilayer
% community detection. Hence you can pick those pair of parameters to
% continue your investigations on the community structure of your
% multilayered networks
% 
% Input: 
%       - Loads each participant's similarity estimates across pair of
%       parameters
% Output:
%       - Plots of the similarity estimates
%       
%
% Isil Bilgin 10/07/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear all;
close all;

%% Parameter Setups
subjectPool={'01','02','03','04','05','06','07','08','09','10'};
pwd = ' '; % Add a main folder path
gamma =  [0.5:0.1:1.2]; % define the structural resolution parameter interval and the step
omega =  [0.1:0.05:1]; % define the temporal resolution parameter interval and the step


for subjectNum=1:size(subjectPool,2)
    mainSubjectFolder =  fullfile(pwd, sprinf('Subject%s',subjectPool{subjectNum}));
    
    % Load parameterwise similarity metrics
    filename = 'gammaomegaparameter.mat';
    load(fullfile(mainSubjectFolder,filename));
    
    % Load parameterwise community quality function, community assingment and
    % flexibility estimates
    filename = 'communityAssignments.mat';
    load(fullfile(mainSubjectFolder,filename));
    
    
    numofPairofParameters = size(gamma,2)* size(omega,2);
    sizeofOmega = size(omega,2);
    sizeofGamma= size(gamma,2);
    
  
%% Create the parameter estimate matrices for visualisation by having the 
% gamma parameters in the X axis and omega parameters in the Y axis.

index=1;
for i=1:sizeofGamma
    zscore(1:sizeofOmega,i)= similarityEstimations(index:index+sizeofOmega-1,1);
    variance(1:sizeofOmega,i)= similarityEstimations(index:index+sizeofOmega-1,2);
    qualityFunction(1:sizeofOmega,i)= similarityEstimations{}(index:index+sizeofOmega-1,3);
    index=index+sizeofOmega;
end
    
     
%% Create flexibility matrix 

for index=1:size(flexibilityEstimates,1)
    meanFlexibilityOveropt = zeros(size(flexibilityEstimates,1),1);
    for opt=1:size(flexibilityEstimates,2)
        
        meanFlexibilityOveropt = meanFlexibilityOveropt + flexibilityEstimates{index,opt};
   
    end
      meanFlexibilityOveropt = meanFlexibilityOveropt/size(flexibilityEstimates,2);
       flexibilityOverGammaOmega(index) = mean( meanFlexibilityOveropt,1);
end


    index=1
    for i=1:sizeofGamma
      Flexibilitymatrix(:,i) = flexibilityOverGammaOmega(1,index:index+sizeofOmega-1);
      index=index+sizeofOmega;
    end
    



%% Plot the similarity matrices

% Variation Matrix
    h= figure;
    imagesc(variance); % plot the matrix
    colormap('jet'); % set the colorscheme
    colorbar ('EastOutside') ; % enable colorbar
    set(gca,'XTick',1:size(gamma,2),...                         %# Change the axes tick marks
        'XTickLabel',gamma,...  %#   and tick labels
        'YTick',1:size(omega,2),...
        'YTickLabel',omega,...
        'TickLength',[0 0]);
    set(gca,'XTickLabelRotation',45);   
    title('Variance Across Optimizations');
    saveas(h, fullfile(mainSubjectFolder,sprintf('Variance_%s',subjectPool{subjectNum})), 'png')
    
    
    
% Zscore similarity matrix    
    h = figure;
    imagesc(zscore); % plot the matrix
    colorbar ('EastOutside') ; % enable colorbar
    set(gca,'XTick',1:size(gamma,2),...                         %# Change the axes tick marks
        'XTickLabel',gamma,...  %#   and tick labels
        'YTick',1:size(omega,2),...
        'YTickLabel',omega,...
        'TickLength',[0 0]);
    set(gca,'XTickLabelRotation',45);   
    title('zscore Across Optimizations' );
    saveas(h, fullfile(mainSubjectFolder,sprintf('zscore_%s',subjectPool{subjectNum})), 'png')
    
    
% Quality Function Matrix    
    h = figure;
    imagesc(qualityFunction); % plot the matrix
    colormap('jet'); % set the colorscheme
    colorbar ('EastOutside') ; % enable colorbar
    set(gca,'XTick',1:size(gamma,2),...   % Change the axes tick marks
        'XTickLabel',gamma,...  %#   and tick labels
        'YTick',1:size(omega,2),...
        'YTickLabel',omega,...
        'TickLength',[0 0]);
    set(gca,'XTickLabelRotation',45);
    title('qualityFunction Across Optimizations' );
    saveas(h, fullfile(mainSubjectFolder,sprintf('qualityFunction_%s',subjectPool{subjectNum})), 'png')
    

% Flexibility Estimation Matrix   
    
    h= figure;
    imagesc(Flexibilitymatrix); % plot the matrix
    colormap('jet'); % set the colorscheme
    colorbar ('EastOutside') ; % enable colorbar
    set(gca,'XTick',1:size(gamma,2),...            % Change the axes tick marks
        'XTickLabel',gamma,...  %   and tick labels
        'YTick',1:size(omega,2),...
        'YTickLabel',omega,...
        'TickLength',[0 0]);
        set(gca,'XTickLabelRotation',45);

    title('Flexibility Estimates');
    saveas(h, fullfile(mainSubjectFolder,sprintf('flexibilityEstimates_%s',subjectPool{subjectNum})), 'png')
    close all
end

