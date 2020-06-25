clear all
close all
clc

in_way = 'E:\Ye_data\BGC_input40km\sitec\bin';
output_way = 'E:\Ye_data\BGC_input40km\BGC_input\sitec';

%输入行列号,
% % % 修改
nrow = 87;
ncolumn = 167;
S = [ncolumn nrow];

% mask数据
fmask = sprintf('%s\\%s','E:\Ye_data\BGC_input40km\mask','mask40all.bin');
ftp0 = fopen(fmask, 'r');
mask = fread(ftp0, S, 'float32');
fclose(ftp0);
mask = mask';

        title = sprintf('SITE		(keyword)	start of site physical constants block\r\n1.0		(m)		effective soil depth (corrected for rock fraction)');

%         读入soil depth
        fileunit1 = sprintf('%s\\%s',in_way,'sand.bin');
        ftp1 = fopen(fileunit1, 'r');
        x1 = fread(ftp1, S, 'float32');
        fclose(ftp1);
        x1 = x1';
         
%         读入soil silt
        fileunit2 = sprintf('%s\\%s',in_way,'silt.bin');
        ftp2 = fopen(fileunit2, 'r');
        x2 = fread(ftp2, S, 'float32');
        fclose(ftp2);
        x2 = x2';
    
%         读入soil clay
        fileunit3 = sprintf('%s\\%s',in_way,'clay.bin');
        ftp3 = fopen(fileunit3, 'r');
        x3 = fread(ftp3, S, 'float32');
        fclose(ftp3);
        x3 = x3';
               
%         读入
        fileunit4 = sprintf('%s\\%s',in_way,'dem.bin');
        ftp4 = fopen(fileunit4, 'r');
        x4 = fread(ftp4, S, 'float32');
        fclose(ftp4);
        x4 = x4';

        %         读入
        fileunit5 = sprintf('%s\\%s',in_way,'lat.bin');
        ftp5 = fopen(fileunit5, 'r');
        x5 = fread(ftp5, S, 'float32');
        fclose(ftp5);
        x5 = x5';

%         读入
        fileunit6 = sprintf('%s\\%s',in_way,'albedo.bin');
        ftp6 = fopen(fileunit6, 'r');
        x6 = fread(ftp6, S, 'float32');
        fclose(ftp6);
        x6 = x6';
          
%         读入
        fileunit7 = sprintf('%s\\%s',in_way,'pft.bin');
        ftp7 = fopen(fileunit7, 'r');
        x7 = fread(ftp7, S, 'float32');
        fclose(ftp7);
        x7 = x7';


 know_var = sprintf('0.0001		(kgN/m2/yr) 	wet+dry atmospheric deposition of N\r\n0.0004    	(kgN/m2/yr) 	symbiotic+asymbiotic fixation of N');

 
 %       建立文本，输入数据
for nx = 1:nrow
%  for nx = 1:150
    for ny = 1:ncolumn
        if mask(nx,ny) ~= -9999;
         xx1 = double(x1(nx,ny));
         xx2 = double(x2(nx,ny));
         xx3 = double(x3(nx,ny));
         xx4 = double(x4(nx,ny));
         xx5 = double(x5(nx,ny));
         xx6 = double(x6(nx,ny));
         xx7 = double(x7(nx,ny));
         s1 = ' (%) sand percentage by volume in rock-free soil';
         s2 = ' (%) silt percentage by volume in rock-free soil';
         s3 = ' (%) clay percentage by volume in rock-free soil';
         s4 = ' (m) site elevation';                             
         s5 = ' (degrees) site latitude (- for S.Hem.)';       
         s6 = ' (DIM) site shortwave albedo';              
         s7 = ' (dim) PFT';
         
        ftxt = sprintf('%s\\%d_%d.sitec', output_way,nx-1,ny-1);
        ftp = fopen(ftxt, 'a');
%         save(ftxt, 'xx1', 's1','xx2', 's2', 'xx3', 's3', 'xx4', 's4', 'xx5', 's5', 'xx6', 's6', 'xx7', 's7','-ASCII','-double');
        
      fprintf(ftp,'%s\r\n%.3f%s\r\n%.3f%s\r\n%.3f%s\r\n%.3f%s\n\r%.3f%s\n\r%.3f%s\n\r%s\r\n%d%s',title,xx1,s1,xx2,s2,xx3,s3,xx4,s4,xx5,s5,xx6,s6,know_var,xx7,s7);
%     fprintf(ftp,'%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s ',title,xx1,xx2,xx3,xx4,xx5,xx6,know_var,xx7);
        fclose(ftp);
        clear xx1 xx2 xx3 xx4 xx5 xx6 xx7; 
        end
    end
end





