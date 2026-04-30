% Parametri per motore in c.c. con eccitazione indipendente

R_a = 1; %Ohm
J = 0.05; %Kg m^2
b = 0.005; %Nms/rad
L = 0.01; %H
K_m = 0.01; %V s/rad
V_a = 100;
w_des = 3000;

N_1 = [1];
D_1 = [L R_a];
N_2 = [1];
D_2 = [J b];