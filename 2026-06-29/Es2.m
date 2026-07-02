clear all; clc; close all;
s=tf('s')
m=1;
b=3;
k=2;
A=[0 1; -k/m -b/m]
B=[0; 1/m];
C=[1 0];
D=0;
Id=[1 0; 0 1];
lambdas=eig(A)
[N,D]=ss2tf(A,B,C,D)

G=1/(s^2+3*s+2);
bode(10*G)

W= feedback(10*G,1)

roots([1 3 12])
step(W)