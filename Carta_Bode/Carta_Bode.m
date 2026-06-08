clear; clc; close all;

% =========================================================================
% CONFIGURAZIONE DELLA CARTA LOGARITMICA
% =========================================================================
w_min = 10^(-1);  % Frequenza minima (rad/s)
w_max = 10^(4);   % Frequenza massima (rad/s)

mag_min = -60;    % Modulo minimo (dB)
mag_max = 40;     % Modulo massimo (dB)
mag_step = 10;    % Passo della griglia principale del modulo

phase_min = -270; % Fase minima (gradi)
phase_max = 90;   % Fase massima (gradi)
phase_step = 45;  % Passo della griglia principale della fase

% =========================================================================
% CREAZIONE DELLA FIGURA (Formato A4 Orizzontale per la stampa)
% =========================================================================
hFig = figure('Name', 'Carta Logaritmica per Diagrammi di Bode', ...
              'Units', 'centimeters', 'Position', [1, 1, 29.7, 21], ...
              'PaperOrientation', 'landscape', 'PaperType', 'A4', ...
              'PaperPositionMode', 'auto');

% --- SUBPLOT 1: CARTA PER IL MODULO (dB) ---
ax1 = subplot(2, 1, 1);
% Definiamo i vettori per la griglia logaritmica fitta
decades = log10(w_min):log10(w_max);
w_grid = [];
for d = decades(1:end-1)
    w_grid = [w_grid, (10^d)*(1:9)]; %#ok<AGROW>
end
w_grid = [w_grid, w_max];

% Tracciamento linee verticali della griglia logaritmica (Frequenze)
for i = 1:length(w_grid)
    if mod(log10(w_grid(i)), 1) == 0
        % Linee delle decadi principali (più spesse)
        semilogx([w_grid(i) w_grid(i)], [mag_min mag_max], 'Color', [0.5 0.5 0.5], 'LineWidth', 1.2);
    else
        % Linee delle sotto-divisioni logaritmiche (più sottili)
        semilogx([w_grid(i) w_grid(i)], [mag_min mag_max], 'Color', [0.85 0.85 0.85], 'LineWidth', 0.5);
    end
    hold on;
end

% Tracciamento linee orizzontali (dB)
mag_grid = mag_min:mag_step:mag_max;
for m = mag_grid
    semilogx([w_min w_max], [m m], 'Color', [0.5 0.5 0.5], 'LineWidth', 0.8);
end
% Evidenzia lo zero dB se presente nell'intervallo
if mag_min <= 0 && mag_max >= 0
    semilogx([w_min w_max], [0 0], 'Color', [0 0 0], 'LineWidth', 1.5);
end

% Proprietà grafiche Modulo
grid off; % Disattiviamo la griglia nativa per usare la nostra personalizzata fitta
xlim([w_min w_max]);
ylim([mag_min mag_max]);
set(ax1, 'XScale', 'log', 'XTick', 10.^decades, 'YTick', mag_grid);
title('DIAGRAMMA DELLE AMPIEZZE (MODULO)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Magnitudo [dB]', 'FontSize', 10);
set(ax1, 'XTickLabel', []); % Rimuove le etichette delle frequenze dal primo grafico per pulizia

% --- SUBPLOT 2: CARTA PER LA FASE (Gradi) ---
ax2 = subplot(2, 1, 2);

% Tracciamento linee verticali della griglia logaritmica (Frequenze)
for i = 1:length(w_grid)
    if mod(log10(w_grid(i)), 1) == 0
        semilogx([w_grid(i) w_grid(i)], [phase_min phase_max], 'Color', [0.5 0.5 0.5], 'LineWidth', 1.2);
    else
        semilogx([w_grid(i) w_grid(i)], [phase_min phase_max], 'Color', [0.85 0.85 0.85], 'LineWidth', 0.5);
    end
    hold on;
end

% Tracciamento linee orizzontali (Fase)
phase_grid = phase_min:phase_step:phase_max;
for p = phase_grid
    semilogx([w_min w_max], [p p], 'Color', [0.5 0.5 0.5], 'LineWidth', 0.8);
end
% Evidenzia i -180 gradi e lo 0 se presenti
if phase_min <= -180 && phase_max >= -180
    semilogx([w_min w_max], [-180 -180], 'Color', [0.7 0 0], 'LineWidth', 1.2); % Linea rossa critica per Nyquist/Bode
end

% Proprietà grafiche Fase
grid off;
xlim([w_min w_max]);
ylim([phase_min phase_max]);
set(ax2, 'XScale', 'log', 'XTick', 10.^decades, 'YTick', phase_grid);
title('DIAGRAMMA DELLE FASI', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Pulsazione \omega [rad/s]', 'FontSize', 10);
ylabel('Fase [gradi]', 'FontSize', 10);

% Link degli assi per lo zoom sincronizzato se si consulta a schermo
linkaxes([ax1, ax2], 'x');

% =========================================================================
% COMANDO DI STAMPA AUTOMATICA
% =========================================================================
% Rende lo sfondo della figura bianco per evitare sprechi di inchiostro
set(hFig, 'Color', 'w');

% Rinfresca la grafica prima della stampa
drawnow;

% Chiede all'utente se desidera stampare o salvare direttamente
scelta = questdlg('Vuoi inviare la carta logaritmica alla stampante o salvarla come PDF?', ...
	'Opzioni di Stampa', ...
	'Invia alla stampante','Salva come PDF','Annulla','Salva come PDF');

switch scelta
    case 'Invia alla stampante'
        printdlg(hFig); % Apre l'interfaccia di stampa di sistema
    case 'Salva come PDF'
        [file, path] = uiputfile('*.pdf', 'Salva Carta Logaritmica come', 'Carta_Bode.pdf');
        if file ~= 0
            exportgraphics(hFig, fullfile(path, file), 'ContentType', 'vector');
            msgbox('File PDF vettoriale salvato con successo!', 'Operazione Completata');
        end
end