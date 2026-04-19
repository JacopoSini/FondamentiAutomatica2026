clear; clc; close all;

figure('Color', 'w', 'Name', 'Intervalli di Frequenza nel Piano Z');
hold on; axis equal; grid on;

% 1. Parametri Grafici
theta_nyquist = pi;
theta_quad = pi/2;

% 2. Disegna i settori colorati
% SETTORE 1: Basse Frequenze [0, fs/4] -> Angolo [0, pi/2]
t1 = linspace(-theta_quad, theta_quad, 100);
patch([0 cos(t1) 0], [0 sin(t1) 0], [0.8 1 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.4);

% SETTORE 2: Alte Frequenze [fs/4, fs/2] -> Angolo [pi/2, pi] e [-pi, -pi/2]
t2 = linspace(theta_quad, pi, 100);
t3 = linspace(-pi, -theta_quad, 100);
patch([0 cos(t2) 0], [0 sin(t2) 0], [1 0.8 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.4);
patch([0 cos(t3) 0], [0 sin(t3) 0], [1 0.8 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.4, 'HandleVisibility', 'off');

% 3. Cerchio unitario e Assi
theta_circle = linspace(0, 2*pi, 500);
plot(cos(theta_circle), sin(theta_circle), 'k', 'LineWidth', 2, 'HandleVisibility', 'off');
line([-1.2 1.2], [0 0], 'Color', [0.4 0.4 0.4], 'HandleVisibility', 'off');
line([0 0], [-1.2 1.2], 'Color', [0.4 0.4 0.4], 'HandleVisibility', 'off');

% 4. Punti Notevoli
plot(1, 0, 'go', 'MarkerFaceColor', 'g', 'DisplayName', 'f = 0 (Costante)');
plot(0, 1, 'bo', 'MarkerFaceColor', 'b', 'DisplayName', 'f = f_s / 4');
plot(-1, 0, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'f = f_s / 2 (Nyquist)');

% 5. Legenda con intervalli
legend({ ...
    'Basse freq: [0 \leq f < f_s/4]', ...
    'Alte freq: [f_s/4 \leq f \leq f_s/2]', ...
    'Punto f = 0', ...
    'Punto f = f_s/4', ...
    'Limite di Nyquist' ...
    }, 'Location', 'northeastoutside');

title('Mappatura Frequenze sul Cerchio Unitario');
xlabel('Re(z)'); ylabel('Im(z)');
xlim([-1.3 1.3]); ylim([-1.3 1.3]);

% Annotazione grafica del limite
text(-1.25, -0.1, 'ZONA ALIASING \rightarrow', 'Color', 'r', 'FontWeight', 'bold', 'Rotation', 90);