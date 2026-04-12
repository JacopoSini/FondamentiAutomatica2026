% Analisi Risposta al Gradino in TEMPO REALE
clear all; clc; close all;

% Parametri del sistema
wn = 2*pi*1000;         % Pulsazione naturale (rad/s)
z = 0.2;        % Coefficiente di smorzamento
epsilon = 0.05; % Soglia di assestamento

% Definizione della funzione di trasferimento reale
% G(s) = wn^2 / (s^2 + 2*z*wn*s + wn^2)
num = wn^2;
den = [1, 2*z*wn, wn^2];
sys = tf(num, den);

% Calcolo risposta
t = 0:25*1/wn/5000:25*1/wn;  % Vettore tempo in secondi
[y, t_out] = step(sys, t);
info = stepinfo(sys, 'SettlingTimeThreshold', epsilon);

% Estrazione parametri
S_max_perc = info.Overshoot; % Sovraelongazione in percentuale
t_peak = info.PeakTime;
t_rise = info.RiseTime;      % Tempo di salita 0-100%
t_settling = info.SettlingTime;

% Calcolo tempo di salita 10-90%
idx10 = find(y >= 0.1, 1);
idx90 = find(y >= 0.9, 1);
tr_1090 = t_out(idx90) - t_out(idx10);

% --- GRAFICO ---
figure('Color', 'w', 'Name', 'Risposta Temporale Reale');
plot(t_out, y, 'LineWidth', 2, 'Color', [0, 0.447, 0.741]);
hold on; grid on;

% Linea di regime (Target = 1)
line([0 t(end)], [1 1], 'Color', 'k', 'LineStyle', '--', 'HandleVisibility', 'off');

% Punto di Picco e Sovraelongazione
plot(t_peak, info.Peak, 'ro', 'MarkerFaceColor', 'r');
text(t_peak, info.Peak + 0.05, ['  S_{max} = ', num2str(S_max_perc), '%'], 'Color', 'r');
text(t_peak, info.Peak + 0.12, ['  t_p = ', num2str(t_peak), ' s'], 'Color', 'r');

% 3. Tempo di Salita (10-90%)
plot(t_rise, 1, 'go', 'MarkerFaceColor', 'g');
text(t_rise, 0.1, ['\leftarrow \tau_r (0-100%) = ', num2str(t_rise)], 'Rotation', 90, 'Color', 'b');

% Tempo di Assestamento (2%)
line([t_settling t_settling], [0 1.6], 'Color', [0.5 0 0.5], 'LineStyle', '-.');
text(t_settling, 0.5, [' t_s = ', num2str(t_settling), ' s'], 'Color', [0.5 0 0.5], 'FontWeight', 'bold');

% Fascia di tolleranza
fill([t_settling t(end) t(end) t_settling], [1-epsilon 1-epsilon 1+epsilon 1+epsilon], ...
     [0.5 0 0.5], 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% Formattazione
title(['Risposta al Gradino Reale (\omega_n = ', num2str(wn), ' rad/s, \zeta = ', num2str(z), ')']);
xlabel('Tempo [s]');
ylabel('Ampiezza y(t)');
ylim([0 1.7]);
xlim([0 t(end)]);