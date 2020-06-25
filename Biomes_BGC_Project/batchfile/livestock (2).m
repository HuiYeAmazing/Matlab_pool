clear all
close all
clc

in_way = 'E:\\Ye_data\\BGC_input\\ADD_var\\livestock';
output_way = 'E:\\Ye_data\\BGC_input\\gradata1';

%输入行列号
nrow = 313;
ncolumn = 424;
S = [ncolumn nrow];


fmask = sprintf('%s\\%s','E:\Ye_data\BGC_input\ADD_var','mask.grd');
ftp0 = fopen(fmask, 'r');
mask = fread(ftp0, S, 'float32');
fclose(ftp0);
mask = mask';

%         读入soil depth

B = sprintf('XIEG(CAS),Urumqi,China 2010 : Sample input for ALEM Model 1.0\r\nLLEM Model v1.0... OUTPUT Time : Sun Jul 11 11:57:18 2010\r\r\n  Year  Yday     Tmax     Tmin      Tday        Prcp     VPD      Srad	  Daylen\r\n                (deg C)  (deg C)   (deg C)      (cm)     (Pa)    (W m-2)   (s)');
% str = 'E:\Ye_data\BGC_input\hdr\hdr.txt';
% fidh=fopen(str);
% datah = fread(fidh);
% fclose(fidh);

% xm = x1(:);

% for year = yrs:yre
for i =1:313
    for j =1:424
      if mask(i,j) ~= -9999;
      ftxt = sprintf('%s\\%d_%d', output_way,i,j);
      fids = fopen(ftxt,'a');
      fprintf(fids,'%s\r\n',B);
      fclose(fids);
      
      end
    end
end

fileunit1 = sprintf('%s\\%s','E:\Ye_data\BGC_input\ADD_var','tgrazing.grd');
ftp1 = fopen(fileunit1, 'r');
x1 = fread(ftp1, S, 'float32');
fclose(ftp1);
x1 = x1';

fileunit2 = sprintf('%s\\%s','E:\Ye_data\BGC_input\ADD_var','tstart.grd');
ftp2 = fopen(fileunit2, 'r');
x2 = fread(ftp2, S, 'float32');
fclose(ftp2);
x2 = x2';

fileunit3 = sprintf('%s\\%s','E:\Ye_data\BGC_input\ADD_var','tend.grd');
ftp3 = fopen(fileunit3, 'r');
x3 = fread(ftp3, S, 'float32');
fclose(ftp3);
x3 = x3';

fileunit4 = sprintf('%s\\%s',in_way,'mask_stock03.grd');
ftp4 = fopen(fileunit4, 'r');
x4 = fread(ftp4, S, 'float32');
fclose(ftp4);
x4 = x4';


 for nx = 1:313
    for ny = 1:ncolumn
        if mask(nx,ny) ~= -9999;
%             if exist()
%             end
        xx1 = ['2003',' ',num2str(x1(nx,ny)),' ',num2str(x2(nx,ny))...
            ,' ',num2str(x3(nx,ny)),' ',num2str(x4(nx,ny))];
%         xx2 = ['2005', ' ',num2str(x1(nx,ny))];
               
        ftxt = sprintf('%s\\%d_%d', output_way,nx,ny);
        ftp = fopen(ftxt, 'a');
        fprintf(ftp,'%s', xx1);
        fclose(ftp); 
        clear xx1;
        end
       
    end
 end

 clear all;





