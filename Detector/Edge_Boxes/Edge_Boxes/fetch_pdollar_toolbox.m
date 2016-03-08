function fetch_pdollar_toolbox()
    cur_dir = pwd;
    cd(fileparts(mfilename('fullpath')));

    fprintf('Downloading  pdollar''s toolbox, waiting...\n');
    urlwrite('https://github.com/pdollar/toolbox/archive/master.zip', 'toolbox-master.zip');

    fprintf('Unzipping...\n');
    unzip('toolbox-master.zip');

    fprintf('Done.\n');
    system('del toolbox-master.zip');

    cd(cur_dir);
end

