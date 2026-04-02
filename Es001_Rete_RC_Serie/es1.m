clear all
close all
clc

% u(t)=U*sin(om*t)

% Definizione variabili simboliche
syms u t x(t) C R U om x0 y y(t)

%definiamo eq. differenziale
ode = diff(x,t) == (1/(R*C))*(U*sin(om*t)-x);
%ode = diff(x,t) == (1/(R*C))*(0-x); % u(t) = 0 (risposta libera)
ode
cond = x(0) == x0

%Risolvo l'eq. differenziale
sol = dsolve(ode, cond);
pretty(sol)

R=1e3; %Ohm
C=1e-6; %10^-6 %Farad
U=2; %Volt
om=1*10^3; %rad/s
x0=0; %V
step=1/10/om; %s

%Voglio simulare i primi 20 ms
% R*C (costante di tempo) = 1 ms

T=0:step:step*200; %Vettore dei tempi di simulazione
U_t=[];
X=[];
for i=1:201
    t=T(i); % istante di simulazione
    x=eval(sol); %risolvo l'eq. al tempo t
    X=[X;x];
    U_t=[U_t;U*sin(om*t)];
    %U_t=[U_t;0]; % u(t) = 0
end

figure(1)
plot(T,X);
hold on
plot(T,U_t);
legend('x(t)=v_c(t)','u(t)=v_g(t)')
xlabel('t [s]');
ylabel('x(t) [V]');

figure(2)
plot(T,U_t-X);
hold on
plot(T,U_t);
legend('y(t)=v_R(t)','u(t)=v_g(t)')
xlabel('t [s]');
ylabel('y(t) [V]');