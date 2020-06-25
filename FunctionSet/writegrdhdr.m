function writegrdhdr(fname, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder)
% ncols         1219
% nrows         902
% xllcorner     -1834039.9590079
% yllcorner     3435361.5854977
% cellsize      999.92870000005
% NODATA_value  -9999
% byteorder     LSBFIRST

fp = fopen(sprintf('%s.hdr', fname), 'w');
fprintf(fp, 'ncols         %d\n', npixels);
fprintf(fp, 'nrows         %d\n', nlines);
fprintf(fp, 'xllcorner     %f\n', xll);
fprintf(fp, 'yllcorner     %f\n', yll);
fprintf(fp, 'cellsize      %f\n', cellsize);
fprintf(fp, 'NODATA_value  %f\n', NODATA_value);
fprintf(fp, 'byteorder     %s\n', byteorder);
fclose(fp);

% Projection    ALBERS                                                            
% Zunits        NO                                                                
% Units         METERS                                                            
% Spheroid      CLARKE1866                                                        
% Xshift        0.0000000000                                                      
% Yshift        0.0000000000                                                      
% Parameters                                                                      
%  25  0  0.000 /* 1st standard parallel                                          
%  47  0  0.000 /* 2nd standard parallel                                          
%  110  0  0.000 /* central meridian                                              
%  0  0  0.000 /* latitude of projection's origin                                 
% 0.00000 /* false easting (meters)                                       
% 0.00000 /* false northing (meters) 
% fp = fopen(sprintf('%s.prj', fname), 'w');
% fprintf(fp, 'Projection    ALBERS\n');
% fprintf(fp, 'Zunits        NO\n');
% fprintf(fp, 'Units         METERS\n');
% fprintf(fp, 'Spheroid      CLARKE1866\n');
% fprintf(fp, 'Xshift        0.0000000000\n');
% fprintf(fp, 'Yshift        0.0000000000\n');
% fprintf(fp, 'Parameters\n');
%---------------------------------------------------
% fp = fopen(sprintf('%s.prj', fname), 'w');
% fprintf(fp, 'Projection    ALBERS\n');
% fprintf(fp, 'Zunits        NO\n');
% fprintf(fp, 'Units         METERS\n');
% fprintf(fp, 'Spheroid      WGS84\n');
% fprintf(fp, 'Xshift        0.0000000000\n');
% fprintf(fp, 'Yshift        0.0000000000\n');
% fprintf(fp, 'Parameters\n');
%---------------------------------------------
fp = fopen(sprintf('%s.prj', fname), 'w');
fprintf(fp, 'Projection    GEOGRAPHIC\n');
fprintf(fp, 'Datum      WGS84\n');
fprintf(fp, 'Spheroid      WGS84\n');
fprintf(fp, 'Units         DD\n');
fprintf(fp, 'Zunits        NO\n');
% fprintf(fp, 'Xshift        0.0000000000\n');
% fprintf(fp, 'Yshift        0.0000000000\n');
fprintf(fp, 'Parameters\n');
fclose(fp);







