function [r_1,r_2,r_3]=RegionProposal_IOU(IOU)
%%
load('RegionProposal.mat');
load('GT_Test.mat');
load('GT_Train.mat');
%IOU=0.5;
%% Train Data
n=length(ground_truth_train);
IOU_train_correct_Edgebox=0;
IOU_train_correct_MSERs=0;
IOU_train_correct=0;
IOU_train_all=0;
IOU_train_sum_p=0;
IOU_train_sum_n=0;
IOU_train_sum_all=0;
for i=1:n
    GT=cell2mat(ground_truth_train(i));
    GT=GT(:,2:5);
    %%
    RP_EdgeBox=cell2mat(region_train(1,i));
    RP_EdgeBox(:,3)=RP_EdgeBox(:,3)-RP_EdgeBox(:,1);
    RP_EdgeBox(:,4)=RP_EdgeBox(:,4)-RP_EdgeBox(:,2);
    IOU_RP_EdgeBox=CalcIoU(GT,RP_EdgeBox);
    IOU_RP_EdgeBox=sum(IOU_RP_EdgeBox>IOU,2);
    %%
    RP_MSERs=cell2mat(region_train(2,i));
    RP_MSERs(:,3)=RP_MSERs(:,3)-RP_MSERs(:,1);
    RP_MSERs(:,4)=RP_MSERs(:,4)-RP_MSERs(:,2);
    IOU_RP_MSERs=CalcIoU(GT,RP_MSERs);
    IOU_RP_MSERs=sum(IOU_RP_MSERs>IOU,2);
    %%
    RP_All=[RP_EdgeBox' RP_MSERs']';    
    IOU_RP_ALL=CalcIoU(GT,RP_All); IOU_RP_ALL_Copy=IOU_RP_ALL;   
    IOU_RP_ALL=sum(IOU_RP_ALL>IOU,2);
    %%
    IOU_train_correct_Edgebox=IOU_train_correct_Edgebox+sum(IOU_RP_EdgeBox>0);
    IOU_train_correct_MSERs=IOU_train_correct_MSERs+sum(IOU_RP_MSERs>0);
    IOU_train_correct=IOU_train_correct+sum(IOU_RP_ALL>0);
    IOU_train_all=IOU_train_all+size(GT,1);   
    %%
    IOU_train_sum_p=IOU_train_sum_p+sum(sum(IOU_RP_ALL_Copy>=0.5,2));
    IOU_train_sum_n=IOU_train_sum_n+size(RP_All,1)-sum(sum(IOU_RP_ALL_Copy>=0.5,2));
    IOU_train_sum_all=IOU_train_sum_all+size(RP_All,1);
end
%% Test Data
n=length(ground_truth_test);
IOU_test_correct_Edgebox=0;
IOU_test_correct_MSERs=0;
IOU_test_correct=0;
IOU_test_all=0;
IOU_test_sum_p=0;
IOU_test_sum_n=0;
IOU_test_sum_all=0;
for i=1:n
    GT=cell2mat(ground_truth_test(i));
    GT=GT(:,2:5);
    %%
    RP_EdgeBox=cell2mat(region_test(1,i));
    RP_EdgeBox(:,3)=RP_EdgeBox(:,3)-RP_EdgeBox(:,1);
    RP_EdgeBox(:,4)=RP_EdgeBox(:,4)-RP_EdgeBox(:,2);
    IOU_RP_EdgeBox=CalcIoU(GT,RP_EdgeBox);
    IOU_RP_EdgeBox=sum(IOU_RP_EdgeBox>IOU,2);
    %%
    RP_MSERs=cell2mat(region_test(2,i));
    RP_MSERs(:,3)=RP_MSERs(:,3)-RP_MSERs(:,1);
    RP_MSERs(:,4)=RP_MSERs(:,4)-RP_MSERs(:,2);
    IOU_RP_MSERs=CalcIoU(GT,RP_MSERs);
    IOU_RP_MSERs=sum(IOU_RP_MSERs>IOU,2);
    %%
    RP_All=[RP_EdgeBox' RP_MSERs']';    
    IOU_RP_ALL=CalcIoU(GT,RP_All);IOU_RP_ALL_Copy=IOU_RP_ALL;   
    IOU_RP_ALL=sum(IOU_RP_ALL>IOU,2);
    %%
    IOU_test_correct_Edgebox=IOU_test_correct_Edgebox+sum(IOU_RP_EdgeBox>0);
    IOU_test_correct_MSERs=IOU_test_correct_MSERs+sum(IOU_RP_MSERs>0);
    IOU_test_correct=IOU_test_correct+sum(IOU_RP_ALL>0);
    IOU_test_all=IOU_test_all+size(GT,1);
    %%
    IOU_test_sum_p=IOU_test_sum_p+sum(sum(IOU_RP_ALL_Copy>=0.5,2));
    IOU_test_sum_n=IOU_test_sum_n+size(RP_All,1)-sum(sum(IOU_RP_ALL_Copy>=0.5,2));
    IOU_test_sum_all=IOU_test_sum_all+size(RP_All,1);
end
%%
fprintf('Train:\n');
fprintf('EdgeBox: %.6f.\n',IOU_train_correct_Edgebox/IOU_train_all);
fprintf('MSERs  : %.6f.\n',IOU_train_correct_MSERs/IOU_train_all);
fprintf('All    : %.6f.\n',IOU_train_correct/IOU_train_all);
fprintf('Test:\n');
fprintf('EdgeBox: %.6f.\n',IOU_test_correct_Edgebox/IOU_test_all);r_1=IOU_test_correct_Edgebox/IOU_test_all;
fprintf('MSERs  : %.6f.\n',IOU_test_correct_MSERs/IOU_test_all);r_2=IOU_test_correct_MSERs/IOU_test_all;
fprintf('All    : %.6f.\n',IOU_test_correct/IOU_test_all);r_3=IOU_test_correct/IOU_test_all;
end
