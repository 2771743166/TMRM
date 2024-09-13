clear
clc 

f0=64e6;
f=f0;
omegasample=linspace(-1e6,1e6,2000);
smallesteigenvaluenorm=zeros(1,2000);
for i=1:2000
    [eig1,eigenvalue,flag1]=eigSSHnew(f,omegasample(i));
    smallesteigenvaluenorm(i)=eig1;
end
[smallesteigenvalue,l]=min(smallesteigenvaluenorm);
smallesteigenvalue
omega=omegasample(l);
omega
order=5;
for order=5:-1:-5
    fsample=linspace(f-50*10^order,f+50*10^order,101);
    smallesteigenvaluenorm=zeros(1,101);
    for j=1:101
        [eig1,eigenvalue,flag1]=eigSSHnew(fsample(j),omega);
        smallesteigenvaluenorm(j)=eig1;
    end
    [smallesteigenvalue,l]=min(smallesteigenvaluenorm);
    smallesteigenvalue
    f=fsample(l);
    f
    omegasample=linspace(omega-50*10^(order-1),omega+50*10^(order-1),101);
    smallesteigenvaluenorm=zeros(1,101);
    for j=1:101
        [eig1,eigenvalue,flag1]=eigSSHnew(f,omegasample(j));
        smallesteigenvaluenorm(j)=eig1;
    end
    [smallesteigenvalue,l]=min(smallesteigenvaluenorm);
    smallesteigenvalue
    omega=omegasample(l);
    omega
end
vpa([f,omega,smallesteigenvalue],15)
