function [smallesteigenvalue,eigenvalue,flag]=eigSSHnew(f,omega)
w=2*pi*(f+omega*1j);
C = 47e-12; %F 网孔内电容的总等效值
Z = -1j/2/pi/64e6/C;
t = 0.22; % t=v/w;强弱耦合比例系数
Z1 = -Z/(1+t);
Z2 = t.*Z1;
L1 = Z1/1j/2/pi/64e6;
L2 = Z2/1j/2/pi/64e6;
% !!! 选择出来的C_equal记得要 *2 转换成支路电容 填入到CST
%来自CST的RLC求解器
R1 = 0.076; % w = 2 mm
R2 = 0.0105;  % w = 20 mm
R3 = 0.01;  % 47pF电容的ESR
%R1 = 0;
%R2 = 0;
%% 建立网孔阻抗关系
Z1 = 1j*w*L1+R1;
Z2 = 1j*w*L2+R2;
H = Z1+Z2-1j./(w.*C)+2*R3;
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
eigenvalue=eig(ZZ);
smallesteigenvalue = min(abs(eigenvalue));
if smallesteigenvalue > 0 && smallesteigenvalue < 1e-5
    flag=1;
else
    flag=0;
end
end

