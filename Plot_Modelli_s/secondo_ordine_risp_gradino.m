% Script per la risposta al gradino di un sistema del secondo ordine
clear; clc; close all;

% Parametri
wn = 2;                         % Pulsazione naturale
t = 0:0.01:15;                  % Tempo
zetas = [0.9, 0.5, 0.2, 0.05, 0, -0.05]; 

figure;
hold on; grid on;

for z = zetas
    % Definizione della funzione di trasferimento G(s)
    num = wn^2;
    den = [1, 2*z*wn, wn^2];
    sys = tf(num, den);
    
    % Calcolo della risposta al gradino unitario
    [y, t_out] = step(sys, t);
    
    % Assegnazione di uno stile diverso per evidenziare z=0
    if z == 0
        plot(t_out, y, 'r--', 'LineWidth', 2.5, 'DisplayName', '\zeta = 0 (Oscillante)');
    else
        plot(t_out, y, 'LineWidth', 2, 'DisplayName', ['\zeta = ', num2str(z)]);
    end
end

% Linea del valore di riferimento (gradino unitario)
line([0 15], [1 1], 'Color', 'k', 'LineStyle', ':', 'HandleVisibility', 'off');

% Formattazione
xlabel('Tempo [s]');
ylabel('Risposta y(t)');
title('Risposta al gradino: confronto tra sistemi stabili, oscillanti e instabili');
legend('Location', 'best');

% Limite Y tra 0 e 2
ylim([0 2]);