% Sistema del primo ordine a tempo discreto
clear; clc; close all;

T = 1;              % Tempo di campionamento
k = 0:40;           % Passi temporali
y0 = 1;             % Condizione iniziale
a_values = [0.5, 0.9, 1, 1.1]; 

figure; hold on; grid on;

for a = a_values
    % Risposta libera: y(k) = y0 * a^k
    y = y0 * (a.^k);
    
    % Usiamo 'stem' per evidenziare la natura discreta dei dati
    stem(k, y, 'LineWidth', 1.5, 'DisplayName', ['a = ', num2str(a)]);
end

xlabel('Campioni (k)');
ylabel('Risposta y(k)');
title('Risposta del primo ordine nel tempo discreto: y(k+1) = ay(k)');
legend('Location', 'best');
ylim([0 2]);