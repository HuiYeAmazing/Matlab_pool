clear all
close all
clc

inway = 'E:\Ye_data\BGC_output\output1119';
outway = 'E:\Ye_data\BGC_output\outgrid1119';

% fid0 = fopen(ftp0,'r');
% fmask = fread(fid0,'float32');
% fclose(ftp0);

% fhdr = sprintf('G:\08_Database\Bgc_input\Binary\exm.hdr');
% fprj = sprintf('G:\08_Database\Bgc_input\Binary\exm.prj');
%дͷ�ļ�
npixels = 424;
nlines = 313;
xll = -2213293.7782;
yll = 3589562.8208721;
cellsize = 8000;
NODATA_value = -9999;
byteorder = 'LSBFIRST';

%����ģ������ļ�
list = dir('E:\Ye_data\BGC_output\output1\*.dayout.ascii');
ff_m = list(1).name;
ftp_m = sprintf('%s\\%s',inway,ff_m);
fmask = textread(ftp_m);
[m n] = size(fmask);
clear ff_m ftp_m fmask;
yrs = m / 365;
 
C = -9999 * ones(npixels,nlines); 
for var = 1 : n   %����������var
    for yr = 1 : yrs
        dys = 365 * (yr - 1) + 1;
        dye = 365 * n;
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
            end
            BG_d =sprintf('%s\\var%02d_%03d',outway, var, day);
            fid =fopen(BG_d,'wb'); %��Ͽռ��ĵ�һ��
            fwrite(fid,C);
            fclose(fid);
            
            writegrdhdr(BG_d, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder);

        end
    end
end
