function fishersZtransform(corrcoeff1, corrcoeff2, sampleNum1, sampleNum2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script fishersZtransform.m
%
% Estimates the significancy of difference between
% the estimated correlation coefficient from two independent populations against
% the null hypothesis (correlation=0). If corrcoeff1 is larger than corrcoef2,
% then the z-value will be positive, corrcoeff1 is smaller than corrcoef2, 
% the z-value will be negative.

% Especially for the connectivity studies, Fisher's z-transform 
% make the distribution more normal and comperable especially in the existence
% group analysis. 

% We first transform each of the pairs of correlation coefficient to z-score
% and then we test their difference against the null hypothesis.
%
% Input:
% corrcoeff1 and corrcoeff2: correlation coefficiencts from different
% populations
% sampleNum1 and sampleNum2: number of samples in each independent population
% for the estimation of the correation coefficients (respectively)

% Output: p value of significany of difference (probability of
% rejecting/accepting the null hypothesis)
%
% Dependencies:
%    -normcdf.m Matlab statistical toolbox function.
%
%
% Isil Bilgin 12/12/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Estimate z-scores for each of the correlation coefficient

z_score1 = 0.5*log((1+corrcoeff1)/(1-corrcoeff1));
z_score2 = 0.5*log((1+rcorrcoeff2)/(1-corrcoeff2));


% Run Fisher's Z- transform
zValue = (z_score1-z_score2)/sqrt(1/(sampleNum1-3)+1/(sampleNum2-3));

% Estimate p
p = (1-normcdf(abs(zValue),0,1))*2;


end