clear
clc
%% 
n=12;
%%
for j=1:1:301
    data=freq_SSH(j/100,n);
    freq(:,j)=data(:,1);
end
%%
t = 0.01:0.01:3.01;
w=freq*2*pi;
w=w.^(-2);
%% 
figure(1)
% subplot(2,3,[1,4]);%画出本征值分布即能量随v/w的变化
plot(t,w);
xlabel('v/w');
ylabel('energy E');
title(['The spectrum of finite SSH model(n=',num2str(n),')']);
data=[t' w'];
dlmwrite('D:\ZSY\Matlab\20231019-电路-频谱.txt', data, 'delimiter', '\t');
%%
t = 0.26;
%%
%画出v/w=0.5时两个能量最接近0的本征态分布
% subplot(2,3,2);
figure(2)
freq = 64e6;
states = States_SSH(freq,t,n);
bar(states(:,11));
data = states(:,11);
dlmwrite('D:\ZSY\Matlab\20231019-电路-场分布.txt', data, 'delimiter', '\t');
% title(['Frequency = ',num2str(freq/1e6),' [MHz]',' ,v/w = ',num2str(t)]);