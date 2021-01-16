%% Arrumar frequencia e deslocamento no simulink validacao.slx

%Parâmetros

% Parâmetros - 0V
% Kx = 0.80204993;
% Kw = 50.236842;
% rho = 42.7448555556;

% Parâmetros - 0.88V
% Kx = 0.80204993+0.587739*0.8712; % kxa + kxb*v
% Kw = 50.236842+182.996233*0.8712; % kwa + kwb*v
% rho = 31.587853;

% Parâmetros - 3.312V
% Kx = 0.3834*(2.178)^2 + 0.2537*2.178 + 0.802; % Teste de validação feito com 2.178V
% Kw = -10.102*(2.178)^2 + 191.8*2.178 + 50.237;
% rho = 6.2979*(2.178)^2 - 31.1*2.178 + 42.745;
% Simulação - Gerar força teórica

% Parâmetros - 1.98V
% Kx = 0.0855*(0.8712)^3 + 0.0342*(0.8712)^2 + 0.4931*(0.8712) + 0.802;
% Kw = 3.6157*(0.8712)^3 - 24.866*(0.8712)^2 + 201.92*(0.8712) + 50.237;
% rho = -2.8368*(0.8712)^3 + 17.881*(0.8712)^2 - 39.038*(0.8712) + 42.745;

% Parâmetros - BW - 0V
Kx = 0.7682051;
Kw = 57.42103;
rho = 27.4527;
n = 1.9092;
sigma = 127.1242;

Tf = 10;
Ts = 0.001;
%sim('Validacao.slx');
sim('Validacao_BW.slx');

%plot(x_FS(:,3))
% plot(x_FS(:,2),x_FS(:,3),'LineWidth',1.5,'Color','b')
% xlabel('Velocity'); ylabel('Force');
% set(gca,'FontSize',12); % Determina tamanho da fonte
% set(gcf,'color','white'); % Determina fundo da imagem branco
% grid on;
%% Puxar dados do Ensaio Prático

load('ensaio.vali.9.mat')

%% Rodar STEP2 para organizar os dados em matrizes
%% Rodar simulação Passo1.5
sim('Passo1_5.slx');
%plot(x_F(:,3));
% plot(x_F(:,2),x_F(:,3),'LineWidth',1.5,'Color','b')
% xlabel('Velocity'); ylabel('Force');
% set(gca,'FontSize',12); % Determina tamanho da fonte
% set(gcf,'color','white'); % Determina fundo da imagem branco
% grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Encontrar amostras para sobrepor gráficos

for i=1:length(x_F(:,3))
    if abs(x_F(i,3))< 5 
        if x_F(i-1,3)< x_F(i,3)
        amostra = i; %amostra do grafico experimental
        end
        break;
    end
end

for i=10:length(x_FS(:,3))
    if abs(x_FS(i,3))< 5
        if x_FS(i-10,3)< 0
        amostra1 = i; %amostra do grafico teórico
        break;
        end
    end
end

%% Escolher intervalo de análise

tt1 = (amostra:amostra+1000);
tt2 = (amostra1:10:((1000*10)+1));

forc2 = forc1(tt1,2); %exp
forc3 = x_FS(tt2,3); %teorico

plot(forc2);
hold on
plot(forc3);
hold off

%% Corrigir Regime

tt = (1:400);

forc2 = forc2(tt); %exp
forc3 = forc3(tt); %teorico

plot(forc2);
hold on
plot(forc3);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Escolher intervalo de análise

tt1 = (100:1000);

dist2 = dist1(tt1,2);
forc2 = forc1(tt1,2); %exp
vel2 = vel1(tt1,2);
forc3 = x_FS(tt1*10,3); %teorico
vel3 = x_FS(tt1*10,2);

%CÓDIGO DA FIGURA 4.3
figure
plot(forc2,'DisplayName','Experimental');
xlabel('Amostras'); ylabel('Força (N)');
grid on
hold on
plot(forc3,'DisplayName','Model');
hold off
legend('Experimental','Modelo')
set(gca,'FontSize',10);
set(gcf,'color','white');
%xlim([0 900]);
%print('Vali','-dpdf');
%% Corrigir Regime

tt = (730:860); 

dist2 = dist2(tt);
forc2 = forc2(tt); %exp
vel2 = vel2(tt);
forc3 = forc3(tt); %teorico
vel3 = vel3(tt);

% CÓDIGO DA FIGURA 4.4
% plot(vel2,forc2,'LineWidth',1.0,'Color','b')
% hold on
% plot(vel3,forc3,'LineWidth',1.0,'Color','r')
% xlabel('Velocidade (mm/s)'); ylabel('Força (N)');
% set(gca,'FontSize',10); % Determina tamanho da fonte
% set(gcf,'color','white'); % Determina fundo da imagem branco
% grid on;
%legend('Experimental','Modelo')
%print('Hist_TvsP','-dpdf');

% CÓDIGO DAS FIGURAS 4.1 E 4.2
% figure
% subplot(2,2,[1 2])
% plot(Tout(:,1),x_F(:,3),'LineWidth',1.5,'Color','k')
% axis([0 15 -400 400])
% xlabel('Tempo (s)'); ylabel('Força (N)');
% set(gca,'FontSize',10);
% set(gcf,'color','white');
% grid on;
% subplot(2,2,3)
% plot(vel2,forc2,'LineWidth',1.0,'Color','r')
% axis([-100 100 -400 400])
% xlabel('Velocidade (mm/s)'); ylabel('Força (N)');
% set(gca,'FontSize',10);
% set(gcf,'color','white');
% grid on;
% subplot(2,2,4)
% plot(dist2,forc2,'LineWidth',1.5,'Color','b')
% axis([-20 20 -400 400])
% xlabel('Deslocamento (mm)'); ylabel('Força (N)');
% set(gca,'FontSize',10);
% set(gcf,'color','white');
% grid on;
% print('Trio_088V','-dpdf');
plot(forc2);
hold on
plot(forc3);
hold off
%% Calculo erro

    i = 1;

for i=1:length(tt);
    fe = forc2(i);%exp
    fi = forc3(i); %teorico
    e(i) = (abs(fe-fi))/(abs(fe));
end

soma = 0;
i=1;
for i = 1:length(tt);
    soma = soma + e(i);
end
erro = soma / length(tt);;

%tt1 = (108:500);

% plot(forc1(tt1,2));
% hold on
% plot(x_FS(tt1*200,3));
% hold off

plot(forc2(:));
hold on 
plot(forc3(:));


