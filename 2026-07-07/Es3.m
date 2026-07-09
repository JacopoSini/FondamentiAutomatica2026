clear all; clc; close all;
s=tf('s')
A=[-5 1; 0 -10]
B=[0; 1];
C=[10 0];
D=0;
Id=[1 0; 0 1];
lambdas=eig(A)

[N,D]=ss2tf(A,B,C,D);

L=10*tf(N,D)
figure(1)
bode(L)

W= feedback(L,1)

figure(2)
step(W)

roots([1 15 150])