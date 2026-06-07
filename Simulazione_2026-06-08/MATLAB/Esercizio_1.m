clear; clc; close all;
% Definizione delle matrici nello spazio degli stati
A = [0 1; -6 -5];
B = [0; 2];
C = [1 3];
D = 0;

% Creazione del modello nello spazio degli stati
sys_ss = ss(A, B, C, D); % Condizioni iniziali nulle

% Conversione in funzione di trasferimento
sys_tf = tf(sys_ss)

figure(1)
bode(sys_tf)


guadagno_sistema = dcgain(sys_tf); %Notare che è <1
guadagno_sistema_dB = dcgain(sys_tf)
figure(2)

step(feedback(sys_tf,1))