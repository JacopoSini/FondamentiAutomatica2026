% Risposta libera 2° ordine nel tempo discreto
clear; clc; close all;

Ts = 0.1;           % Tempo di campionamento
k = 0:80;           % Campioni
zetas = [1.1 1.0 0.9, 0.5, 0.2, 0]; 
wn = 2;

figure; hold on; grid on;

for z = zetas
    % Sistema continuo -> discreto
    sys_c = tf(wn^2, [1, 2*z*wn, wn^2]);
    sys_d = c2d(sys_c, Ts);
    
    % Convertiamo in spazio di stato per gestire le condizioni iniziali
    sys_ss = ss(sys_d);
    
    % Condizione iniziale: spostamento unitario [0; 1]
    [y, t_out] = initial(sys_ss, [0; 1], k*Ts);
    
    stem(k, y, 'filled', 'DisplayName', ['\zeta = ', num2str(z)]);
end

xlabel('Campione (k)');
ylabel('Uscita y(k)');
title('Modi propri discreto 2° ordine (Risposta Libera)');
legend;