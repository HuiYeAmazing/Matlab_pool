clear all
close all
clc

inway = 'E:\Ye_data\BGC_input40km\BGC_output\output1119';
outway = 'E:\Ye_data\BGC_input40km\BGC_output\yrfloat1119';

%写头文件
npixels = 167;
nlines = 87;
xll = -3327864.32795; %left
yll = 3040516.19325; %bottom
cellsize = 40000;
NODATA_value = -9999;
byteorder = 'LSBFIRST';

%读入模型输出文件
list = dir('E:\Ye_data\BGC_input40km\BGC_output\output1027\*.dayout.ascii');
ff_m = list(1).name;
ftp_m = sprintf('%s\\%s',inway,ff_m);
fmask = textread(ftp_m);
[m n] = size(fmask);
clear ff_m ftp_m fmask;
yrs = m / 365;
 
C = -9999 * ones(npixels,nlines); 
for var = 12 : 12  %变量个数，var
    for yr = 1 : 1
        dys = 365 * (yr - 1) + 1;
        dye = 365 * yr;
        temp = 0;
        for day = dys : dye    %模型输出结果的天数所在行 
            for num = 1:length(list) %空间点个数
                ff = list(num).name;
%                 [s1,s2] = strtok(ff,'_');
%                 x = str2double(s1);  %空间点的行号
                [s1,remain1] = strtok(ff,'_');
                [remain2,remain3] = strtok(remain1,'_');
                [s2,remain4] = strtok(remain2,'.');
                 
                x = str2double(s1);  %空间点的行号
                y = str2double(s2); %空间点的列号
%                  y = str2double(s2(2:length(s2)-6)); %空间点的列号
    %             fid1 = fopen(strtrim(strcat(inway,'\',ff)),'r');
    %             temp1 = fread(fid1,S,'double');
    %             fclose(fid1);
                ftp = sprintf('%s\\%s',inway,ff);
                site = textread(ftp);
    %             [k,j] = size(site);
                C(x,y) = site(day,var);
                disp('c')
            end 
                temp = C + temp;
                disp('c-temp')
  
        end
               
            Y = temp;
            disp('y')
            BG_d =sprintf('%s\\var%d_%d',outway, var, yr);
            fid =fopen(BG_d,'wb'); %组合空间点的第一天
            fwrite(fid,Y);
            fclose(fid);
            
            writegrdhdr(BG_d, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder);

    end
end

