function fetch_edge_boxes()
    cur_dir = pwd;
    cd(fileparts(mfilename('fullpath')));

    fprintf('Downloading edges-master, waiting...\n');
    urlwrite('https://github.com/pdollar/edges/archive/master.zip', 'edges-master.zip');

    fprintf('Unzipping...\n');
    unzip('edges-master.zip');

    fprintf('Done.\n');
    system('del edges-master.zip');

    cd(cur_dir);
end

