function [curdir] = ss_init()
    curdir = fileparts(mfilename('fullpath'));
    addpath(fullfile(curdir, 'Selective_Search'));
    if exist(fullfile(curdir,'Selective_Search/SelectiveSearchCodeIJCV'), 'dir')
      addpath(fullfile(curdir,'Selective_Search/SelectiveSearchCodeIJCV'));
      addpath(fullfile(curdir,'Selective_Search/SelectiveSearchCodeIJCV/Dependencies'));
    else
      fprintf('Warning: you will need the selective search IJCV code.\n');
      fprintf('Press any key to download it (runs ./Selective_Search/fetch_selective_search.sh)> ');
      pause;
      if ispc
          fetch_selective_search();
      else
          system('./Selective_Search/fetch_selective_search.sh');
      end
      addpath(fullfile(curdir,'Selective_Search/SelectiveSearchCodeIJCV'));
      addpath(fullfile(curdir,'Selective_Search/SelectiveSearchCodeIJCV/Dependencies'));
    end

    fprintf('Selective_Search startup done\n');
end