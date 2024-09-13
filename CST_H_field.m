clc
clear

%% ���ݵ���
[file,path] = uigetfile('*.txt','ѡ��Ҫ����������ļ�');
data = readmatrix(fullfile(path,file));
%   x [mm]             y [mm]            z [mm]
%   HxRe [A/m]     HyRe [A/m]     HzRe [A/m]
%   HxIm [A/m]     HyIm [A/m]     HzIm [A/m]

x = data(:,1);
y = data(:,2);
z = data(:,3);

choice = questdlg('�Ƿ�������ģ�������ֻ���鲿���ݣ���', 'ѡ��', '��', '��', '��');
switch choice
    case '��'
        value = sqrt(data(:,7).*data(:,7)+data(:,8).*data(:,8)+data(:,9).*data(:,9));
    case '��'
        value = sqrt(data(:,4).*data(:,4)+data(:,5).*data(:,5)+data(:,6).*data(:,6)...
            +data(:,7).*data(:,7)+data(:,8).*data(:,8)+data(:,9).*data(:,9));
end
%% ѯ���Ƿ���Ҫ��value�޸ĳɶ�����ʽ
choice = questdlg('�Ƿ���Ҫ��value�޸ĳɶ�����ʽ��', 'ѡ��', '��', '��', '��');
switch choice
    case '��'
        value = log(value);
    case '��'
        % �����κβ���
end
%% ��������
subsection = inputdlg('�������ֵ�ܸ����:', '��ֵ�ܸ����', [1 40]);
subsection = str2double(subsection{1});
vv = linspace(min(value),max(value),subsection);

xlim1 = min(x);
xlim2 = max(x);
ylim1 = min(y);
ylim2 = max(y);
zlim1 = min(z);
zlim2 = max(z);

% ѡ���ͼ��
answer = questdlg('��ͼ��ķ��������ĸ���','ѡ���ͼ��','x','y','z','x');

switch answer
    case 'x'
        choice = questdlg('�Ƿ���Ҫ�ֶ����뷶Χ��', 'ѡ��', '��', '��', '��');
        switch choice
            case '��'
                prompt1 = {'y�᷶Χ(��ʽ��[ylim1 ylim2]):', 'z�᷶Χ(��ʽ��[zlim1 zlim2]):'};
                dlgtitle1 = '������ķ�Χ';
                dims1 = [1 50];
                definput1 = {'-2500 2500', '-2500 2500'};
                answer1 = inputdlg(prompt1,dlgtitle1,dims1,definput1);
                ylim = str2num(answer1{1});
                zlim = str2num(answer1{2});
                ylim1 = ylim(1);
                ylim2 = ylim(2);
                zlim1 = zlim(1);
                zlim2 = zlim(2);
                aa = linspace(ylim1, ylim2, subsection);
                bb = linspace(zlim1, zlim2, subsection);
                [y_grid, z_grid] = meshgrid(aa, bb);
                value_grid = griddata(y, z, value, y_grid, z_grid);
            case '��'
                aa = linspace(ylim1, ylim2, subsection);
                bb = linspace(zlim1, zlim2, subsection);
                [y_grid, z_grid] = meshgrid(aa, bb);
                value_grid = griddata(y, z, value, y_grid, z_grid);
        end
        
    case 'y'
        choice = questdlg('�Ƿ���Ҫ�ֶ����뷶Χ��', 'ѡ��', '��', '��', '��');
        switch choice
            case '��'
                prompt2 = {'x�᷶Χ(��ʽ��[xlim1 xlim2]):', 'z�᷶Χ(��ʽ��[zlim1 zlim2]):'};
                dlgtitle2 = '������ķ�Χ';
                dims2 = [1 50];
                definput2 = {'-2500 2500', '-2500 2500'};
                answer2 = inputdlg(prompt2,dlgtitle2,dims2,definput2);
                xlim = str2num(answer2{1});
                zlim = str2num(answer2{2});
                xlim1 = xlim(1);
                xlim2 = xlim(2);
                zlim1 = zlim(1);
                zlim2 = zlim(2);
                aa = linspace(xlim1, xlim2, subsection);
                bb = linspace(zlim1, zlim2, subsection);
                [x_grid, z_grid] = meshgrid(aa, bb);
                value_grid = griddata(x, z, value, x_grid, z_grid);
            case '��'
                aa = linspace(xlim1, xlim2, subsection);
                bb = linspace(zlim1, zlim2, subsection);
                [x_grid, z_grid] = meshgrid(aa, bb);
                value_grid = griddata(x, z, value, x_grid, z_grid);
        end
        
    case 'z'
        choice = questdlg('�Ƿ���Ҫ�ֶ����뷶Χ��', 'ѡ��', '��', '��', '��');
        switch choice
            case '��'
                prompt3 = {'x�᷶Χ(��ʽ��[xlim1 xlim2]):', 'y�᷶Χ(��ʽ��[ylim1 ylim2]):'};
                dlgtitle3 = '������ķ�Χ';
                dims3 = [1 50];
                definput3 = {'-2500 2500', '-2500 2500'};
                answer3 = inputdlg(prompt3,dlgtitle3,dims3,definput3);
                xlim = str2num(answer3{1});
                ylim = str2num(answer3{2});
                xlim1 = xlim(1);
                xlim2 = xlim(2);
                ylim1 = ylim(1);
                ylim2 = ylim(2);
                aa = linspace(xlim1, xlim2, subsection);
                bb = linspace(ylim1, ylim2, subsection);
                [x_grid, y_grid] = meshgrid(aa, bb);
                value_grid = griddata(x, y, value, x_grid, y_grid);
            case '��'
                aa = linspace(xlim1, xlim2, subsection);
                bb = linspace(ylim1, ylim2, subsection);
                [x_grid, y_grid] = meshgrid(aa, bb);
                value_grid = griddata(x, y, value, x_grid, y_grid);
        end
        
    otherwise
        error('��Ч�Ļ�ͼ��');
end
%% α��ͼ
choice = questdlg('�Ƿ���Ҫ��ͼ��', 'ѡ��', '��', '��', '��');
switch choice
    case '��'
        figure('Units','inches','Position',[0,0,10.72,8.205])
        pcolor(aa,bb,value_grid);
        xmin = min(aa);
        xmax = max(aa);
        ymin = min(bb);
        ymax = max(bb);
        shading interp;
%         c = colorbar('SouthOutside');
        colormap(jet);
%         caxis([0,30]);
        caxis([-18, -8]);
        c = colorbar;
        c.FontName = 'Arial';
        c.FontSize = 28;
        set(gca,'xtick',[],'ytick',[]);
        box off
        axis equal
        %         xlim([xlim1 xlim2])
        %         ylim([ylim1 ylim2])
        xlim([-60 60])
        ylim([-60 60])
    case '��'
        % �����κβ���
end
%% txt
choice = questdlg('�Ƿ���Ҫ����txt�ļ���', 'ѡ��', '��', '��', '��');
switch choice
    case '��'
        new_matrix = zeros(length(aa)+1, length(bb)+1);
        new_matrix(1, 2:end) = aa;
        new_matrix(2:end, 1) = bb;
        new_matrix(2:end, 2:end) = value_grid;
        new_matrix(1, 1) = NaN;
        file0 = erase(file,".txt")
        txt_name = [path,file0,'-ori.txt'];
        dlmwrite(txt_name, new_matrix, 'delimiter', '\t');
    case '��'
        % �����κβ���
end