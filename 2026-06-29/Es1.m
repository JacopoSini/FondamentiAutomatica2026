clear all; close all; clc;

s=tf('s');

F=34/(s^2+10*s+16);

figure(1)
bode(F)

figure(2)
nyquist(F)

poles_F=roots([1 10 16])

figure(3)
W=feedback(F,1)
step(W)
poles_F=roots([1 10 50])