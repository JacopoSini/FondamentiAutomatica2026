% Analisi Aliasing - Campionamento Sottostimato
clear; clc; close all;

% Parametri del sistema (Molto veloce)
wn = 20;            % Pulsazione naturale (f approx 3.18 Hz)
z = 0.05;           % Smorzamento bassissimo per avere molte oscillazioni
sys_c = tf(wn^2, [1, 2*z*wn, wn^2]);

% Periodi di campionamento
Ts_good = 0.05;     % Campionamento corretto (20 Hz)
Ts_alias = 0.4;     % Campionamento troppo lento (2.5 Hz) -> ALIASING!

t_final = 5;
t_cont = 0:0.001:t_final;

% --- FIGURA 1: RISPOSTA TEMPORALE (L'effetto visivo) ---
figure(1); set(gcf, 'Color', 'w');
hold on; grid on;

% 1. Risposta Continua (La realtà fisica)
[y_c, t_c] = step(sys_c, t_cont);
plot(t_c, y_c, 'k', 'LineWidth', 1.5, 'DisplayName', 'Segnale Reale (Continuo)');

% 2. Campionamento Buono
sys_good = c2d(sys_c, Ts_good, 'zoh');
[y_g, t_g] = step(sys_good, t_final);
plot(t_g, y_g, 'g-o', 'MarkerSize', 4, 'DisplayName', 'Campionamento Corretto');

% 3. Campionamento con Aliasing
sys_alias = c2d(sys_c, Ts_alias, 'zoh');
[y_a, t_a] = step(sys_alias, t_final);
plot(t_a, y_a, 'r--s', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'ALIASING (Ts troppo grande)');

xlabel('Tempo [s]'); ylabel('Ampiezza');
title('Aliasing: Il segnale rosso sembra più lento di quello reale');
legend;

% --- FIGURA 2: PIANO Z (L'effetto sui poli) ---
figure(2); set(gcf, 'Color', 'w');
hold on; grid on; axis equal;
th = linspace(0, 2*pi, 100); plot(cos(th), sin(th), 'k:');

p_good = pole(sys_good);
p_alias = pole(sys_alias);

plot(real(p_good), imag(p_good), 'gx', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', 'Poli corretti');
plot(real(p_alias), imag(p_alias), 'rs', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', 'Poli "Aliased"');

title('Spostamento dei Poli nel Piano Z');
legend;