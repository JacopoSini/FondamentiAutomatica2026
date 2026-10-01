clear all
close all
clc

s=tf('s');
L=50*(s+50)/((s+5)*(s+500))

figure(1)
bode(L)
grid on

figure(2)
nyquist(L)
grid on
