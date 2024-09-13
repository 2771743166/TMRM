function [states]=States_SSH(freq,t,n)
%% 在满足SSH电路配平的情况下，求电感
f = 64e6; %Hz
w = 2*pi*f;
C = 47e-12; %F 网孔内电容的总等效值
Z = -1j/w/C;
Z1 = -Z/(1+t);
Z2 = t.*Z1; %Z2是弱耦合
L1 = Z1/1j/w;
L2 = Z2/1j/w;
R1 = 0.03;
R2 = 0.03;
R3 = 0.03;  %忽略ESR
w1 = freq*2*pi;
%% 绘制频率响应图(已知频率求det或eig)
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
num = n;
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
[states,~] = eigs(ZZ,n);
states = real(states);