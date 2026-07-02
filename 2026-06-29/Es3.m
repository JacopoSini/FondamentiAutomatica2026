clear all; clc; close all;
s=tf('s')

L=1/(10*s)*(s+30)/(s^2+6*s+9)

figure(1)
bode(L)
grid on

figure(2)
W=feedback(L,1)

step(W)
