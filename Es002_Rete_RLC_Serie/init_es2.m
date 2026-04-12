clear all
clc

R=1e3; %Ohm
Cap=1e-6; %10^-6 %Farad
U=10; %Volt
om=1*10^3; %rad/s
L= 10e-3; %Henry
f_r=1/(L*Cap)^(1/2)
x1_0=0; %V (tensione iniziale sul condensatore)
x2_0=0; %A (corrente iniziale sull'induttore)
step=1/10/om; %s
%x1 = v_c x2 = i_L y=v_c
A=[0 1/Cap; -1/L -R/L];
B=[0;1/L];
C=[1 0];
D=[0];
x0=[x1_0 x2_0];
s=tf('s');
[num, den]=ss2tf(A,B,C,D);

end_time=step*500;