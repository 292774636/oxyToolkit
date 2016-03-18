function [net, maxlabel, feature] = Demo(img)
% ����ʵ��������ȡ�ͷ���ȼ򵥹��ܣ��ó����� Faster RCNN�г�ȡ��Ҫ��װ CUDA 6.5
% PS����������� ���ɰ�װCUDA��ʹ�����°�Caffe-master�İ汾��Ĭ��caffe_version = caffe��
% Author: Xinyu Ou
% Date: 2016-3-18
%
% Usage: [net, maxlabel, feature] = Demo();, [net, maxlabel, feature] = Demo(img);

%% ===============================================================
% Step0������GPU��������Caffe����·��
th = tic();
 
    addpath(fullfile(pwd, 'utils'));
    caffe_version      = 'caffe_faster_rcnn'; % caffe_faster_rcnn, caffe_default(��δ��д)
    gpu_id             = auto_select_gpu;
    active_caffe_mex(gpu_id, caffe_version);
% -------------------------------------------------------------------------    
%% ===============================================================
% Step1: ����ģ�ͺ�ģ�Ͳ���
    
    modelDir                = fullfile(pwd, 'CaffeModels');
    net_model               = fullfile(modelDir, 'deploy.prototxt');
    net_weights             = fullfile(modelDir, 'bvlc_reference_caffenet.caffemodel');
    net                     = caffe.Net(net_model, net_weights, 'test');

tLoadModel = toc(th); 
% -------------------------------------------------------------------------
%% ===============================================================
% Step2: ��ȡ�������߼���׼ȷ��

    % ����ͼƬ������Ԥ����
    try 
        im = imread(img);
    catch
        im = imread('cat.jpg');
    end
    
    th = tic();
    input_data = {prepare_image(im)};
    tPrepare = toc(th);
    
    
    % ����ǰ�򴫲�
    th = tic();
    scores = net.forward(input_data);
    tForward = toc(th);
    
    % �������
    th = tic();
    scores = scores{1};
    scores = mean(scores, 2);  % take average scores over 10 crops
    [~, maxlabel] = max(scores);
    
    % ��ȡ�� conv5�������
    feature = net.blob_vec(net.name2blob_index('conv5')).get_data();
    tExtract = toc(th);
    
    caffe.reset_all();
    fprintf('����ģ�ͣ�%.3f, ����Ԥ����%.3f, ǰ�򴫲���%.3f, �������ȡ������%.3f. \n', tLoadModel, tPrepare, tForward, tExtract);
end 
    
function crops_data = prepare_image(im)
    % ------------------------------------------------------------------------
    % caffe/matlab/+caffe/imagenet/ilsvrc_2012_mean.mat contains mean_data that
    % is already in W x H x C with BGR channels
%     d = load('D:\oxyMSDog\CaffeModels\AlexNet\ilsvrc_2012_mean.mat');
%     mean_data = d.mean_data;
    VGG_MEAN = [104, 117, 124];
    IMAGE_DIM = 256;
    CROPPED_DIM = 227;

    % Convert an image returned by Matlab's imread to im_data in caffe's data
    % format: W x H x C with BGR channels
    im_data = im(:, :, [3, 2, 1]);  % permute channels from RGB to BGR
    im_data = permute(im_data, [2, 1, 3]);  % flip width and height
    im_data = single(im_data);  % convert from uint8 to single
    im_data = imresize(im_data, [IMAGE_DIM IMAGE_DIM], 'bilinear');  % resize im_data
%     im_data = im_data - mean_data;  % subtract mean_data (already in W x H x C, BGR)
    for c = 1:3
        im_data(:,:,c) = im_data(:,:,c) - VGG_MEAN(c);
    end

    % oversample (4 corners, center, and their x-axis flips)
    crops_data = zeros(CROPPED_DIM, CROPPED_DIM, 3, 10, 'single');
    indices = [0 IMAGE_DIM-CROPPED_DIM] + 1;
    n = 1;
    for i = indices
      for j = indices
        crops_data(:, :, :, n) = im_data(i:i+CROPPED_DIM-1, j:j+CROPPED_DIM-1, :);
        crops_data(:, :, :, n+5) = crops_data(end:-1:1, :, :, n);
        n = n + 1;
      end
    end
    center = floor(indices(2) / 2) + 1;
    crops_data(:,:,:,5) = ...
      im_data(center:center+CROPPED_DIM-1,center:center+CROPPED_DIM-1,:);
    crops_data(:,:,:,10) = crops_data(end:-1:1, :, :, 5);
end
