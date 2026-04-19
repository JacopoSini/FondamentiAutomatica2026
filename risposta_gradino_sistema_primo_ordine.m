% Risposta al gradino 1° ordine nel tempo discreto
clear; clc; close all;

Ts = 0.2;           % Tempo di campionamento
t_final = 10;
taus = [0.5, 1, 2]; % Costanti di tempo in secondi

figure; hold on; grid on;

for tau = taus
    % Sistema continuo: G(s) = 1 / (tau*s + 1)
    sys_c = tf(1, [tau 1]);
    
    % Discretizzazione (Zero-Order Hold)
    sys_d = c2d(sys_c, Ts, 'zoh');
    
    % Calcolo risposta al gradino
    [y, t_out] = step(sys_d, t_final);
    
    % stairs simula il mantenimento del segnale tra un campione e l'altro
    stairs(t_out, y, 'LineWidth', 2, 'DisplayName', ['\tau = ', num2str(tau), 's']);
end

% Linea del valore di regime
line([0 t_final], [1 1], 'Color', 'k', 'LineStyle', '--', 'HandleVisibility', 'off');

xlabel('Tempo [s]');
ylabel('y(kT)');
title('Risposta al gradino discreta (1° ordine)');
legend('Location', 'southeast');
ylim([0 1.2]);