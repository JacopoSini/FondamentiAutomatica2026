clear all; close all; clc;

s=tf('s');

L=5/(s)*(s+2)/(s+3)

figure(1)
bode(L)
grid on

figure(2)
nyquist(L)

figure(3)
W=feedback(L,1)
roots([1 8 10])
step(W)

figure(4)
bode(L)
hold on
bode(W)
legend('L(s)','W(s)')