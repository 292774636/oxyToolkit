function active_caffe_mex(gpu_id, caffe_version)
% active_caffe_mex(gpu_id, caffe_version)
% --------------------------------------------------------
% Author: Xinyu Ou
% Date: 2016-3-18
% --------------------------------------------------------

    % set gpu in matlab
    gpuDevice(gpu_id);
    
    cur_dir = pwd;
    if strcmp(caffe_version, 'caffe_default')
        caffe_dir = fullfile(cur_dir, 'matlab');
    elseif strcmp(caffe_version, 'caffe_faster_rcnn')
        caffe_dir = fullfile(cur_dir, 'matlab');
    end
        
    addpath(genpath(caffe_dir));
    cd(caffe_dir);
    caffe.set_device(gpu_id-1);
    cd(cur_dir);
end
