% Analisi della Stabilità al variare di Ts e dei Poli
clear; clc; close all;

% Parametri del sistema continuo di partenza (oscillatorio)
wn = 10; 
z = 0.1; 
sys_c = tf(wn^2, [1, 2*z*wn, wn^2]);

% Tempi di campionamento da confrontare
Ts_values = [0.02, 0.1, 0.5]; % Veloce, Medio, Lento

figure('Color', 'w', 'Position', [100, 100, 1000, 400]);

for i = 1:length(Ts_values)
    Ts = Ts_values(i);
    sys_d = c2d(sys_c, Ts, 'zoh');
    
    % Subplot per la mappa Poli-Zeri
    subplot(2, 3, i);
    hold on;
    % Disegna cerchio unitario
    th = linspace(0, 2*pi, 100);
    plot(cos(th), sin(th), 'k--'); 
    pzmap(sys_d);
    title(['Mappa Z (Ts = ', num2str(Ts), ')']);
    axis equal;
    
    % Subplot per la risposta al gradino
    subplot(2, 3, i+3);
    step(sys_d, 2);
    title(['Risposta (Ts = ', num2str(Ts), ')']);
    grid on;
end