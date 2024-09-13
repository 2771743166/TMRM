clear
clc

%% 导入LTspice数据
[file,path] = uigetfile('*.raw','选择要导入的数据文件');
raw_data = LTspice2Matlab(fullfile(path,file));
f = raw_data.freq_vect;
target_frequency = 63.8e6;  % 要查找的目标频率
% 使用find函数查找等于目标频率的位置
[~, index] = min(abs(f(1,:) - target_frequency));
num_steps = raw_data.num_steps;

%% 确定网孔数和元件所在位置
k = find(strcmp(raw_data.variable_name_list, 'I(C1)'));
num = 8 ; %网孔数

%% 单网孔绘图
% for i =1:1:raw_data.num_steps
%     yy = abs(raw_data.variable_mat(k,:,i));
%     xx = f(i,:)./1e6;
%     semilogy (xx,yy)
%     hold on
%     grid off
%     set(gca,'XLim',[min(f)/1e6 max(f)/1e6]);
% end

%% 多网孔绘图
for p = 1:1:num_steps
    j = 1;
    for i = k:2:(num-1)*2+k
        yy(p,j) = abs(raw_data.variable_mat(i,index,p));
        j = j +1;
    end
end

%% 绘图
for i = 1:1:num_steps
    figure(i)
    bar(yy(i,:))
    ylabel('Current')
    xlabel('Mesh number')
    caxis([0 1.4]);
end

%% 保存txt文件
% data = [xx' yy'];
% save ("k=6 考虑电阻.txt",'data','-ascii','-double');