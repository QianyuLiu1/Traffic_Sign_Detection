clc;
clear;
%% EdgeBox
% add path
addpath toolbox-master\channels
addpath toolbox-master\classify
addpath toolbox-master\detector
addpath toolbox-master\filters
addpath toolbox-master\images 
addpath toolbox-master\matlab
addpath StructuredEdgeDetector\edges-master
% load model
model=load('StructuredEdgeDetector\edges-master\models\forest\modelBsds.mat');
model=model.model ;
model.opts.multiscale=0; model.opts.sharpen=2; model.opts.nThreads=4;
% set up opts for edgeBoxes (see edgeBoxes.m)
opts = edgeBoxes;
opts.alpha = 0.65;     % step size of sliding window search
opts.beta  = 0.75;     % nms threshold for object proposals
opts.minScore = 0.01; %.01;  % min score of boxes to detect
opts.maxBoxes = 1000; %1e4;  % max number of boxes to detect
%%
path_train='Train-Image\';
path_test='Test-Image\';
%%
file=dir([path_train '*.png']);
n=length(file);
region_train=cell(2,n);
for i=1:n
    fprintf('Train:%d\n',i);
    name=file(i).name;
    im=imread([path_train name]);
    boxes_EdgeBox=edgeBoxes(im,model,opts);
    im=rgb2gray(im);
    regions_MSER=detectMSERFeatures(im,'RegionAreaRange',[15 round(size(im,1)*size(im,2)*0.5)]);
    boxes_MSER=Pixel2Box(regions_MSER);  
    %%
    boxes_EdgeBox=double(boxes_EdgeBox(:,1:4));
    boxes_MSER=double(boxes_MSER');
    boxes_EdgeBox(:,3)=boxes_EdgeBox(:,1)+boxes_EdgeBox(:,3);
    boxes_EdgeBox(:,4)=boxes_EdgeBox(:,2)+boxes_EdgeBox(:,4);
    region_train(1,i)={boxes_EdgeBox};
    region_train(2,i)={boxes_MSER};
end
%%
file=dir([path_test '*.png']);
n=length(file);
region_test=cell(2,n);
for i=1:n
    fprintf('Test:%d\n',i);
    name=file(i).name;
    im=imread([path_test name]);
    boxes_EdgeBox=edgeBoxes(im,model,opts);
    im=rgb2gray(im);
    regions_MSER=detectMSERFeatures(im,'RegionAreaRange',[15 round(size(im,1)*size(im,2)*0.5)]);
    boxes_MSER=Pixel2Box(regions_MSER);  
    %%
    boxes_EdgeBox=double(boxes_EdgeBox(:,1:4));
    boxes_MSER=double(boxes_MSER');
    boxes_EdgeBox(:,3)=boxes_EdgeBox(:,1)+boxes_EdgeBox(:,3);
    boxes_EdgeBox(:,4)=boxes_EdgeBox(:,2)+boxes_EdgeBox(:,4);
    region_test(1,i)={boxes_EdgeBox};
    region_test(2,i)={boxes_MSER};
end
save('RegionProposal.mat','region_train','region_test');
