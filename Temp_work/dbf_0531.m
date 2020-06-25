clear all
close all
clc


DbfPath = 'D:\OneDrive\WorkSpace\ZhangMiao\tables_qh';
RsltPath = 'D:\TEMP';
% zoneList = {'River_region', 'protect_zone_Nature', 'GongCQ'};
varList = {'PRCP', 'TEM', 'SSD', 'WIN'};
% m = length(zoneList);
n = length(varList);
xdat = [];
y = 2015;
for v = 1:n % zonal
        var = varList{v}; 
        i = 1;
        
        for yr = 1980:2015
            if yr < 2000 && v == 2
                var = 'TAVG';
            else
                var = varList{v};
            end
            fname = sprintf('%s\\%s%d.dbf', DbfPath, var, yr);
            disp(fname);
            if exist(fname,'file')
                [x1, hd]  = dbfread(fname);
    %             xx = [hd; x1];
                dat = cell2mat(x1);
                if v == 1
                    x = sum(dat(:,4:end), 2);
                else
                    x = mean(dat(:,4:end), 2);
                end
            else
                disp([fname ' is not exist']);
            end
            if v == 1
                x(x<0 | x > 2000) = 0;
%             elseif v == 2
%                 x(x<-100 | x > 100) = 0;
%             else
%                 x = 1;
            end
            xdat(:, i) = x;
            i = i + 1;
        end
        M = [dat(:,1), xdat];
%         C = [sortrows(M)
        fxls = sprintf('%s\\%s.xls', RsltPath, varList{v});
        xlswrite(fxls, sortrows(M));
end

    
% end
% strs = 
% L = dir();
% j = 1;
% for i = yrs:yre
%     dbfFile = sprintf('%s\\sjy',);
%     if exist(dbfFile) > 0
%         [x1, hd]  = dbf_read(dbfFile);
%         xx = cell2mat(x1);
%         nn = length(xx);
%        count = xx(1:nn,2);   %m2
%         vgc = xx(1:nn,6);        % tC/ha
%         tvgc = vgc .* count *25 ;   % tC
%         VD(j,:) = vgc';
%         TC(j,:) = tvgc';
%         yr(j,1) = i;
%         j = j + 1;
%     else
%         dbfFile
%     end
% end
% dbfFile = ['G:\gd_vgc\dbf_combine.csv'];
% csvwrite(dbfFile, [yr VD TC]);
    