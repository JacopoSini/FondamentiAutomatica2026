% Risposta al gradino del secondo ordine nel tempo discreto
clear; clc; close all;

Ts = 0.1;           % Tempo di campionamento
t_final = 10;
zetas = [1.1, 1, 0.9, 0.2, 0.05, 0, -0.01];
wn = 2;             % Pulsazione naturale

figure(1); hold on; grid on;

for z = zetas
    % Creiamo il sistema continuo e lo discretizziamo
    sys_c = tf(wn^2, [1, 2*z*wn, wn^2]);
    sys_d = c2d(sys_c, Ts, 'zoh'); % Discretizzazione Zero-Order Hold
    
    [y, t_out] = step(sys_d, t_final);
    
    stairs(t_out, y, 'LineWidth', 1.5, 'DisplayName', ['\zeta = ', num2str(z)]);
end

line([0 t_final], [1 1], 'Color', 'k', 'LineStyle', '--', 'HandleVisibility', 'off');
xlabel('Tempo [s]');
ylabel('Risposta y(kT)');
title('Risposta al gradino discreta (Trasformata Z)');
legend('Location', 'best');
ylim([-0.2 2.2]);


% Visualizzazione stabilità nel piano Z
figure(2);
hold on;

% Disegna il cerchio unitario (limite di stabilità)
theta = linspace(0, 2*pi, 100);

for z = zetas 
    sys_c = tf(wn^2, [1, 2*z*wn, wn^2]);
    sys_d = c2d(sys_c, Ts);
    
    [poles, ~] = pzmap(sys_d);
    plot(real(poles), imag(poles), 'x', 'LineWidth', 2, 'MarkerSize', 10, ...
         'DisplayName', ['\zeta = ', num2str(z)]);
end
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 1, 'DisplayName','Cerchio unitario');

axis equal;
xlabel('Reale [s^{-1}]');
ylabel('Immaginario [s^{-1}]');
title('Mappa Poli nel Piano Z (Cerchio Unitario)');
legend;
grid on;