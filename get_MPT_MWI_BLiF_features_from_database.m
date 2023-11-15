clear all; clc;

addpath('code\')
addpath('Databases\')
Code = importdata('UniformLBP8.txt');    
dataset_name = 'Win5'; % Win5, NBU, SMART, VALID10bit, SHU
[all_info, sceneNum, dataset_path] = get_info_from_database(dataset_name);

for iScene = 1 : sceneNum
    fprintf('Distorted LFI No.%d, Name: %s \n', iScene, all_info{6}{iScene});
    dis_LF = get_LFI_from_database(dataset_name, iScene, dataset_path, all_info);
    dis_LF = uint8(dis_LF);
    [U, V, H, W, ~] = size(dis_LF);
    
    tic
    gray_dis_LF = zeros(U, V, H, W);
    for u=1:U
        for v=1:V
            gray_dis_LF(u,v,:,:) = rgb2gray(squeeze(dis_LF(u,v,:,:,:)));
        end
    end
    
    % get MPT_MWI_BLiF features
    Feat_MPT = features_MPT(gray_dis_LF, Code);
    Feat_MWI = features_MWI(gray_dis_LF);
    Feat = [Feat_MPT; Feat_MWI]';
    
    % adopt PCA
    load([dataset_name, '_PCA.mat'])
    Feat_MPT = (Feat(:,1:354)-Mean_MPT)*Coeff_MPT;
    Feat_MPT = Feat_MPT(:,1:35);
    Feat_MWI = (Feat(:,370:end)-Mean_MWI)*Coeff_MWI;
    Feat_MWI = [Feat(:,355:369),Feat_MWI(:,1:35)];
    Feat = [Feat_MPT,Feat_MWI]';
    
    toc
    if iScene == 1
        features = zeros(sceneNum,size(Feat,1));
    end
    features(iScene,:) = Feat;
end
features = squeeze(features);
save([dataset_name, '_MPT_MWI_BLiF_PCA.mat'], 'features');




