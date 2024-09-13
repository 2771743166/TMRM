%% 初始化
clear
clc

%% 信噪比map
[file,path] = uigetfile('*.dcm','选择要导入的数据文件1');
img1 = dicomread(fullfile(path,file));
[file,path] = uigetfile('*.dcm','选择要导入的数据文件2');
img2 = dicomread(fullfile(path,file));
[file,path] = uigetfile('*.dcm','选择要导入的数据文件1');
img3 = dicomread(fullfile(path,file));
[file,path] = uigetfile('*.dcm','选择要导入的数据文件2');
img4 = dicomread(fullfile(path,file));

S = 100;

img1_S = double(img1);
img2_S = double(img2);
img3_S = double(img3);
img4_S = double(img4);

img1_S(img1_S<S) = NaN;
img2_S(img2_S<S) = NaN;
img3_S(img3_S<S) = NaN;
img4_S(img4_S<S) = NaN;


R1 = img1_S./img2_S;
R2 = img3_S./img4_S;

R1 = rot90(R1,2);

R1 = circshift(R1,-2,2);

R = [R1;R2];
R(240:778,:) = [];

theta = acosd(R/2);
imagesc(real(theta));

colorbar
colormap(jet)
caxis([0,60])

xlim([150 350])
ylim([50 500])

axis equal
box off