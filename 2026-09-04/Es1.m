clear all
close all
clc

s=tf('s');
L=5/s*(s+10)/((s+1)*(s+100))

figure(1)
bode(L)
grid on
W=feedback(L,1)
figure(2)
step(W)
figure(3)
bode(W)