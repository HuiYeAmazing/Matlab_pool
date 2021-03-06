clear all
close all
clc

in_way = 'E:\\Ye_data\\BGC_input\\ADD_var';
output_way = 'E:\\Ye_data\\BGC_input\\sitec\\11';

ff = sprintf('%s\\exm.sitec',in_way);
M = importdata(ff);
% M = cellstr(M);

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
fileunit1 = sprintf('%s\\%s',in_way,'so_sand.grd');
ftp1 = fopen(fileunit1, 'r');
x1 = fread(ftp1, S, 'float32');
fclose(ftp1);
x1 = x1';

%         figure(1)
%         imagesc(x1);          
%         读入soil silt
fileunit2 = sprintf('%s\\%s',in_way,'so_silt.grd');
ftp2 = fopen(fileunit2, 'r');
x2 = fread(ftp2, S, 'float32');
fclose(ftp2);
x2 = x2';

%         figure(2)
%         imagesc(x2);        
%         读入soil clay
fileunit3 = sprintf('%s\\%s',in_way,'so_clay.grd');
ftp3 = fopen(fileunit3, 'r');
x3 = fread(ftp3, S, 'float32');
fclose(ftp3);
x3 = x3';

%         figure(3)
%         imagesc(x3);
%         读入
fileunit4 = sprintf('%s\\%s',in_way,'dem_cal.grd');
ftp4 = fopen(fileunit4, 'r');
x4 = fread(ftp4, S, 'float32');
fclose(ftp4);
x4 = x4';
%         x4 = vpa(x4,3);


%         figure(4)
%         imagesc(x4);
%         读入
fileunit5 = sprintf('%s\\%s',in_way,'lat.grd');
ftp5 = fopen(fileunit5, 'r');
x5 = fread(ftp5, S, 'float32');
fclose(ftp5);
x5 = x5';

%         figure(5)
%         imagesc(x5);
%         读入
fileunit6 = sprintf('%s\\%s',in_way,'albedo_cal.grd');
ftp6 = fopen(fileunit6, 'r');
x6 = fread(ftp6, S, 'float32');
fclose(ftp6);
x6 = x6';

%         figure(6)
%         imagesc(x6);
%         读入
fileunit7 = sprintf('%s\\%s',in_way,'pft_cal.grd');
ftp7 = fopen(fileunit7, 'r');
x7 = fread(ftp7, S, 'float32');
fclose(ftp7);
x7 = x7';
       
        
         %       建立文本，输入数据
for nx = 1:30
%  for nx = 1:150
    for ny = 1:ncolumn
        if mask(nx,ny) ~= -9999;
            f1 = num2str(x1(nx,ny));
            M(3,1:length(f1)) = f1;
            
            f2 = num2str(x2(nx,ny));
            M(4,1:length(f2)) = f2; 
            
            f3 = num2str(x3(nx,ny));
            M(5,1:length(f3)) = f3; 
            
            f4 = num2str(x4(nx,ny));
            M(6,1:length(f4)) = f4; 
            
            f5 = num2str(x5(nx,ny));
            M(7,1:length(f5)) = f5; 
            
            f6 = num2str(x6(nx,ny));
            M(8,1:length(f6)) = f6; 
            
            f7 = num2str(x7(nx,ny));
            M(9,1:length(f7)) = f7; 
            
            f2 = num2str(x2(nx,ny));
            M(10,1:length(f4)) = f2;
            
            f2 = num2str(x2(nx,ny));
            M(11,1:length(f4)) = f2; 
            

%         xx1 = strcat(num2str(x1(nx,ny)),'		(%)		sand percentage by volume in rock-free soil');
%         xx2 = strcat(num2str(x2(nx,ny)),'		(%)		silt percentage by volume in rock-free soil');
%         xx3 = strcat(num2str(x3(nx,ny)),'		(%)		clay percentage by volume in rock-free soil');
%         
%         xx4 = strcat(num2str(x4(nx,ny)),'		(m)		site elevation');
%         f4 = num2str(x4(nx,ny));
%         xx4 = '      		(m)		site elevation';
%         xx4(1:length(f4)) = f4;
%         xx5 = strcat(num2str(x5(nx,ny)),' 		(degrees)   	site latitude (- for N.Hem.)');       
%         xx6 = strcat(num2str(x6(nx,ny)),'		(DIM)       	site shortwave albedo');              
%         xx7 = strcat(num2str(x7(nx,ny)),'		(dim)      	PFT');
%         xx1 = x1(nx,ny);
%         xx2 = x2(nx,ny);
%         xx3 = x3(nx,ny);
%         xx4 = x4(nx,ny);
%         xx5 = x5(nx,ny);
%         xx6 = x6(nx,ny);
%         xx7 = x7(nx,ny);
%         s1 = '		(%)		sand percentage by volume in rock-free soil';
%         s2 = '		(%)		silt percentage by volume in rock-free soil';
%         s3 = '		(%)		clay percentage by volume in rock-free soil';
%         s4 = '		(m)		site elevation';                             
%         s5 = ' 		(degrees)   	site latitude (- for S.Hem.)';       
%         s6 = '		(DIM)       	site shortwave albedo';              
%         s7 = '		(dim)      	PFT';

    
%         M = cellstr(M);
        ftxt = sprintf('%s\\%d_%d.sitec', output_way,nx,ny);
        ftp = fopen(ftxt, 'w');
        save(ftxt,M);
%     fprintf(ftp,'%s\r\n%.3f%s\r\n%.3f%s\r\n%.3f%s\r\n%.3f%s\r\n%.3f%s\r\n%.3f%s\r\n%s\r\n%d%s ',title,xx1,s1,xx2,s2,xx3,s3,xx4,s4,xx5,s5,xx6,s6,know_var,xx7,s7);
%         fprintf(ftp,'%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s\r\n%s ',title,xx1,xx2,xx3,xx4,xx5,xx6,know_var,xx7);
        fclose(ftp);
%         clear xx1 xx2 xx3 xx4 xx5 xx6 xx7; 
        end
    end
end

        
        
        
        