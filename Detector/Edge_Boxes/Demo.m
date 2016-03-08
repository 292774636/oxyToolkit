%% Initialization
[curdir] = edgeboxes_init();
OS = 'Linux';
edgeboxes_build(OS);

if ~exist('private/edgeBoxesMex.mexa64')
    addpath(genpath('/home/ouxinyu/Edge_boxes/Edge_Boxes/toolbox-master')); savepath;
    toolboxCompile; 
end
clear OS;

%% load pre-trained edge detection model and set opts (see edgesDemo.m)
model=load('Edge_Boxes/edges-master/models/forest/modelBsds'); model=model.model;
model.opts.multiscale=0; model.opts.sharpen=2; model.opts.nThreads=4;

%% set up opts for edgeBoxes (see edgeBoxes.m)
opts = edgeBoxes;
opts.alpha = .65;     % step size of sliding window search
opts.beta  = .8;     % nms threshold for object proposals
opts.minScore = .01;  % min score of boxes to detect
opts.maxBoxes = 1e4;  % max number of boxes to detect

%% detect Edge Box bounding box proposals (see edgeBoxes.m)
fprintf('Computing candidate regions...');
I = imread('000004.jpg');
th = tic; 
bbs=edgeBoxes(I,model,opts); 
boxes = [bbs(:,1), bbs(:,2), bbs(:,1) + bbs(:,3), bbs(:,2) + bbs(:, 4)];
clear bbs opts model I curdir;
fprintf('Found %d candidates (in %.3fs).\n', size(boxes,1), toc(th));

save('000004_boxes2.mat', 'boxes', '-v7');
