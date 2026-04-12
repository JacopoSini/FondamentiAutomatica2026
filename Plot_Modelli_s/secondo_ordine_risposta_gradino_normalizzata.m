% Analisi Risposta al Gradino Normalizzata (zeta = 0.2)
clear; clc; close all;

% Parametri
wn = 1;         % Normalizzazione (wn=1)
z = 0.2;        % Smorzamento richiesto
t = 0:0.02:25;  % Tempo normalizzato
epsilon = 0.05; % Soglia di assestamento

% Definizione sistema
sys = tf(1, [1, 2*z, 1]);

% Calcolo risposta
[y, t_out] = step(sys, t);
info = stepinfo(sys, 'SettlingTimeThreshold', epsilon);

% Estrazione parametri per il plot
S_max = (info.Peak - 1); % Sovraelongazione relativa
t_peak = info.PeakTime;
t_rise = info.RiseTime; % Tempo di salita (da 0 a 100% per sistemi sottosmorzati)
t_settling = info.SettlingTime;

% Calcolo tempo di salita 10-90% manualmente (per sistemi del 2 ordine)
y_10 = 0.1; y_90 = 0.9;
t_10 = t_out(find(y >= y_10, 1));
t_90 = t_out(find(y >= y_90, 1));
tr_1090 = t_90 - t_10;

% Creazione Grafico
figure('Color', 'w');
plot(t_out, y, 'LineWidth', 2, 'Color', [0, 0.447, 0.741]);
hold on; grid on;

% 1. Linea di regime (y=1)
line([0 25], [1 1], 'Color', 'k', 'LineStyle', '--');

% 2. Sovraelongazione e Tempo di Picco (S^ e tp)
plot(t_peak, info.Peak, 'ro', 'MarkerFaceColor', 'r');
line([t_peak t_peak], [0 info.Peak], 'Color', 'r', 'LineStyle', ':');
text(t_peak+0.5, info.Peak, ['\leftarrow S_{max} = ', num2str(S_max*100), '% at \tau_p = ', num2str(t_peak)], 'Color', 'r');

% 3. Tempo di Salita (10-90%)
plot(t_rise, 1, 'go', 'MarkerFaceColor', 'g');
text(t_rise, 0.1, ['\leftarrow \tau_r (0-100%) = ', num2str(t_rise)], 'Rotation', 90, 'Color', 'b');

% 4. Tempo di Salita (10-90%)
plot([t_10 t_90], [y_10 y_90], 'kx', 'LineWidth', 2);
text(t_10, 0.4, ['\leftarrow \tau_{r(10-90)} = ', num2str(tr_1090)], 'Color', 'k');

% 5. Tempo di Assestamento (Settling Time)
line([t_settling t_settling], [0 1.2], 'Color', [0.5 0 0.5], 'LineStyle', '-.');
plot(t_settling, y(find(t_out >= t_settling, 1)), 'o', 'Color', [0.5 0 0.5]);
text(t_settling+0.5, 0.5, ['\tau_s (',num2str(epsilon*100),'%) = ', num2str(t_settling)], 'Color', [0.5 0 0.5]);

% Fascia di tolleranza epsilon = 2%
fill([t_settling 25 25 t_settling], [0.98 0.98 1.02 1.02], [0.5 0 0.5], 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

% Formattazione finale
title(['Analisi Risposta al Gradino (Normalizzata) - \zeta = ', num2str(z)]);
xlabel('Tempo normalizzato \omega_n t');
ylabel('Risposta y(\tau)');
ylim([0 1.6]);
xlim([0 25]);