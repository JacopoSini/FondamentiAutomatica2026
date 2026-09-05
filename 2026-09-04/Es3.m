clear all; clc; close all;
s=tf('s')
A=[-1 1; 0 -1]
B=[0; 1];
C=[10 0];
D=0;
Id=[1 0; 0 1];
lambdas=eig(A)

[N,D]=ss2tf(A,B,C,D);

L=tf(N,D)
figure(1)
bode(L)
C=1;

W=feedback(L,1)

figure(2)
step(W)

roots([1 2 11])