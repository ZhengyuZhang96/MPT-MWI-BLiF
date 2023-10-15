clc;close all;clear;

addpath('code\')
addpath('Databases\')
addpath('demo\')
addpath('SVR\')

% load distorted LFI (EPICNN_dishes.bmp, which is from Win5-LID database)
dis_LF = imread('EPICNN_dishes.bmp');
dis_LF = permute(reshape(dis_LF,[9, 512, 9, 512, 3]),[1,3,2,4,5]); 

tic

% convert each SAI into grayscale
[U, V, H, W, ~] = size(dis_LF);
gray_dis_LF = zeros(U, V, H, W);
for u=1:U
    for v=1:V
        gray_dis_LF(u,v,:,:) = rgb2gray(squeeze(dis_LF(u,v,:,:,:)));
    end
end

% extract MPT-MWI-BLiF features
Code = importdata('UniformLBP8.txt'); 
Feat_MPT = features_MPT(gray_dis_LF, Code);
Feat_MWI = features_MWI(gray_dis_LF);
Feat = [Feat_MPT;Feat_MWI]';

% adopt PCA
load('Win5_PCA.mat')
features_MPT = (Feat(:,1:354)-Mean_MPT)*Coeff_MPT;
features_MPT = features_MPT(:,1:35);
features_MWI = (Feat(:,370:end)-Mean_MWI)*Coeff_MWI;
features_MWI = [Feat(:,355:369),features_MWI(:,1:35)];
Feat_PCA = [features_MPT,features_MWI];

% predict quality using the pretrained SVR model
load model
Feat_PCA = normalization(Feat_PCA,-1,1,MAX,MIN);
[predict_score, ~, ~] = svmpredict(1, Feat_PCA, model);
fprintf('The predicted quality score is %4f.\n', predict_score);

toc





