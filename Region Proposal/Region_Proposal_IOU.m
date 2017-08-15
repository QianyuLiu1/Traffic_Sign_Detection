clc;
clear;
%%
figure(1);
recall_Edgeboxes=[];
recall_MSERs=[];
recall_All=[];
IOU_Total=[];
for i=1:10
    IOU=0.1*i;
    [r_1,r_2,r_3]=RegionProposal_IOU(IOU);
    recall_Edgeboxes=[recall_Edgeboxes r_1];
    recall_MSERs=[recall_MSERs r_2];
    recall_All=[recall_All r_3];
    IOU_Total=[IOU_Total IOU];    
end
% To calculate the recall rate of the MSERs and Edgeboxes methods
plot(IOU_Total,recall_Edgeboxes,'ro-');
hold on;
%To exteact the IOU rate and recall rate of Edgeboxes method
plot(IOU_Total,recall_MSERs,'bs-');
hold on;
%To extract the IOU rate and recall rate of MSERs method
plot(IOU_Total,recall_All,'kd-');
xlabel('Intersection over union');
ylabel('Recall rate');
legend('EdgeBoxes','MSERs','Combination');
grid on;
