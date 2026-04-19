% Analisi Discretizzazione - Figure Separate
clear; clc; close all;

% Parametri
wn = 5;                     
Ts = 0.2;                   
t_final = 5;
t_cont = 0:0.001:t_final;   
zetas = [0.2, 0.7];         
colors = lines(length(zetas));

% --- FIGURA 1: RISPOSTA NEL TEMPO ---
figure(1);
set(gcf, 'Color', 'w', 'Name', 'Risposta Temporale: Cont vs ZOH vs Tustin');
hold on; grid on;

for i = 1:length(zetas)
    z = zetas(i);
    sys_c = tf(wn^2, [1, 2*z*wn, wn^2]);
    
    % 1. Continuo
    [y_c, t_c] = step(sys_c, t_cont);
    plot(t_c, y_c, 'Color', colors(i,:), 'LineWidth', 2, ...
        'DisplayName', ['\zeta = ', num2str(z), ' (Cont)']);
    
    % 2. ZOH (Zero-Order Hold) - Rappresenta l'hardware reale
    sys_zoh = c2d(sys_c, Ts, 'zoh');
    [y_zoh, t_zoh] = step(sys_zoh, t_final);
    stairs(t_zoh, y_zoh, ':', 'Color', colors(i,:), 'LineWidth', 1.5, ...
        'DisplayName', ['\zeta = ', num2str(z), ' (ZOH)']);
    
    % 3. Tustin (Bilineare) - Rappresenta l'approssimazione numerica
    sys_tus = c2d(sys_c, Ts, 'tustin');
    [y_tus, t_tus] = step(sys_tus, t_final);
    plot(t_tus, y_tus, '--o', 'Color', colors(i,:)*0.8, 'MarkerSize', 4, ...
        'DisplayName', ['\zeta = ', num2str(z), ' (Tustin)']);
end

xlabel('Tempo [s]'); ylabel('Ampiezza');
title('Confronto Risposta al Gradino');
legend('Location', 'southeast');

% --- FIGURA 2: PIANO Z (MAPPA POLI) ---
figure(2);
set(gcf, 'Color', 'w', 'Name', 'Mappa Poli: Piano Z');
hold on; grid on; axis equal;

% Disegno del cerchio unitario
th = linspace(0, 2*pi, 100);
plot(cos(th), sin(th), 'k:', 'LineWidth', 1.5, 'HandleVisibility', 'off');
line([-1.2 1.2], [0 0], 'Color', 'k', 'HandleVisibility', 'off');
line([0 0], [-1.2 1.2], 'Color', 'k', 'HandleVisibility', 'off');

for i = 1:length(zetas)
    z = zetas(i);
    sys_c = tf(wn^2, [1, 2*z*wn, wn^2]);
    
    % Poli ZOH: z = exp(s*Ts)
    p_zoh = pole(c2d(sys_c, Ts, 'zoh'));
    plot(real(p_zoh), imag(p_zoh), 'x', 'Color', colors(i,:), 'MarkerSize', 12, ...
        'LineWidth', 2, 'DisplayName', ['\zeta = ', num2str(z), ' (Poli ZOH)']);
    
    % Poli Tustin: mappatura bilineare
    p_tus = pole(c2d(sys_c, Ts, 'tustin'));
    plot(real(p_tus), imag(p_tus), 'o', 'Color', colors(i,:)*0.7, 'MarkerSize', 10, ...
        'LineWidth', 2, 'DisplayName', ['\zeta = ', num2str(z), ' (Poli Tustin)']);
end

xlabel('Re(z)'); ylabel('Im(z)');
title('Posizione dei Poli nel Piano Z');
legend('Location', 'southwest');
xlim([-1.1 1.1]); ylim([-1.1 1.1]);