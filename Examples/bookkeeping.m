% Bookkeeping model__edit by HuiYe20130912
% This program will be used to calculate the soil carbon balance of cropland in Central Asia
close all
clear all
clc;

inway = 'E:\YeHui_Zone\工作数据库\新疆耕地变化对区域碳平衡的影响';
outway = 'E:\YeHui_Zone\工作数据库\新疆耕地变化对区域碳平衡的影响T';

ff = sprintf('%s\\新疆新增耕地构成及面积.xlsx', inway);

kaz = xlsread(ff,'历年耕地来源构成及其面积','A3:G33');

ft_cp_kaz = kaz(:,2);          %提取出由林地转移为耕地的面积,单位面积为公顷（ha）
gs_cp_kaz = kaz(:,3);          %提取出由草地转移为耕地的面积,单位面积为公顷（ha）
sb_cp_kaz = kaz(:,4);          %提取出由灌丛转移为耕地的面积,单位面积为公顷（ha）
dt_cp_kaz = kaz(:,5);          %提取出由裸地转移为耕地的面积,单位面积为公顷（ha）

% %植被碳释放速率
% pcv_ff1 = 13.9272 ;                 %林地转换为耕地情形下,砍伐单位面积林地,氧化速率为1年的碳储量 单位10^6g/ha(t/ha)
% pcv_ff5 = 1.9896 ;                  %林地转换为耕地情形下,砍伐单位面积林地,氧化速率为5年的碳储量 单位10^6g/ha(t/ha)
% pcv_ff15 = 11.606 ;                 %林地转换为耕地情形下,砍伐单位面积林地时氧化速率为15年的碳储量 单位10^6g/ha(t/ha)
% pcv_sf1 = 0.6682 ;                  %灌丛转换为耕地情形下,砍伐单位面积灌丛时氧化速率为1年的碳储量 单位10^6g/ha(t/ha)
% pcv_sf5 = 3.084;                    %灌丛转换为耕地情形下,砍伐单位面积灌丛时氧化速率为5年的碳储量 单位10^6g/ha(t/ha)
% pcv_sf15 = 0.257;                   %灌丛转换为耕地情形下,砍伐单位面积灌丛时氧化速率为15年的碳储量 单位10^6g/ha(t/ha)
% pcv_gf1 = 2.0808;                   %草地转换为耕地情形下,单位面积山地干草原上氧化速率为1年的碳储量 单位10^6g/ha(t/ha)
% pcv_df1 = 0.2805;                   %裸地转换为耕地情形下,单位面积上氧化速率为1年的碳储量 单位10^6g/ha(t/ha)
% Biomass_crop = 8.06;                %耕地单位面积植被碳储量单位10^6g/ha(t/ha)

 %土壤碳释放量
ft_cp_kaz_1 = 9.0972 ; %林地转换为耕地情形下，前15年单位面积上土壤碳释放量 单位10^6g/ha(t/ha)
ft_cp_kaz_2 = 0.87   ; %林地转换为耕地情形下，后16-30年单位面积上土壤碳释放量 单位10^6g/ha(t/ha)
gs_cp_kaz_1 = -4.5292; %草地转换为耕地情形下，前5年单位面积上土壤碳释放量 单位10^6g/ha(t/ha)
gs_cp_kaz_2 = -9.5008; %草地转换为耕地情形下，后6-20年单位面积上土壤碳释放量 单位10^6g/ha(t/ha)
sb_cp_kaz_1 = -4.5292; %灌丛转换为耕地情形下，前五年单位面积上土壤碳释放量 单位10^6g/ha(t/ha) 
sb_cp_kaz_2 = -1.42  ; %灌丛转换为耕地情形下，后6-10年单位面积上土壤碳释放量 单位10^6g/ha(t/ha) 
dt_cp_kaz_1 = -6.2105; %裸地转换为耕地情形下，前5年单位面积上土壤碳释放量 单位10^6g/ha(t/ha)
dt_cp_kaz_2 = -1.62  ; %裸地转换为耕地情形下，后6-10年单位面积上土壤碳释放量 单位10^6g/ha(t/ha) 

%1975-2005土地利用变话引起的碳净增量，包括植被和土壤碳
%植被碳释放速率
%林地转变为耕地植被碳释放速率 
%length = length(data_ff);          %获取有土地利用变化数据的年限长度
% Pemmission_ff1 = zeros(46,1);         %Pemmission_ff1表示，林地转化为耕地情形下，历年氧化速率为1yr的碳释放量
% Pemmission_ff = zeros(46,1);          %Pemmission_ff表示，林地转化为耕地情形下，历年所有氧化速率的碳释放量（包括1yr，5yr，15yr）.
% ff = zeros(46,1);                   %ff为临时矩阵
% for i = 1:31
%     Pemmission_ff1(i,1) = data_ff(i,1)*pcv_ff1; %获取第i年林地转化为耕地情形下，氧化速率为1yr的移走生物量释放的碳量
%     d = i+14;
%     Pemmission_ff15annual = zeros(46,1); %Pemission_ff15annual 表示在i年林地转化为耕地情形下，氧化速率为15yr的移走生物量在i：i+14年的时间段内释放的碳量 
%     Pemmission_ff15annual(i:d,1) = data_ff(i,1)*pcv_ff15 / 15;  %第i年林地转移为耕地的情形下，使1:i+14年间每年碳释放速率
%     f = i+4;
%     Pemmission_ff5annual = zeros(46,1); %Pemission_ff5annual 表示在i年林地转化为耕地情形下，氧化速率为5yr的移走生物量在i：i+4年的时间段内释放的碳量 
%     Pemmission_ff5annual(i:f,1) = data_ff(i,1)*pcv_ff5 / 5;  %第i年林地转移为耕地的情形下，使1:i+4年间每年碳释放速率
%     ff = ff + Pemmission_ff15annual+Pemmission_ff5annual;    %累加1975-2005年林地转移为耕地情形下，氧化速率为5yr的移走生物量每年引起的植被碳储量
% end
%     Pemmission_ff = ff+ Pemmission_ff1; 

%土壤碳释放速率
%林地转化为耕地土壤碳释放量
yr = 31;
j = 1;
ES_soc1_kaz = zeros(60,1);
 %Semission_ff表示在i年，林地转化为耕地情形下,在i:i+29年间每年土壤碳释放量
for i = 1:yr
    ES_ft_cp_kaz = zeros(60,1);
    n = i + 14;
    ES_ft_cp_kaz(i:n,1) = ft_cp_kaz(i,1) .* ft_cp_kaz_1 ./ 15;  %在i年林地转化为耕地情形下，使i:i+14年间每年碳释放量
    n = n + 1;
    m = i + 29;
    ES_ft_cp_kaz(n:m,1) = ft_cp_kaz(i,1) .* ft_cp_kaz_2 ./ 15;  %在i年林地转化为耕地情形下，使i+15:i+29年间每年碳释放量
           %累加1975-2005年31年间林地转移为耕地情形下，逐年土壤碳释放量
    ES_soc1_kaz = ES_ft_cp_kaz + ES_soc1_kaz;      
end
    
    Es_ft_cp_kaz = ES_ft_cp_kaz + ES_soc_kaz;

   











