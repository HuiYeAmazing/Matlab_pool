clear all
close all
clc

in_way = 'E:\Ye_data\BGC_input40km\gradata\bin';
output_way = 'E:\Ye_data\BGC_input40km\BGC_input\gradata';

%输入行列号
nrow = 87;
ncolumn = 167;
S = [ncolumn nrow];


fmask = sprintf('%s\\%s','E:\Ye_data\BGC_input40km\mask','mask40_final.grd');
ftp0 = fopen(fmask, 'r');
mask = fread(ftp0, S, 'float32');
fclose(ftp0);
mask = mask';

%         读入soil depth

B = sprintf('XIEG(CAS),Urumqi,China 2010 : Sample input for ALEM Model 1.0\r\nLLEM Model v1.0... OUTPUT Time : Sun Jul 11 11:57:18 2010\r\r\n  Year  Yday     Tmax     Tmin      Tday        Prcp     VPD      Srad	  Daylen\r\n                (deg C)  (deg C)   (deg C)      (cm)     (Pa)    (W m-2)   (s)');

for i = 1:nrow
    for j =1:ncolumn
      if mask(i,j) ~= -9999;
      ftxt = sprintf('%s\\%d_%d', output_way,i-1,j-1);
      fids = fopen(ftxt,'a');
      fprintf(fids,'%s\r\n',B);
      fclose(fids);
      
      end
    end
end

for nyr = 1979:2008
fileunit1 = sprintf('%s\\%s', in_way,'tgrazing.grd');
ftp1 = fopen(fileunit1, 'r');
x1 = fread(ftp1, S, 'float32');
fclose(ftp1);
x1 = x1';

fileunit2 = sprintf('%s\\%s', in_way,'tstart.grd');
ftp2 = fopen(fileunit2, 'r');
x2 = fread(ftp2, S, 'float32');
fclose(ftp2);
x2 = x2';

fileunit3 = sprintf('%s\\%s', in_way,'tend.grd');
ftp3 = fopen(fileunit3, 'r');
x3 = fread(ftp3, S, 'float32');
fclose(ftp3);
x3 = x3';


% fileunite4 = sprintf('%s\\%s%d%s%s',in_way1,'gi',nyr,'_8km','.grd');
fileunit4 = sprintf('%s\\%s%d%s%s',in_way,'gi',nyr,'_40km','.grd');

% fileunit4 = sprintf('%s\\%s',in_way,'mask_stock03.grd');
ftp4 = fopen(fileunit4, 'r');
x4 = fread(ftp4, S, 'float32');
fclose(ftp4);
x4 = x4';


 for nx = 1:nrow
    for ny = 1:ncolumn
        if mask(nx,ny) ~= -9999;
%             if exist()
%             end
        xx1 = [num2str(nyr),' ',num2str(x1(nx,ny)),' ',num2str(x2(nx,ny))...
            ,' ',num2str(x3(nx,ny)),' ',num2str(x4(nx,ny))];
%         xx2 = ['2005', ' ',num2str(x1(nx,ny))];
               
        ftxt = sprintf('%s\\%d_%d', output_way,nx-1,ny-1);
        ftp = fopen(ftxt, 'a');
        fprintf(ftp,'%s\r\n', xx1);
        fclose(ftp); 
        clear xx1;
        end
       
    end
 end
end

 clear all;





