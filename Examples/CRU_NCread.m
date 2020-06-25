% ncbrowser
% This programe is edited by Hui Ye at 2013-1-5.It will be used to read Netcdf Data,and select the region
% in which U interest.
clear all;
close all;
clc
inway = 'F:\01_Paper\Central_Asia\DATA\GIS';
outway = 'F:\01_Paper\Central_Asia\DATA\CRU';
% hd = 'cru_cy_ysum';
% hd = 'cru_ts3.20.2001.2010.tmn.dat';
% hd1 = 'cru_ts3.20.2011.2011.tmn.dat';
hd = 'cru_ts3.20.2001.2010.pre.dat';
hd1 = 'cru_ts3.20.2011.2011.pre.dat';
% var = {'lat','lon','ulwrf'};

% for yr = 1981:2001
    ff = sprintf('%s\\%s.nc', inway,hd);
    ff1 = sprintf('%s\\%s.nc', inway, hd1);
    
    NCID = netcdf.open(ff, 'nowrite');
%     for i = 1:3
%          [{var(i)}(:), xtype, dimids, atts] = netcdf.inqvar(NCID,i);
%     end
       [lat, xtype, dimids, atts] = netcdf.inqvar(NCID,1);
   [varid]                        = netcdf.inqvarid(NCID,lat);
    LAT                           = netcdf.getvar(NCID,varid);
    
    [lon, xtype, dimids, atts] = netcdf.inqvar(NCID,0);
   [varid]                       = netcdf.inqvarid(NCID,lon);
    LON                          = netcdf.getvar(NCID,varid);
    
     [prec, xtype, dimids, atts] = netcdf.inqvar(NCID,3);
    [varid]                        = netcdf.inqvarid(NCID,prec);
     data                         = netcdf.getvar(NCID,varid);
     
    [time, xtype, dimids, atts] = netcdf.inqvar(NCID,2);
    [varid]                        = netcdf.inqvarid(NCID,time);
     TM                         = netcdf.getvar(NCID,varid);

     
%     ncx = NCID{'ulwrf'}(:);     % 获取要从nc文件中提取的变量slp
%     lat=f{'lat'}(:);
%     lon=f{'lon'}(:);
    
    Ni = length(LAT); %数据矩阵行数
    Nj = length(LON); %数据矩阵列数
    
        NCID = netcdf.open(ff1, 'nowrite');
%     for i = 1:3
%          [{var(i)}(:), xtype, dimids, atts] = netcdf.inqvar(NCID,i);
%     end
       [lat, xtype, dimids, atts] = netcdf.inqvar(NCID,1);
   [varid]                        = netcdf.inqvarid(NCID,lat);
    LAT                           = netcdf.getvar(NCID,varid);
    
    [lon, xtype, dimids, atts] = netcdf.inqvar(NCID,0);
   [varid]                       = netcdf.inqvarid(NCID,lon);
    LON                          = netcdf.getvar(NCID,varid);
    
     [prec, xtype, dimids, atts] = netcdf.inqvar(NCID,3);
    [varid]                        = netcdf.inqvarid(NCID,prec);
     xdata                         = netcdf.getvar(NCID,varid);
     
    [time, xtype, dimids, atts] = netcdf.inqvar(NCID,2);
    [varid]                        = netcdf.inqvarid(NCID,time);
     TM                         = netcdf.getvar(NCID,varid);
    
% %     输入所需数据的经纬度范围
%     %--------------------------------
%     %目标数据纬度范围MIN(lat)
%     LAT_low = 30; LAT_up = 50;
%     %目标数据经度范围MIN(lon)
%     LON_left = 80; LON_right = 100;
%     %-----------------------------------
%     
%     %0.25为cellsize,yll和xll为数据中实际起点最小纬度和经度
%     %a,b,c,d为间隔数
%     a = fix((LAT_low - min(LAT)) / 0.25);
%     b = fix((LON_left - min(LON)) / 0.25);
%     c = fix((max(LAT)- LAT_up) / 0.25);
%     d = fix((max(LON)- LON_right) / 0.25);
%     
%     yll = min(LAT) + (a * 0.25); 
%     xll = min(LON) + (b * 0.25);
    
    %     yll_和xll_为数据中实际起点最大纬度和经度
%     yll_ = max(LAT) - (c * 0.25); 
%     xll_ = max(LON) - (d * 0.25);
%     
%         
%     Nii = (1 + c):(Ni - a);%需求数据矩阵的行
%     Njj = (1 + b):(Nj - d);%需求数据矩阵的列
    
    % C为需求数据矩阵
%     C = data(Nii,Njj,:);
    B = data(:,:,(120 - 12 + 1):120);
     
%     C = xdata(:,:,:);
%         ln = length(C);
ln = 12;
    for i = 1:ln
         temp = B(:,:,i); 
         XX(:,i) = temp(:);
         temp1 = xdata(:,:,i);
         YY(:,i) = temp1(:);
    end
    
    clear temp temp1;
    XX = XX';
    YY = YY';
    
    xx = sum(XX);
    yy = sum(YY);
%     nrow = (max(LAT)-min(LAT)) / .25;
%     ncoll = (max(LON)-min(LON)) / .25;
%     max(lat)
%     yll = min(lat)
%     DATA = squeeze(data);
%     max(lon)
%     xll = min(lon)   
    cellsize = .5;
    NODATA_value = -9999;
    byteorder = 'LSBFIRST';
    npixels = Nj;
    nlines = Ni;
    xll = min(LON);
    yll = min(LAT);
%     [dk di dj]=size(ncx);
%     close(f)
%     mymap=[white(1); jet(150)];
%     scale_factor = 0.1;
%     add_offset = 3246.5;
%     nlines = dj;
%     npixels = di;
    % dk = 2;
%   for yr = 2010: 2011  
yr1 = 2010;
yr2 = 2011;
%       num = yr - 2010 + 1;
      B = reshape(xx,Ni,Nj);
      ff = sprintf('%s\\R%d',outway,yr1);
%        x3f = sprintf('%s\\%s%d', x3_way, x3_var,yr * 1000 + nt);
       x3p = fopen(ff, 'wb');
       fwrite(x3p,B, 'float32');
       fclose(x3p);
       writegrdhdr(ff, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder); 
%   end
      B = reshape(yy,Ni,Nj);
      ff = sprintf('%s\\R%d',outway,yr2);
%        x3f = sprintf('%s\\%s%d', x3_way, x3_var,yr * 1000 + nt);
       x3p = fopen(ff, 'wb');
       fwrite(x3p,B, 'float32');
       fclose(x3p);
       writegrdhdr(ff, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder);    
    
%     for yr = 1987: 2009
%         for ny = 1:di
%             for nx = 1:dj
%                 xd(ny, nx) = ncx(nt, ny, nx) * scale_factor + add_offset;
%             end
%         end
%         figure(2)
%         imagesc(xd)
%         colormap(mymap);
%         colorbar('horiz');
%         axis equal
%         axis off
% 
%        x3f = sprintf('%s\\%s%d', x3_way, x3_var,yr * 1000 + nt);
%        x3p = fopen(x3f, 'wb');
%        fwrite(x3p, xd', 'float32');
%        fclose(x3p);
%        writegrdhdr(x3f, nlines, npixels, xll, yll, cellsize, NODATA_value, byteorder);    
%        title(num2str(nt));    
%     end
% end
