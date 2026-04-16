% Script per la risposta di un sistema del primo ordine
clear; clc; close all;

% Parametri
t = 0:0.01:5;       % Intervallo di tempo (da 0 a 5 secondi)
r0 = 1;             % Residuo (fratti semplici)
lambdas = [-2, -1, 0, 1]; % Valori di lambda richiesti

figure;
hold on; grid on;

% Ciclo attraverso i valori di lambda
for L = lambdas
    % Calcolo della risposta: y(t) = y0 * exp(L*t)
    y = r0 * exp(L * t);
    
    % Creazione della legenda dinamica
    plot(t, y, 'LineWidth', 2, 'DisplayName', ['\lambda = ', num2mstr(L)]);
end

% Formattazione del grafico
xlabel('Tempo [s]');
ylabel('Risposta g(t)');
title('Risposta di un sistema del primo ordine');
legend('Location', 'best');
ylim([0 2]);

% Aggiunta asse zero per chiarezza
line(get(gca,'XLim'), [0 0], 'Color', 'k', 'LineStyle', '--', 'HandleVisibility', 'off');
