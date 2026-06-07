clear; clc; close all;

s = tf('s');
G = (10*(s + 5)) / (s * (s + 2) * (s + 20));

figure('Name', 'Diagramma di Nyquist', 'NumberTitle', 'off');
nyquist(G);
grid on;
axis([-2 2 -2 2]); % Zoom per vedere la curva vicino all'origine
title('Diagramma di Nyquist di G(s)');