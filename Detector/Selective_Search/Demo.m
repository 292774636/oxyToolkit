[curdir] = ss_init();
if ~exist('anigauss') || ~exist('mexCountWordsIndex') || ~exist('mexFelzenSegmentIndex')
    ss_build();
    addpath(fullfile(curdir, 'bin'));
end

im = imread('001.jpg');

fprintf('Computing candidate regions...');
th = tic();
fast_mode = true;
boxes = selective_search_boxes(im, fast_mode);

% compat: change coordinate order from [y1 x1 y2 x2] to [x1 y1 x2 y2]
boxes = boxes(:, [2 1 4 3]);
fprintf('Found %d candidates (in %.3fs).\n', size(boxes,1), toc(th));

save('001_boxes_quality.mat', 'boxes');
