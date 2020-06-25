close all; clear all; clc;

wks = 'H:\Group\Hui\Qinghai0425\Outputs\Results\sum';
fvg = 'H:\Group\Hui\Qinghai0425\Parameters\vege10_mod1km.flt';
fvp = fopen(fvg, 'r');
veg = fread(fvp, [1219, 902], 'float32');
fclose(fvp);
figure(1); imagesc(veg', [0, 12]);

X = [];
i = 1;
met = {'PRCP','TAVG','TMAX','TMIN','RHU','SSD','WIN','FPAR'};
met_wks = 'H:\Group\Hui\Qinghai0425\MeteoGrid';
fpar_wks = 'H:\Group\Hui\Qinghai0425\FPAR';
i = 1;
for v = 1 : 6
    if v < 6
        sub = [met_wks '\' met{v} '\' met{v} '_'];
    else
        sub = [fpar_wks, '\'];
    end
    j = 1;
    for yr = 2001 : 2017
        for jd = 1 : 8 : 361
            ff = [sub num2str(yr * 1000 + jd) '.flt'];
            fp = fopen(ff, 'r');
            dat = fread(fp, [1219, 902], 'float32');
            fclose(fp);
            
            x = dat(veg == 6);
            bnd = quantile(x, [0.05, 0.95]);
            
            figure(1);
            imagesc(dat', bnd); colorbar;
            X(i,:) = [yr, v,  mean(x), std(x), max(x), min(x), bnd];
            
            G(j,v) = mean(x);
            T(j,1:2) = [yr, jd];
            i = i + 1;
            j = j + 1;
            
        end
        disp([v, yr]);
    end
end
hdr = {'Year','Variable','Mean','Std','Max','Min','Q0.05','Q0.95'};
xlswrite('inputs.xls', hdr, 'All_data','A1');
xlswrite('inputs.xls', X, 'All_data','A2');

hdr = {'Year', 'Jday', 'PRCP','TAVG','TMAX','TMIN','RHU','SSD','WIN','FPAR'};
xlswrite('inputs.xls', hdr, 'mean_data','A1');
xlswrite('inputs.xls', [T,G], 'mean_data','A2');

i = 1;
flx = {'RS','RN','GPP','NPP','ET','Rh'};
for v = 1 : 6
    for yr = 2001 : 2017
        %for jd = 1 : 8 : 361
        ff = [wks '\' flx{v} num2str(yr) '.flt'];
        fp = fopen(ff, 'r');
        dat = fread(fp, [1219, 902], 'float32');
        fclose(fp);
        
        x = dat(veg == 6);
        bnd = quantile(x, [0.05, 0.95]);
        
        figure(1);
        imagesc(dat', bnd); colorbar;
        X(i,:) = [yr, v,  mean(x), std(x), max(x), min(x), bnd];
        
        G(yr-2000,v) = mean(x);
        
        i = i + 1;
        
        %end
        disp([v, yr]);
    end
end
T = (2001:2017)';

hdr = {'Year','RS','RN','GPP','NPP','ET','Rh'};
xlswrite('inputs.xls', hdr, 'mean_data','A1');
xlswrite('inputs.xls', [T,G], 'mean_data','A2');

%         fout = [num2str(yr * 1000 + jd) '.flt'];
%         [s1, s2] = system(['rename ' ff ' ' fout]);
%
%
%
%         ff = [wks '\fpar_' num2str(yr * 1000 + jd) '.hdr'];
%         fout = [num2str(yr * 1000 + jd) '.hdr'];
%         [s1, s2] = system(['rename ' ff ' ' fout]);
%
%         ff = [wks '\fpar_' num2str(yr * 1000 + jd) '.prj'];
%         fout = [num2str(yr * 1000 + jd) '.prj'];
%         [s1, s2] = system(['rename ' ff ' ' fout]);
