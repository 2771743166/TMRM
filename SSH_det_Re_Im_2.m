clear
clc
%% 在满足SSH电路配平的情况下，求电感
f = 64e6; %Hz
w = 2*pi*f;
C = 47e-12; %F 网孔内电容的总等效值
Z = -1j/w/C;
t = 0.22; % t=v/w;强弱耦合比例系数
Z1 = -Z/(1+t);
Z2 = t.*Z1; %Z2是弱耦合
L1 = Z1/1j/w;
L2 = Z2/1j/w;
% % !!! 选择出来的C_equal记得要 *2 转换成支路电容 填入到CST
% R1 = 0.076; % w = 2 mm
% R2 = 0.0105;  % w = 20 mm
% R3 = 0.01;  % 47pF电容的ESR 64MHz下应该更小
R1 = 5;
R2 = 0;
R3 = 0;  %忽略ESR
%% 绘制频率响应图(已知频率求det或eig)
clear f w

f = [40:0.01:300]*1e6;
ii = 1;
for f1 = f
    w1 = f1*2*pi;
    %% 建立网孔阻抗关系
    Z1 = 1j*w1*L1+R1;
    Z2 = 1j*w1*L2+R2;
    if f<100e6
        R3 = 0;
    else
        R3 = 0.01;
    end
    H = Z1+Z2-1j./(w1.*C)+2*R3;
    %% 构筑阻抗矩阵
    num = 12;
    for i = 1:1:num
        Z_H(1,i) = H;
    end
    
    for i = 1:1:num-1
        if mod(i,2) == 1
            Z1_H(1,i) = 0;
            Z2_H(1,i) = -Z2;
        else
            Z1_H(1,i) = -Z1;
            Z2_H(1,i) = 0;
        end
    end
    ZZ_H = diag(Z_H);
    ZZ_11 = diag(Z1_H,-1);
    ZZ_12 = diag(Z1_H,1);
    ZZ_21 = diag(Z2_H,1);
    ZZ_22 = diag(Z2_H,-1);
    ZZ = ZZ_H+ZZ_11+ZZ_22+ZZ_12+ZZ_21;
    %% 计算阻抗矩阵特征值和行列式
    d(ii) = min(eig(ZZ)); %矩阵行列式
    ii = ii+1;
end
%% 绘图
semilogy(f/1e6,abs(d))
%% 保存txt文件
% data = [f'/1e6 abs(d')];
% save('freq-det.txt','data','-ascii','-double');