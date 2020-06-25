close all
clear all
clc

% Input data
in_way = 'E:\\Ye_data\\BGC_input\\Meteo';
% 
% list = dir(sprintf('%s\\%c.hdr',in_way,'*'));
%输出路径
output_way = 'E:\\Ye_data\\BGC_input\\meteo\\Meteo24yr\\Mline313';
% data2 = zeros(1,1);


%输入行列号
nrow = 313;
ncolumn = 424;
S = [ncolumn nrow];

fmask = sprintf('%s\\%s','E:\Ye_data\BGC_input\ADD_var','mask.grd');
ftp0 = fopen(fmask, 'r');
mask = fread(ftp0, S, 'float32');
fclose(ftp0);
mask = mask';

% imagesc(mask');
B = sprintf('XIEG(CAS),Urumqi,China 2010 : Sample input for ALEM Model 1.0\r\nLLEM Model v1.0... OUTPUT Time : Sun Jul 11 11:57:18 2010\r\r\n  Year  Yday     Tmax     Tmin      Tday        Prcp     VPD      Srad	  Daylen\r\n                (deg C)  (deg C)   (deg C)      (cm)     (Pa)    (W m-2)   (s)');

for i =81:313
    for j =1:424
      if mask(i,j) ~= -9999;
      ftxt = sprintf('%s\\%d_%d', output_way,i,j);
      fids = fopen(ftxt,'a');
      fprintf(fids,'%s\r\n',B);
      fclose(fids);
      
      end
    end
end

 for nx = 81:313
    for ny = 1:ncolumn
      if mask(nx,ny) ~= -9999;
         for nyr = 1987:2010
           for  nday= 1:365

        %  读入Tmax
        fileunit1 = sprintf('%s\\%s\\%s%d.grd',in_way,'tmax','tmax',nday);
        ftp1 = fopen(fileunit1, 'r');
        x1 = fread(ftp1, S, 'float32');
        fclose(ftp1);
        x1 = x1';
                

%         读入Tmin
        fileunit2 = sprintf('%s\\%s\\%s%d.grd',in_way,'tmin','tmin',nday);
        ftp2 = fopen(fileunit2, 'r');
        x2 = fread(ftp2, S, 'float32');
        fclose(ftp2);
        x2 = x2';
        
%         figure(2)
%         imagesc(x2');        
%         读入Tday
        fileunit3 = sprintf('%s\\%s\\%s%d.grd',in_way,'tmean','tmean',nday);
        ftp3 = fopen(fileunit3, 'r');
        x3 = fread(ftp3, S, 'float32');
        fclose(ftp3);
        x3 = x3';
       

%         读入Prcp
        fileunit4 = sprintf('%s\\%s\\%s%d.grd',in_way,'prec','Prec_d',nday);
        ftp4 = fopen(fileunit4, 'r');
        x4 = fread(ftp4, S, 'float32');
        fclose(ftp4);
        x4 = x4';
        

%         读入VPD
        fileunit5 = sprintf('%s\\%s\\%s%d.grd',in_way,'vpd','vpd_d',nday);
        ftp5 = fopen(fileunit5, 'r');
        x5 = fread(ftp5, S, 'float32');
        fclose(ftp5);
        x5 = x5';

%         读入rads
        fileunit6 = sprintf('%s\\%s\\%s%d.grd',in_way,'rads','rads_2003d',nday);
        ftp6 = fopen(fileunit6, 'r');
        x6 = fread(ftp6, S, 'float32');
        fclose(ftp6);
        x6 = x6';

%         读入daylen
        fileunit7 = sprintf('%s\\%s\\%s%d.grd',in_way,'daylen','daylen_d',nday);
        ftp7 = fopen(fileunit7, 'r');
        x7 = fread(ftp7, S, 'float32');
        fclose(ftp7);
        x7 = x7';
        
                A = [num2str(nyr),' ',num2str(nday),' ',num2str(x1(nx,ny)),' ',num2str(x2(nx,ny))...
                        ,' ',num2str(x3(nx,ny)),' ',num2str(x4(nx,ny))...
                        ,' ',num2str(x5(nx,ny)),' ',num2str(x6(nx,ny))...
                        ,' ',num2str(x7(nx,ny))];
            %         A = [2003,nday,num2str(x1(nx,ny)),' ',num2str(x2(nx,ny))...
            %             ,' ',num2str(x3(nx,ny)),' ',num2str(x4(nx,ny))];
            
                    ftxt = sprintf('%s\\%d_%d', output_way,nx,ny);
                    ftp = fopen(ftxt, 'a');
                    fprintf(ftp,'%s\r\n',A);
                    fclose(ftp);
           end
         end
      end
    end 
end
        clear x1 x2 x3 x4 x5 x6 x7
    
   clear all;


       
