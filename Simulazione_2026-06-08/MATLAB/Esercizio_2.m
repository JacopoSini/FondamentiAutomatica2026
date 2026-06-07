clear; clc; close all;

% 1. DEFINIZIONE DEL SISTEMA REALE
s = tf('s');
G = (10*(s + 5)) / (s * (s + 2) * (s + 20));

% Generazione del vettore delle frequenze per una risoluzione ottimale
w = logspace(-2, 3, 2000); 

% Calcolo della risposta reale (modulo e fase)
[mag, phase] = bode(G, w);
mag_db = 20*log10(squeeze(mag));
phase_deg = squeeze(phase);

% Per evitare salti di +-360 gradi nella fase reale di MATLAB
phase_deg = unwrap(phase_deg * pi / 180) * 180 / pi;

% 2. COSTRUZIONE DEI DIAGRAMMI ASINTOTICI (Manuale)
% Definiamo i punti di rottura (frequenze di taglio e limiti del grafico)
w_asint = [0.01, 2, 5, 20, 1000];

% --- MODULO ASINTOTICO ---
% Calcoliamo l'altezza iniziale a w = 0.01. 
% La retta iniziale ha pendenza -20 dB/dec e passa per |Kb|_db a w = 1.
Kb_db = 20*log10(1.25); 
mag_asint = zeros(size(w_asint));

mag_asint(1) = Kb_db - 20*log10(w_asint(1)/1); % Valore a w = 0.01
mag_asint(2) = mag_asint(1) - 20*log10(w_asint(2)/w_asint(1)); % Pendenza -20 fino a w=2
mag_asint(3) = mag_asint(2) - 40*log10(w_asint(3)/w_asint(2)); % Pendenza -40 fino a w=5
mag_asint(4) = mag_asint(3) - 20*log10(w_asint(4)/w_asint(3)); % Pendenza -20 fino a w=20
mag_asint(5) = mag_asint(4) - 40*log10(w_asint(5)/w_asint(4)); % Pendenza -40 fino a w=1000

% --- FASE ASINTOTICA (Modello a gradoni semplificato) ---
% Specifichiamo i valori della fase negli intervalli
w_phase_asint = [0.01, 2, 2, 5, 5, 20, 20, 1000];
phase_asint   = [-90, -90, -180, -180, -90, -90, -180, -180];


%% 3. GRAFICI ASINTOTICI
figure('Name', 'Diagramma di Bode: Reale vs Asintotico', 'NumberTitle', 'off');

% Subplot del Modulo
subplot(2,1,1);
semilogx(w_asint, mag_asint, 'k--', 'LineWidth', 2); % Approssimazione Asintotica
hold on;
grid on;
title('Diagramma delle Ampiezze (Modulo)');
xlabel('Frequenza \omega (rad/s)');
ylabel('Magnitudo (dB)');


% Subplot della Fase
subplot(2,1,2);
semilogx(w_phase_asint, phase_asint, 'k--', 'LineWidth', 2); % Approssimazione Asintotica
hold on;
grid on;
title('Diagramma delle Fasi');
xlabel('Frequenza \omega (rad/s)');
ylabel('Fase (gradi)');


%% SOVRAPPOSIZIONE GRAFICI REALI
subplot(2,1,1);
semilogx(w, mag_db, 'b-', 'LineWidth', 2); % Curva Reale
legend('Approssimazione Asintotica', 'Risposta Reale',  'Location', 'best');

subplot(2,1,2);
semilogx(w, phase_deg, 'b-', 'LineWidth', 2); % Curva Reale
legend('Approssimazione Asintotica', 'Risposta Reale',  'Location', 'best');