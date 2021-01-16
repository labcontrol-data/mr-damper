%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab file - code works in Matlab 2017a 
% Code written by Alessandro N. Vargas
% email: avargas@utfpr.edu.br
% www.anvargas.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all, close all, clc, format long, format compact,

load('data_simulation_4.1_MRdamper.mat')

position_real = x_F(1:1500,1);
velocity_real = x_F(1:1500,2);
force_real = x_F(1:1500,3);

figure(1),
plot(velocity_real,force_real,'LineWidth',1.5,'Color','b')
xlabel('Velocity'); ylabel('Force');
grid
axis([-100 100 -400 400])

pos_v0 = position_real;
vel_v0 = velocity_real;
force_v0 = force_real;
TS = Ts;
tiempo = TS*[0:max(size(pos_v0))-1];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation of the Dahl model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Amplitude = 12.375; % displacement
fq = 0.8403; %Input Frequency                      
c=12.375;     % Input number of cycles                         
dt     = 1/(fq*100000);    % Time Increment                        
omega  = fq * 2* pi;    % Cyclic forcing frequency  
T      = 1/fq;          % Natural period of the excitation
tt     = T * c;         % Total duration of the excitation
t      = 0 : dt : tt-dt;

phase=1.42;

% vector I abajo contiene los datos de entrada-input. Esa ola es la misma
% que fue experimentada en la practica en el throttle
for i  = 1:length(t);
    I(i)   = ( Amplitude * sin (omega * t(i) + phase));
end

figure(2),
hold on
plot(tiempo,position_real,'k','LineWidth',3),
ylabel('displac')
xlabel('time(sec)'),
plot(t,I,'r','LineWidth',1)
hold off, grid,
legend('displacReal','displacSimulated','forceSimulated')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Kw=57.42;
Kx=0.7682;
n=1;
rho = 27.45;

assignin ('base','Kw',Kw)
assignin ('base','Kx',Kx)
assignin ('base','n',n)
assignin ('base','Input',I')
assignin ('base','Time',t')
assignin ('base','dt',dt')

%-----------------
sim('DahldissertacaoJoao')
%-----------------

load('MyOutput.mat');
load('dotxt.mat');

velocitySimulated = dotxt(2,:);
forceSimulated =  MyOutput(2,:);

figure(3)
hold on
plot(tiempo,force_real,'b','LineWidth',2 );
plot(t, Input, 'r','LineWidth',1 );
plot(t, forceSimulated , 'k','LineWidth',3 );
title('DahlSimulated');
xlabel('time (sec)'),ylabel('y')
legend('forceReal','displacement','forceSimulated')
hold off
grid

figure(4)
hold on
plot(velocitySimulated,forceSimulated, 'r','LineWidth',2 )
plot(velocity_real,force_real,'LineWidth',1,'Color','b')
title('DahlSimulated');
xlabel('Velocity'),ylabel('outputForce')
grid

savefile = 'data_simulation_Joao_parte2_B.mat';
save(savefile,'tiempo','force_real','t','forceSimulated','TS','t','-v7');


load('data_simulation_4.2_MRdamper.mat')

position_real = x_F(:,1);
velocity_real = x_F(:,2);
force_real = x_F(:,3);

figure(5),
plot(velocity_real,force_real,'LineWidth',1.5,'Color','b')
xlabel('Velocity'); ylabel('Force');
axis([-100 100 -400 400])

pos_v088 = position_real;
vel_v088 = velocity_real;
force_v088 = force_real;

savefile = 'data_simulation_Joao_parte1.mat';
save(savefile,'pos_v0','vel_v0','force_v0','pos_v088','vel_v088','force_v088','TS','t','-v7');


load('data_simulation_4.4_MRdamper.mat')

position_real = x_F(:,1);
velocity_real = x_F(:,2);
force_real = x_F(:,3);
TS = Ts;
tiempo = TS*[0:max(size(position_real))-1];


Amplitude = 9.59; % displacement
fq = 0.8378; %Input Frequency                      
c=12.5;     % Input number of cycles                         
dt     = 1/(fq*100000);    % Time Increment                        
omega  = fq * 2* pi;    % Cyclic forcing frequency  
T      = 1/fq;          % Natural period of the excitation
tt     = T * c;         % Total duration of the excitation
t      = 0 : dt : tt-dt;

phase=1.56;

for i  = 1:length(t);
    I(i)   = ( Amplitude * sin (omega * t(i) + phase));
end

figure(6),
hold on
plot(tiempo,position_real,'k','LineWidth',3),
ylabel('displac')
xlabel('time(sec)'),
plot(t,I,'r','LineWidth',1)
hold off, grid,
legend('displacReal','displacSimulated','forceSimulated')


figure(7),
hold on
plot(velocity_real,force_real,'LineWidth',1.5,'Color','b')
plot(x_FS(:,2), x_FS(:,3),'LineWidth',1,'Color','r')
hold off
xlabel('Velocity'); ylabel('Force');
axis([-100 100 -400 400])


tt1 = (1:1000);

dist2 = dist1(tt1,2);
forc2 = forc1(tt1,2); %exp
vel2 = vel1(tt1,2);
forc3 = x_FS(tt1*10,3); %teorico
vel3 = x_FS(tt1*10,2);

figure(8)
plot(forc2,'DisplayName','Experimental');
xlabel('Amostras'); ylabel('For�a (N)');
grid on
hold on
plot(forc3,'DisplayName','Model');
hold off
legend('Experimental','Modelo')
set(gca,'FontSize',10);
set(gcf,'color','white');

figure(9)
hold on
plot(vel2, forc2,'LineWidth',1.5,'Color','b')
plot(vel3, forc3,'LineWidth',1.5,'Color','r')
hold off
xlabel('VelocityTeor'); ylabel('ForceTeor');

forceReal = forc2;
forceSimulated = forc3;
t = TS*[0:max(size(forc2))-1];

savefile = 'data_simulation_Joao_parte2.mat';
save(savefile,'forceReal','forceSimulated','TS','t','-v7');

