clear all
close all
clc

inway = 'E:\Ye_data\BGC_input40km\BGC_output\outputco2';
outway = 'E:\Ye_data\BGC_input40km\BGC_output\yrfloatco2';
disp('dbf')

%дͷ�ļ�
npixels = 101;
nlines = 64;
xll = -2187359.553; %left
yll = 3482505.166; %bottom
cellsize = 40000;
NODATA_value = -9999;
byteorder = 'LSBFIRST';

%����ģ������ļ�
list = dir('E:\Ye_data\BGC_input40km\BGC_output\outputco2\*.annout.ascii');
ff_m = list(1).name;
ftp_m = sprintf('%s\\%s',inway,ff_m);
fmask = textread(ftp_m);
[m,n] = size(fmask);
% clear ff_m ftp_m fmask;
yrs = m;

 
C = -9999 * ones(npixels,nlines); 
for var = 5 : 8   %����������var
    for yr = 1 : yrs
            for num = 1:length(list) %�ռ�����
                ff = list(num).name;
                [s1,remain1] = strtok(ff,'_');
                [remain2,remain3] = strtok(remain1,'_');
                [s2,remain4] = strtok(remain2,'.');
                 
                x = str2num(s1);  %�ռ����к�
                y = str2num(s2); %�ռ����к�
%                y = str2double(s2(2:length(s2)-6)); %�ռ����к�
    %             fid1 = fopen(strtrim(strcat(inway,'\',ff)),'r');
    %             temp1 = fread(fid1,S,'double');
    %             fclose(fid1);
                ftp = sprintf('%s\\%s',inway,ff);
                site = textread(ftp);
    %             [k,j] = size(site);
                C(y,x) = site(yr,var);
            end
            BG_d =sprintf('%s\\var%d_%d',outway, var, yr);
            fid =fopen(BG_d,'wb'); %��Ͽռ��ĵ�һ
            fwrite(fid,C,'float32');
            fclose(fid);
            
            writegrdhdr(BG_d, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder);

    end
      
end
disp('Congratulations')


