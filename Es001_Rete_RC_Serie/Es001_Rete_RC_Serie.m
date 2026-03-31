%--------------------------------------------------------------------------
%
%   Title:   Listato Esempio 1 - "Rete RC serie"
%   Author:  Jacopo Sini (jsini@uniss.it)
%   Company: Università degli Studi di Sassari
%   Date:    20/03/2026
%
%--------------------------------------------------------------------------

close all
clear all
clc

fprintf('---------------------------------------\r ')
fprintf('Esempio 1 - "Rete RC serie\r')
fprintf('---------------------------------------\r ')

%Vecchia sintassi
%sol2=dsolve('Dx=(1/RC)*(U*sin(om*t)-x)','x(0)=x0');
%sol2

% Nuova sintassi
% 1. Definizione delle variabili simboliche
% Note: x(t) definisce x come funzione di t
syms u t x(t) C R U om x0 y y(t)

% 2. Definisci l'equazione differenziale e le condizioni iniziali
% Usa == per l'uguaglianza e diff() per indicare la derivata
ode = diff(x, t) == (1/(R*C)) * (U*sin(om*t) - x);
ode
cond = x(0) == x0;


% 3. Risolvi l'equazione differenziale definita
sol = dsolve(ode, cond);

% 4. Mostra il risultato in forma algebrica
sol
%disp(' Return per continuare ')
%pause


% 5. Fissa i  parametri per la simulazione

R=1000; % Ohm
C=10^-6; % Farad
U=2; %V (tensione di picco)
om=3000; % rad/s
x0=10; % V
X=[];

T=0:0.0001:0.02; %Definisce il vettore dei tempi di simulazione
U_t=[];
for i=1:201
    t=T(i); %Imposta t al tempo di simulazione corrente
    x=eval(sol); % Risolve l'equazione differenziale al tempo t
    X=[X;x]; %concatena x al vettore colonna X
    U_t=[U_t;U*sin(om*t)];
end

disp(' Andamento dello stato per  u(t)=2sin(3000t), RC=10^-3, omega=3000, x(0)=10')

figure(1)
plot(T,X)
hold on
plot(T,U_t-X)
legend('x(t)','y(t)');
title('x(t) per u(t)=2*sin(3000t), RC=10^-3, omega=3000, x(0)=10')
xlabel('t [s]')

% [EOF]
