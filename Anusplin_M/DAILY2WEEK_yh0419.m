close all
clear all
clc
%% Include 4 prceduals that are (1) Check missing values and remove them; 

iway = 'E:\YeHui_Zone\工作数据库\GHCND20140828\'; 
% outway = 'F:\Yehui';
var = {'PRCP';'TMIN';'TMAX';'TEM';'WIN';'RHU';'SSD';'WVP'};
fs = [iway 'GHCN_CHINA_DEM_ACEA-ed.txt'];
[no, id, lon, lat, elv, dem, dflg] = textread(fs,'%d%s%f%f%f%f%d');
gid = cell2mat(id);
geo = [lon lat dem];

fi = 'F:\Yehui\CMGH2013\'; 
yr1 = 1981;
yr2 = 1981;
rps = [1 1 1 0 0];   % reprocess
tic

NV = 7;
for v = 1 : 1  % {'PRCP';'TMIN';'TMAX';'TEM';'WIN';'RHU';'SSD';'WVP'};
    varname = var{v};
    sub = [fi 'CMGHfilled\' varname];
    if ~exist(sub,'dir')
        system(['mkdir ' sub]);
    end
        
    if v >= 8
        continue;
    end  
    YNS=[];
    for year = yr1: yr2
        days = datenum(year+1,1,1)-datenum(year,1,1);
%         if v <= 4
            fin = [fi varname '\' varname '_' num2str(year) '.txt'];
%         else
%             fin = [fi varname '\' varname '_' num2str(year) '.csv'];
%         end
        if exist(fin,'file')
            disp(['Processing ' varname ' in ' num2str(year)]);

            %% Read daily data for each variable in a year
%             if v <= 4
%                 fip = fopen(fin,'r');
%                 i = 1;
%                 xid = [];
%                 xdt = [];
%                 while fip > 0 && ~feof(fip)
%                    gstr = fscanf(fip,'%s',1);
%                    if ~isempty(gstr)
%                        [gdat] = fscanf(fip,'%d',days+1);
%                        xid(i,:) = char(gstr);
%                        xdt(i,:) = [(gdat)'];
%                        i = i + 1;
%                    end
%                 end
%                 fclose(fip);
%                 xid = char(xid);
%                 % xdt = xdt(:,2:days+1);
%             else
%                 xid = []; xdt = [];
%                 xx = load(fin);
%                 [n m] = size(xx);
%                 for i = 1 : n
%                     xid(i,:) = ['CH0000' num2str(xx(i,1))];
%                 end
%                 xid = char(xid);
%                 xdt = xx(:,2:days+1);
%             end
            [xid, xdt, n] = readghcn(fin,days);
            [ni, mj] = size(xdt);

            if rps(1) == 1
                disp('      REALPREC: Check missing values and remove them');
                %% REALPREC: specific code transfered to precipitation
                %            input:var, xdt(Numstations,days+1)
                %            output: xdt(Numstations, days+1)
                [y0] = realprec(varname(1), xdt);

                % Remove out station the completeness < 0.9
                % Input: xid-stationName, y0(Numstations, days+1)
                % Output: yc(Numstations,
                % days),sd(Numstations),ys(Numsta,mean sum std max min
                % numData)
                [yc, sd, ys] = completeness(xid, y0,0.9,days);
                [nx(1), ~] = size(yc);
                if year == yr1
                    S = sd;
                    Y = ys;
                else
                    S = [S; sd];
                    Y = [Y; ys];
                end

                % Output stations having geographic information
                [yg,sg,yns] = staselect(gid, yc, sd);
                [nx(2), ~] = size(yg);
                [nx(3), ~] = size(yns);
                YNS = [YNS;yns];
                unique(char(YNS),'rows')
                if nx(3) > 0
                    disp('Stations without geoinformation:');
                    disp(char(YNS));
                    disp(size(YNS));
                end

                % Fill missing values
                
                [yf_daily, qc, sta,nx(5)] = fillmissing(sg, yg,gid,geo);
                sta = char(sta);
                [nx(4), tp] = size(yf_daily);
                N(year-yr1+1,:) = [year v nx];
                
                % Write filled data to text file
                outway = 'F:\Yehui\CMGH2013\CMGHfilled\PRCP';
                if ~exist(outway,'dir')
                    system(['mkdir ' outway]);
                end
                writemeteo2text(year, varname,outway,sta,yf_daily);
                outway = 'F:\Yehui\CMGH2013\CMGHfillQC';
                if ~exist(outway, 'dir')
                    system(['mkdir ' outway]);
                end
                writemeteo2text(year, varname,outway,sta,qc);
            end
            %% calculate 8 days mean
%             if rps(2) == 1
%                 disp(['      MEANBYDOY: Calculating 8days mean or sum: ' varname, ' in ' num2str(year)]);
%                 if v == 1
%                     ms = 0;% 0 for sum
%                 else
%                     ms = 1;% 1 for mean
%                 end
%                 [ym_8days, q, sta] = meanbydoy(yf_daily, sta, days, 8, ms);
%                 
%                 % Write result to text file
%                 outway = 'I:\Database\meteo\CMGH8days';
%                 if ~exist(outway, 'dir')
%                     system(['mkdir ' outway]);
%                 end                 
%                 writemeteo2text(year, varname,outway,sta,ym_8days);
%                 
%                 % Write file for Anusplin software
%                 disp(['      CSV2ANUSPL: Output Anusplin file: ' varname ' in ' num2str(year)]);
%                 outway = 'I:\Database\meteo\CMGH8days';
%                 if ~exist(outway, 'dir')
%                     system(['mkdir ' outway]);
%                 end                
%                 csv2Anuspl(year, varname, outway,gid,geo, ym_8days, sta);
%             end
             %% calculate half month mean/sum
            if rps(3) == 1
                disp(['      MEANBYHFMONTH: Calculating Half month mean or sum: ' varname, ' in ' num2str(year)]);
                if v == 1
                    ms = 0;% 0 for sum
                else
                    ms = 1;% 1 for mean
                end
                [ym_hmonth, q, sta] = meanbyhfmonth(yf_daily, sta, year,days, ms);
                
                % Write result to text file
                outway = 'I:\Database\meteo\CMGH15days';
                if ~exist(outway, 'dir')
                    system(['mkdir ' outway]);
                end                
                writemeteo2text(year, varname,outway,sta,ym_hmonth);
                
                % Write file for Anusplin software
                disp(['      CSV2ANUSPL: Output Anusplin file: ' varname ' in ' num2str(year)]);
                outway = 'I:\Database\meteo\CMGH15days';
                if ~exist(outway, 'dir')
                    system(['mkdir ' outway]);
                end                
                csv2Anuspl(year, varname, outway,gid,geo, ym_hmonth, sta);                
            end
           

%             % calcuate regional mean or sum
%             if rps(4) == 1
%                 [yst,qst] = regionalmean(xdt,xid,ms,year,days);
% %                 [yst,qst] = regionalmean(yf,sta,ms,year,days);
%                 if year == yr1
%                     YRS = yst;
%                 else
%                     YRS = [YRS; yst];
%                 end
%             end
        else
            disp(['      REALPREC: Input file not exist: ', fin]);
        end
    end  % LOOP of year
%     if rps(4) == 1
%         if ~exist('I:\Database\meteo\CMCN8days','dir')
%             system('mkdir I:\China8km\Meteosta\CMCN8days');
%         end
%         ff = ['I:\Database\meteo\CMCN8days\' varname '_region_sta_obs.csv'];
%         csvwrite(ff, YRS);
%     end
%     STN_NOGEO(v) = length(YNS);
end % LOOP of variables (j)
disp(STN_NOGEO);
%% MAKESPLINABAT: Produce Anusplin bat file
% if rps(5) == 1
%     % direct data, cmd, grd for write and run annusplin
%     year = [yr1 yr2];
%     direct = {{'meteo/Weekly8012/';'meteo/MeteoGrid8012/TEMP/';'meteo/MeteoGrid8012/'};...
%         {'z:\\meteo\\Weekly8012\\';'z:\\meteo\\MeteoGrid8012\\TEMP\\';'z:\\meteo\\MeteoGrid8012\\'}};
% 
%     makesplinabat(year, direct);
% end
% %% output QC
% if rps(1) == 1
%     fout = [fo varname '/' varname '_' num2str(year) '_filled.csv'];
%     if exist(fout, 'file')% Number of data for each station
%         yr = yr1: yr2;
%         ny = length(yr);
%         D = [yr' qnum(1:ny,:)];
%         csvwrite([fo 'qnum.csv'], D);
%         csvwrite([fo 'qday.csv'], qday);
%         csvwrite([fo 'qsta.csv'], qsta);
%     end
% end
toc