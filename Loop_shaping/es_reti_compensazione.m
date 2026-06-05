clear all; close all; clc;
s=tf('s')
F=10/(s*(s+2)*(s+4))
Kc=4;

L=Kc*F;

figure(1)
margin(L)
hold on
W=feedback(L,1)
%margin(W)
figure(2)
step(W)

% Tempo si salita pari a circa 0.4 s (+- 15%) 0.34 <= ts <= 4.46
%% 
%clear all
ts=0.4
w_b= 3/ts
w_c=0.63*w_b

%Sovraelongazione al gradino unitario < 25%
s_ = 0.25
M_r= (1+s_)/0.9
M_r_dB=20*log10(M_r)

m_phi_min=60-5*M_r_dB

% Ci serve guadagnare circa 70°
m_d=(1+sin(deg2rad(35)))/(1-sin(deg2rad(35))) %3.69

m_d=4 %per robustezza
% dal grafico normalizzato ottengo che guadagno 35° a 2 rad/s normalizzati
% omega*tau_d=2

tau_d= 2/w_c

R_d=(1+tau_d*s)/(1+tau_d/m_d*s)

C=Kc*R_d*R_d

figure(3)
L2=C*F
margin(L2)

figure(4)
W2=feedback(L2,1);
step(W2)

% Voglio w_c a circa 1 rad/s
%|L(1 rad/s)|=14 dB

m_i = 10^(14/20)
w_c_des = 1; %rad/s
figure(5)
R_i_n=(1+1/4*s)/(1+s)
bode(R_i_n)

x_i = 7.5;
t_i=x_i/w_c_des;

R_i=(1+t_i/4*s)/(1+s*t_i)

L3 = L2*R_i

figure(6)
margin(L3)

W3=feedback(L3,1);
step(W3);
figure(7)
bode(W3)