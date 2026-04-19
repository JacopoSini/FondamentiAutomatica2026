clear; clc; close all;

% --- PARAMETRI DI ESPORTAZIONE ---
nome_file = 'animazione_poli_con_aliasing.gif';
scrivi_gif = true; % Imposta a false se vuoi solo vedere l'animazione senza salvare

% Parametri di campionamento
Ts = 0.1;           
fs = 1/Ts; fn = fs/2;
t_vec = 0:Ts:2;     
t_fine = 0:0.001:2; 
f_real_vec = linspace(0.1, 10, 100); % Ridotto numero frame per una GIF più leggera

h_fig = figure('Color', 'w', 'Position', [100, 100, 1000, 500]);

% --- SETUP GRAFICO ---
subplot(1, 2, 1); hold on; axis equal; grid on;
theta = linspace(0, 2*pi, 100); plot(cos(theta), sin(theta), 'k:'); 
line([-1 0], [0 0], 'Color', 'r', 'LineWidth', 3); % Limite Nyquist
h_pole = plot(1, 0, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
h_line = line([0 1], [0 0], 'Color', 'b', 'LineStyle', '--');
title('Piano Z'); xlim([-1.2 1.2]); ylim([-1.2 1.2]);

subplot(1, 2, 2); hold on; grid on;
h_cont = plot(t_fine, sin(2*pi*0.1*t_fine), 'Color', [0.7 0.7 0.7]);
h_disc = stem(t_vec, sin(2*pi*0.1*t_vec), 'b', 'LineWidth', 1.5);
title('Dominio del Tempo'); ylim([-1.5 2.8]);
txt_info = text(0.05, 2.2, '', 'FontSize', 9, 'FontWeight', 'bold', 'EdgeColor', 'k');

% --- LOOP ANIMAZIONE E SCRITTURA GIF ---
for k = 1:length(f_real_vec)
    f = f_real_vec(k);
    f_percepita = abs(mod(f + fn, fs) - fn);
    
    % Aggiornamento Grafico
    z = exp(1i * 2*pi * f * Ts);
    set(h_pole, 'XData', real(z), 'YData', imag(z));
    set(h_line, 'XData', [0 real(z)], 'YData', [0 imag(z)]);
    set(h_cont, 'YData', sin(2*pi * f * t_fine));
    set(h_disc, 'YData', sin(2*pi * f * t_vec));
    
    color_code = [0 0.4 0.8]; if f > fn, color_code = [1 0 0]; end
    set(h_pole, 'MarkerFaceColor', color_code); set(h_disc, 'Color', color_code);
    set(txt_info, 'String', sprintf('Frequenza: %.2f Hz | Percepita: %.2f Hz', f, f_percepita));
    
    drawnow;

    % --- LOGICA DI ESPORTAZIONE GIF ---
    if scrivi_gif
        % Cattura il frame
        frame = getframe(h_fig);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        
        % Scrive sul file
        if k == 1
            imwrite(imind, cm, nome_file, 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
        else
            imwrite(imind, cm, nome_file, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
        end
    end
end

fprintf('Animazione salvata come: %s\n', nome_file);