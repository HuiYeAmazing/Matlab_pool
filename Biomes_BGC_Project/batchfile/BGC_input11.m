%%
close all,clear all
clc
% Input data
in_way1 = 'E:\\yeh_mdata\2003float';
in_way2 = 'E:\\yeh_mdata\pre_8km_mbin';
% 
% list = dir(sprintf('%s\\%c.grd',in_way,'*'));

output_way = 'E:\\yeh_mdata\prec_8km_dascii';

% Sz_data=size(dataset);
% col=Sz_data(2);
% row=Sz_data(1);

% 40公里数据行列值
nrows_40km = 87;
ncols_40km = 167;
S_40km =[ncols_40km nrows_40km];

% 8公里数据行列值
nrows_8km = 435;
ncols_8km = 835;
S_8km = [ncols_8km nrows_8km];


yrs = 2003;
yre = 2003;

% ratio = zeros(1,365);

% for j = 1:365
%     copyfile('E:\temp\test\prec1.hdr',strcat('E:\temp\2003_8km_day\prec_d',num2str(j),'.hdr'),'f');
% end

 B_40 = zeros(ncols_40km,nrows_40km,365);
 R_40 = zeros(ncols_40km,nrows_40km,365);
 R_8 = zeros(ncols_8km,nrows_8km);
 B_8m =zeros(ncols_8km,nrows_8km);
 B_8d =zeros(ncols_8km,nrows_8km);
 B_8d365 = zeros(ncols_8km,nrows_8km,365);
 Sum_month  = zeros(ncols_40km,nrows_40km,1);
for nday = 1:365
    
     fileunit_40km = sprintf('%s\\%s%d%s',in_way1,'prec_2003d',nday,'.grd');
     ftp_40km = fopen(fileunit_40km, 'r');
     xdata_40km = fread(ftp_40km,S_40km,'float32');
     
     B_40(:,:,nday)=reshape(xdata_40km,[ncols_40km,nrows_40km,1]);
     Sum_month = Sum_month + B_40(:,:,nday);
     
     if nday == 31
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',1,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=1:31
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
       fclose(ftp_8km);
     end
     
     if nday == 59
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',2,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=32:59
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
       fclose(ftp_8km);
     end
     
     if nday == 90
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',3,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=60:90
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
       fclose(ftp_8km);
     end
     
     if nday == 120
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',4,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=91:120
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
       fclose(ftp_8km);
      end
     
    if nday == 151
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',5,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=121:151
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
       fclose(ftp_8km);
    end
     
    if nday == 181
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',6,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=152:181
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
       fclose(ftp_8km);
    end
     
    if nday == 212
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',7,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=182:212
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       fclose(ftp_8km);
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
    end
     
    if nday == 243
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',8,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=213:243
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
       fclose(ftp_8km);
    end
    
    if nday == 273
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',9,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=244:273
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       fclose(ftp_8km);
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
    end
    
   if nday == 304
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',10,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=274:304
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       fclose(ftp_8km);
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
   end
   
   if nday == 334
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',11,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=305:334
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       fclose(ftp_8km);
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
   end
   
   if nday == 365
       fileunit_8km = sprintf('%s\\%s%d%s%',in_way2,'prec',12,'.grd');
       ftp_8km = fopen(fileunit_8km,'r');
       xdata_8km = fread(ftp_8km,S_8km,'float32'); 
       B_8m(:,:) = xdata_8km; 
       for j=335:365
          R_40(:,:,j)=B_40(:,:,j) ./ Sum_month; 
          R_8 = Fun_resize(R_40(:,:,j));
          B_8d = B_8m .* R_8;
          B_8d365(:,:,j)=reshape(B_8d,[ncols_8km,nrows_8km,1]);
          ftxt = sprintf('%s\\%s%d', output_way,'prec_d',j);
%           ftp = fopen(ftxt, 'wb');  
%           fwrite(ftp,xdata_8km,'float32');
          ftp = fopen(ftxt, 'w');  
          save(ftxt,'xdata_8km','-ASCII');
          fclose(ftp);
       end
       fclose(ftp_8km);
       Sum_month  = zeros(ncols_40km,nrows_40km,1);
   end
   
   fclose(ftp_40km);
end
Display_image(B_40,B_8m,B_8d,R_8,B_8d365);





