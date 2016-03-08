function [curdir]  = edgeboxes_init()
%EDGEBOXES_INIT Summary of this function goes here
    curdir = fileparts(mfilename('fullpath'));
    addpath(fullfile(curdir, 'Edge_Boxes'));
    
    if ~exist(fullfile(curdir,'Edge_Boxes/edges-master'), 'dir')
        fprintf('Warning: you will need the edgeboxes code.\n');
        fprintf('Press any key to download it ');
        pause;
        fetch_edge_boxes();       
    end  
	addpath(fullfile(curdir,'Edge_Boxes/edges-master'));
	%addpath(fullfile(curdir,'Edge_Boxes/edges-master/private'));   
    
    if ~exist(fullfile(curdir,'Edge_Boxes/toolbox-master'), 'dir')
        fprintf('Warning: you will need the pdollar-toolbox-master code.\n');
        fprintf('Press any key to download it ');
        pause;
        fetch_pdollar_toolbox(); 
    end
	addpath(fullfile(curdir,'Edge_Boxes/toolbox-master'));  
end

