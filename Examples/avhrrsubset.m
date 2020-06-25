% Junbang Wang
%  
% Visiting Scholar
% Numerical Terradynamic Simulation Group (NTSG), University of Montana
% Phone: 406-830-8745
%  
% Assistant Professor
% Key Laboratory of Ecosystem Network Observation and Modeling, Institute of Geographic Sciences and Natural Resources Research, Chinese Academy of Sciences
% Phone: 010-6487-4229
%  
% Email: qhwjunb@gmail.com; jbwang@igsnrr.ac.cn  

close all
clear all
clc
 
ab = 'ab';  var = 'fpar';
gs = [60 -15 45 160];
gp = [(90-gs(1:2))*12 (180+gs(3:4))*12];
 
for y = 1981: 2011
    for m = 1 : 12
        [n mon] = month(datenum(y,m,1));
        mon = lower(mon);
        for d = 1 : 2
            dstr = datestr(datenum(y,m,(d-1)*15+1));
            ff = ['C:\Temp\avhrrbufpar\AVHRRBUVI01.' num2str(y) mon ab(d) '.ab' var(1)];
            if exist(ff, 'file')
                disp(ff);
                fid = fopen(ff, 'r');
                if fid == -1
                    error('Can''t open the file, please check the filepath and your authority!');
                else
                    gdat = fread(fid,[2160,4320],'uint8',0,'ieee-be');
                    fclose(fid);

                    sdat = double(gdat(gp(1):gp(2),gp(3):gp(4)));
                    % sdat(sdat == 250) = -9999.0;
                    n = size(sdat);

                    figure(1)
                    imagesc(sdat,[1 100]);
                    colormap([white(1);jet(150)]);
                    colorbar('horiz');
                    axis equal;
                    axis off;
                    title(dstr);

                    ff = ['C:\Temp\' var '\' var(1) num2str(y*10000+m*100+d) '.flt'];
                    fp = fopen(ff,'w');
                    fwrite(fp,sdat','float32');
                    writegrdhdr(ff,n(2),n(1),gs(3),gs(2),1/12,255,'LSBFIRST');
                    fclose(fp);                    
                end
            end
        end
    end
end
 
