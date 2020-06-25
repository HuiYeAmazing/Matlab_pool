% This program will be used for read GIMMS-3g data
% Edit by Yehui 20131129
%--------------------------------------
% Data describe
%--------------------------------------
% GIMMS FPAR3g
% Global
% Geographic
% 1/12 degree
% 15 days
% July 1981 to December 2011
% Rows: 2160
% columns: 4320
% 8-bit unsigned integer
% multiby 0.01
% ---------------------------------------
close all;
clear all;
clc;

inway = 'E:\YeHui_Zone\工作数据库\GIMMS';
outway = 'E:\YeHui_Zone\工作数据库\GIMMS-FLOAT';
hd = sprintf('%s\\*.abf', inway);
list = dir(hd);
num = length(list);


gs = [60 3 40 140]; %中亚加中国范围
gp = [(90-gs(1:2))*12 (180+gs(3:4))*12];

%写头文件
npixels = gp(4)-gp(3)+1;
nlines = gp(2)-gp(1)+1;
xll = gs(3);
yll = gs(2);
cellsize = 1/12;
NODATA_value = 255;
byteorder = 'LSBFIRST';

S = [2160 4320];

for i = 1:num
        ff_n = list(i).name;
        ff = sprintf('%s\\%s', inway, ff_n);

            fid = fopen(ff,'r');
        %     M = fread(fid,[days num], 'float32');
        dat = fread(fid, S, 'uint8',0,'ieee-be');
        %     MA = multibandread(ff, S, 'uint8','bsq','ieee-be');
            fclose(fid);
        dat = dat .* 0.01;
        sdat = double(dat(gp(1):gp(2),gp(3):gp(4)));
        
        name = ff_n(13:20);       
            ff1 =sprintf('%s\\AVHR%s',outway, name);
            fid =fopen(ff1,'wb'); 
            fwrite(fid,sdat', 'float32');
            fclose(fid);
         
            writegrdhdr(ff1, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder);
        
        
end
% imagesc(FPAR);