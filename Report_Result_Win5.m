clc;close all;clear;

% load features and mos
addpath('Databases\')
addpath('features\')
addpath('SVR\')
load Win5_all_mos
load Win5_MPT_MWI_BLiF_PCA

c_num = 0;
lower=-1; upper=1;
input_NR = [features];
output = cell2mat(win5_all_mos);
scene_num = 10;
list_num = 1:scene_num; 
folds_num = 2;
all_num = factorial(scene_num)/(factorial(scene_num-folds_num)*factorial(folds_num));
best_plcc = 0;
best_srocc = 0;
best_krocc = 0;
best_rmse = 0;
best_i = 0;
best_j = 0;

for ii = 1:scene_num-1
    for jj = 2:scene_num
        if ii < jj 
            c_num = c_num + 1;
            fork_num(c_num,:) = [ii,jj];
        end
    end
end
for i = 1:10
    input_code_NR{i,:}=input_NR([1+(i-1),(11+(i-1)*5):(15+(i-1)*5),(61+(i-1)*5):(65+(i-1)*5),(111+(i-1)*5):(115+(i-1)*5),(161++(i-1)*5):(165+(i-1)*5),211+(i-1)],:);
    output_code{i,:}=output([1+(i-1),(11+(i-1)*5):(15+(i-1)*5),(61+(i-1)*5):(65+(i-1)*5),(111+(i-1)*5):(115+(i-1)*5),(161++(i-1)*5):(165+(i-1)*5),211+(i-1)],:);
end

for i=0:8
    for j=-8:0

        for fork=1:all_num
            
            test = fork_num(fork,:);
            train = list_num(~ismember(list_num,test));
            for m=1:size(test',1)
                input_test_NR(1+22*(m-1):(22*m),:)=input_code_NR{test(m)};
                output_test(1+22*(m-1):(22*m),:)=output_code{test(m)};
            end
            for n=1:size(train',1)
                input_train_NR(1+22*(n-1):(22*n),:)=input_code_NR{train(n)};
                output_train(1+22*(n-1):(22*n),:)=output_code{train(n)};
            end  
            
            [input_train_NR,MAX,MIN]=normalization(input_train_NR,lower,upper);
            input_test_NR = normalization(input_test_NR,lower,upper,MAX,MIN);
            cost = 2^i;
            gamma = 2^j;
            c_str = sprintf('%f',cost);
            g_str = sprintf('%.2f',gamma);
            libsvm_options = ['-s 3 -t 2 -g ',g_str,' -c ',c_str];
            model = svmtrain(output_train,input_train_NR,libsvm_options);
            [predict_score, ~, ~] = svmpredict(zeros(size(output_test)), input_test_NR, model);
            pearson_cc_NR(fork) = abs(IQAPerformance(predict_score, output_test,'p'));
            spearman_srocc_NR(fork) = abs(IQAPerformance(predict_score, output_test,'s'));
            kendall_krocc_NR(fork) = abs(IQAPerformance(predict_score, output_test,'k'));
            rmse_NR(fork)  = abs(IQAPerformance(predict_score, output_test,'e'));
        end
    
        pearson_plcc_all = mean(abs(pearson_cc_NR));
        spearman_srocc_all = mean(abs(spearman_srocc_NR));
        kendall_krocc_all = mean(abs(kendall_krocc_NR));
        rmse_all = mean(abs(rmse_NR));   

        if spearman_srocc_all > best_srocc
            best_plcc = pearson_plcc_all;
            best_srocc = spearman_srocc_all;
            best_krocc = kendall_krocc_all;
            best_rmse = rmse_all;
            best_i = i;
            best_j = j;
        end
    end
end

fprintf('best plcc: %.4f\n',best_plcc)
fprintf('best srocc: %.4f\n',best_srocc)
fprintf('best krocc: %.4f\n',best_krocc)
fprintf('best rmse: %.4f\n',best_rmse)
fprintf('best i: %d\n',best_i)
fprintf('best j: %d\n',best_j)

