clear all; close all; clc;

s=tf('s');

L=50*(s+10)/(s*(s+1)*(s+100))

figure(1)
bode(L)
grid on

figure(2)
nyquist(L)

figure(3)
W=feedback(L,1)
step(W)
