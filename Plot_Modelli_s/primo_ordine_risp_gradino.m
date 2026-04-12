% Script per la risposta al gradino di un sistema del primo ordine
clear; clc; close all;

% Parametri
t = 0:0.01:10;          % Intervallo di tempo (0-10 secondi)
taus = [0.5, 1, 2];     % Costanti di tempo richieste

figure;
hold on; grid on;

% Ciclo attraverso i valori di tau
for T = taus
    % Calcolo della risposta al gradino unitario: y(t) = 1 - exp(-t/tau)
    y = 1 - exp(-t / T);
    
    % Plot della curva
    plot(t, y, 'LineWidth', 2, 'DisplayName', ['\tau = ', num2str(T), ' s']);
end

% Rappresentazione del gradino unitario (valore di regime)
line([0 10], [1 1], 'Color', 'r', 'LineStyle', '--', 'HandleVisibility', 'off');

% Formattazione del grafico
xlabel('Tempo [s]');
ylabel('Risposta y(t)');
title('Risposta al gradino unitario: y(t) = 1 - e^{-t/\tau}');
legend('Location', 'southeast');

ylim([0 1.2]);
xlim([0 10]);