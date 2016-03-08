function edgeboxes_build(OS)
%EDGEBOXES_BUILD Summary of this function goes here
% OS = Linux/Windows 
if ~exist('Edge_Boxes/edges-master/private/edgesDetectMex.mexa64')
    if strcmp(OS, 'Linux') || isempty(OS)
      mex Edge_Boxes/edges-master/private/edgesDetectMex.cpp -outdir private '-DUSEOMP' CXXFLAGS="\$CXXFLAGS -fopenmp" LDFLAGS="\$LDFLAGS -fopenmp"
      mex Edge_Boxes/edges-master/private/edgesNmsMex.cpp    -outdir private '-DUSEOMP' CXXFLAGS="\$CXXFLAGS -fopenmp" LDFLAGS="\$LDFLAGS -fopenmp"
      mex Edge_Boxes/edges-master/private/spDetectMex.cpp    -outdir private '-DUSEOMP' CXXFLAGS="\$CXXFLAGS -fopenmp" LDFLAGS="\$LDFLAGS -fopenmp"
      mex Edge_Boxes/edges-master/private/edgeBoxesMex.cpp   -outdir private    
    elseif strcmp(OS, 'Windows')
      mex Edge_Boxes/edges-master/private/edgesDetectMex.cpp -outdir private '-DUSEOMP' 'OPTIMFLAGS="$OPTIMFLAGS' '/openmp"'
      mex Edge_Boxes/edges-master/private/edgesNmsMex.cpp    -outdir private '-DUSEOMP' 'OPTIMFLAGS="$OPTIMFLAGS' '/openmp"'
      mex Edge_Boxes/edges-master/private/spDetectMex.cpp    -outdir private '-DUSEOMP' 'OPTIMFLAGS="$OPTIMFLAGS' '/openmp"'
      mex Edge_Boxes/edges-master/private/edgeBoxesMex.cpp   -outdir private    
    end
end
end

