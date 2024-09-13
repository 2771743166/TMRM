clc
clear

%% 数据导入
[file,path] = uigetfile('*.txt','选择要导入的数据文件');
data = readmatrix(fullfile(path,file));
%   x [mm]             y [mm]            z [mm]
%   HxRe [A/m]     HyRe [A/m]     HzRe [A/m]
%   HxIm [A/m]     HyIm [A/m]     HzIm [A/m]

x = data(:,1);
y = data(:,2);
z = data(:,3);

choice = questdlg('是否是特征模求解器（只有虚部数据）？', '选择', '是', '否', '是');
switch choice
    case '是'
        value = sqrt(data(:,7).*data(:,7)+data(:,8).*data(:,8)+data(:,9).*data(:,9));
    case '否'
        value = sqrt(data(:,4).*data(:,4)+data(:,5).*data(:,5)+data(:,6).*data(:,6)...
            +data(:,7).*data(:,7)+data(:,8).*data(:,8)+data(:,9).*data(:,9));
end
%% 询问是否需要将value修改成对数形式
choice = questdlg('是否需要将value修改成对数形式？', '选择', '是', '否', '是');
switch choice
    case '是'
        value = log(value);
    case '否'
        % 不做任何操作
end
%% 数据重组
subsection = inputdlg('请输入插值总格点数:', '插值总格点数', [1 40]);
subsection = str2double(subsection{1});
vv = linspace(min(value),max(value),subsection);

xlim1 = min(x);
xlim2 = max(x);
ylim1 = min(y);
ylim2 = max(y);
zlim1 = min(z);
zlim2 = max(z);

% 选择绘图面
answer = questdlg('绘图面的法向量是哪个？','选择绘图面','x','y','z','x');

switch answer
    case 'x'
        choice = questdlg('是否需要手动输入范围？', '选择', '是', '否', '是');
        switch choice
            case '是'
                prompt1 = {'y轴范围(格式：[ylim1 ylim2]):', 'z轴范围(格式：[zlim1 zlim2]):'};
                dlgtitle1 = '输入轴的范围';
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
            case '否'
                aa = linspace(ylim1, ylim2, subsection);
                bb = linspace(zlim1, zlim2, subsection);
                [y_grid, z_grid] = meshgrid(aa, bb);
                value_grid = griddata(y, z, value, y_grid, z_grid);
        end
        
    case 'y'
        choice = questdlg('是否需要手动输入范围？', '选择', '是', '否', '是');
        switch choice
            case '是'
                prompt2 = {'x轴范围(格式：[xlim1 xlim2]):', 'z轴范围(格式：[zlim1 zlim2]):'};
                dlgtitle2 = '输入轴的范围';
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
            case '否'
                aa = linspace(xlim1, xlim2, subsection);
                bb = linspace(zlim1, zlim2, subsection);
                [x_grid, z_grid] = meshgrid(aa, bb);
                value_grid = griddata(x, z, value, x_grid, z_grid);
        end
        
    case 'z'
        choice = questdlg('是否需要手动输入范围？', '选择', '是', '否', '是');
        switch choice
            case '是'
                prompt3 = {'x轴范围(格式：[xlim1 xlim2]):', 'y轴范围(格式：[ylim1 ylim2]):'};
                dlgtitle3 = '输入轴的范围';
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
            case '否'
                aa = linspace(xlim1, xlim2, subsection);
                bb = linspace(ylim1, ylim2, subsection);
                [x_grid, y_grid] = meshgrid(aa, bb);
                value_grid = griddata(x, y, value, x_grid, y_grid);
        end
        
    otherwise
        error('无效的绘图面');
end
%% 伪彩图
choice = questdlg('是否需要画图？', '选择', '是', '否', '是');
switch choice
    case '是'
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
    case '否'
        % 不做任何操作
end
%% txt
choice = questdlg('是否需要保存txt文件？', '选择', '是', '否', '是');
switch choice
    case '是'
        new_matrix = zeros(length(aa)+1, length(bb)+1);
        new_matrix(1, 2:end) = aa;
        new_matrix(2:end, 1) = bb;
        new_matrix(2:end, 2:end) = value_grid;
        new_matrix(1, 1) = NaN;
        file0 = erase(file,".txt")
        txt_name = [path,file0,'-ori.txt'];
        dlmwrite(txt_name, new_matrix, 'delimiter', '\t');
    case '否'
        % 不做任何操作
end