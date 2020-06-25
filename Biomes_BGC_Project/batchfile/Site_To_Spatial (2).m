clear all
close all
clc

inway = 'E:\Ye_data\BGC_input40km\BGC_output\output1119';
outway = 'E:\Ye_data\BGC_input40km\BGC_output\yrfloat1119';

%дͷ�ļ�
npixels = 167;
nlines = 87;
xll = -3327864.32795; %left
yll = 3040516.19325; %bottom
cellsize = 40000;
NODATA_value = -9999;
byteorder = 'LSBFIRST';

%����ģ������ļ�
list = dir('E:\Ye_data\BGC_input40km\BGC_output\output1027\*.dayout.ascii');
ff_m = list(1).name;
ftp_m = sprintf('%s\\%s',inway,ff_m);
fmask = textread(ftp_m);
[m n] = size(fmask);
clear ff_m ftp_m fmask;
yrs = m / 365;
 
C = -9999 * ones(npixels,nlines); 
for var = 12 : 12  %����������var
    for yr = 1 : 1
        dys = 365 * (yr - 1) + 1;
        dye = 365 * yr;
        temp = 0;
        for day = dys : dye    %ģ�������������������� 
            for num = 1:length(list) %�ռ�����
                ff = list(num).name;
%                 [s1,s2] = strtok(ff,'_');
%                 x = str2double(s1);  %�ռ����к�
                [s1,remain1] = strtok(ff,'_');
                [remain2,remain3] = strtok(remain1,'_');
                [s2,remain4] = strtok(remain2,'.');
                 
                x = str2double(s1);  %�ռ����к�
                y = str2double(s2); %�ռ����к�
%                  y = str2double(s2(2:length(s2)-6)); %�ռ����к�
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
            fid =fopen(BG_d,'wb'); %��Ͽռ��ĵ�һ��
            fwrite(fid,Y);
            fclose(fid);
            
            writegrdhdr(BG_d, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder);

    end
end

