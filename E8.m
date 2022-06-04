%Gabriel Alexandre de Souza Braga 
clear;
close all;
clc;
%% Prametros %%
fc = 1000;     % Freq. do simbolo (portadora)
Fs = 16*fc;    % Freq. de amostragem
Ts = 1/Fs;      % Período de amostragem
Tc = 1/fc;    % Período de um ciclo da onda portadora
Tsimb = 4*Tc;  % Período do símbolo

% Gera símbolos
ts = 0:Ts:Tsimb-Ts;
simb_0 = 0.5*cos(2*pi*fc*ts);
simb_1 = 0.5*cos(2*pi*fc*ts+pi);

%% Carrega os vetores do tempo "t" e do sinal modulado "s" %%
load E8_PSK_2.mat 
t = 0:Ts:(length(s)-1)*Ts;

%% Determine a magnitude espectral do sinal modulado %%
L = length(s);  
S = fft(s)/L;       
mag = abs(S);
mag = 2*mag(1:L/2+1);
f0 = Fs*(0:(L/2))/L;

%% Demodula o sinal %%
bin =  char(zeros(1,length(s)/length(simb_0))); % Inicializando vetor de infomação binaria
j = 0;
for i = 1:length(s)/length(simb_0)
    if abs(s(j+1)-simb_0(1)) == 0
        bin(i)='0';
    else
        bin(i)='1';
    end
    j = i*length(simb_0);
end

strBin = char(bin2dec(reshape(bin,8,[]).').');
disp(strBin);

%% Plota gráficos no domínio do tempo %%
% Cria figura
figure1 = figure('PaperOrientation', 'landscape', 'PaperUnits', 'centimeters',...
    'PaperType', 'A4',...
    'WindowState', 'maximized',...
    'Color', [1 1 1],...
    'Renderer', 'painters');

% Cria subplot do comercial
subplot1 = subplot(2, 1, 1, 'Parent', figure1);
hold(subplot1, 'on');

% Cria plot
plot1 = plot(ts*1e3, simb_0, ts*1e3, simb_1, 'Parent', subplot1, 'LineWidth', 3);    
set(plot1(1),'DisplayName','simbolos_0', 'Color', [0.00,0.45,0.74]);
set(plot1(2),'DisplayName','simbolos_1', 'Color', [0.85,0.33,0.10]);

% Cria rotulo y e x
ylabel('Amplitude   (V)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Tempo   (ms)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% Cria titulo
title('Símbolos');

% Define limites do plot, para x e y
xlim(subplot1, [0 ts(end)*1e3]);
ylim(subplot1, [-0.55 0.55]);

% Liga as grades e etc
box(subplot1, 'on');
grid(subplot1, 'on');
hold(subplot1, 'off');

% Define as propriedades restantes dos eixos
set(subplot1, 'AlphaScale', 'log', 'ColorScale', 'log', 'FontName',...
    'Times New Roman', 'FontSize', 16, 'FontWeight', 'bold', 'GridAlpha', 0.5,...
    'LineWidth', 1.5, 'MinorGridAlpha', 0.5);

% Define legendas
legend1 = legend(subplot1,'show');
set(legend1,'Location','southeast','LineWidth',1,'FontSize',16);

% Plota sinal modulado
% Cria subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure1);
hold(subplot2, 'on');

% Cria plot
plot(t, s, 'DisplayName', 'Sinal modulado', 'Parent', subplot2, 'LineWidth', 3,...
    'Color', [0.00,0.45,0.74]);

% Cria rotulo y e x
ylabel('s_{PSK,2}   (t)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Tempo   (s)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');

% Cria titulo
title('Sinal modulado do 1^o byte da frase do biscoito da sorte');

% Define limites do plot, para x e y
xlim(subplot2, [0 8*Tsimb]);
ylim(subplot2, [-0.55 0.55]);

% Liga as grades e etc
box(subplot2, 'on');
grid(subplot2, 'on');
hold(subplot2, 'off');

% Define as propriedades restantes dos eixos
set(subplot2, 'AlphaScale', 'log', 'ColorScale', 'log', 'FontName',...
    'Times New Roman', 'FontSize', 16, 'FontWeight', 'bold', 'GridAlpha', 0.5,...
    'LineWidth', 1.5, 'MinorGridAlpha', 0.5);

% Plota analise espectral %
% Cria figura
figure2 = figure('PaperOrientation', 'landscape', 'PaperUnits', 'centimeters',...
    'PaperType', 'A4',...
    'WindowState', 'maximized',...
    'Color', [1 1 1],...
    'Renderer', 'painters');

% Cria subplot da magnitude espectral do sinal modulado
axes1 = axes('Parent', figure2);
hold(axes1, 'on');

% Cria plot
plot2 = plot(f0/1e3, mag, 'LineWidth', 3);
set(plot2,'DisplayName', 'Espectro', 'Color', [0.00,0.45,0.74]);

% Cria rotulo y e x
ylabel('|f_0(f)|   (V)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Frequência   (kHz)', 'FontWeight', 'bold',...
    'FontName', 'Times New Roman');

% Cria titulo
title('Espectro do sinal modulado');

% Define limites do plot, para x e y
xlim(axes1, [0 2]);
ylim(axes1, [0 0.15]);

% Liga as grades e etc
box(axes1, 'on');
grid(axes1, 'on');
hold(axes1, 'off');

% Define as propriedades restantes dos eixos
set(axes1, 'AlphaScale', 'log', 'ColorScale', 'log', 'FontName',...
    'Times New Roman', 'FontSize', 16, 'FontWeight', 'bold', 'GridAlpha', 0.5,...
    'LineWidth', 1.5, 'MinorGridAlpha', 0.5);
