% Script corretto per i modi propri (risposta libera) del secondo ordine
clear; clc; close all;

% Parametri
wn = 2;                         % Pulsazione naturale
t = 0:0.01:20;                  % Intervallo di tempo
y0 = 1;                         % Condizione iniziale (spostamento)
v0 = 0;                         % Condizione iniziale (velocità)
zetas = [0.9, 0.5, 0.2, 0.05, 0, -0.05]; 

figure;
hold on; grid on;

for z = zetas
    % Creazione della funzione di trasferimento
    num = wn^2;
    den = [1, 2*z*wn, wn^2];
    sys_tf = tf(num, den);
    
    % CONVERSIONE: Da Funzione di Trasferimento a Spazio di Stato
    sys_ss = ss(sys_tf);
    
    % L'ordine degli stati in ss(tf(...)) per il 2° ordine è solitamente [v; x]
    % quindi passiamo le condizioni iniziali come vettore colonna
    [y, t_out] = initial(sys_ss, [0; y0], t); % velocità 0, posizione y0
    
    % Assegnazione di uno stile diverso per evidenziare z=0
    if z == 0
        plot(t_out, y, 'r--', 'LineWidth', 2.5, 'DisplayName', '\zeta = 0 (Oscillante)');
    else
        plot(t_out, y, 'LineWidth', 2, 'DisplayName', ['\zeta = ', num2str(z)]);
    end
end

% Formattazione
xlabel('Tempo [s]');
ylabel('Risposta libera y(t)');
title('Modi propri del 2° ordine (Risposta Libera)');
legend('Location', 'best');
ylim([-1.5 1.5]);
line(get(gca,'XLim'), [0 0], 'Color', 'k', 'HandleVisibility', 'off');