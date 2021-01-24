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
xlabel('Amostras'); ylabel('Force (N)');
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% only simulation: two-story building of the Dahl model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('data_simulation_TwoStoryBuildingJoao_SemMRDamper.mat')

vecT = tiempoSim;
displacSim_x1_semMR =  displacSim_x1;
displacSim_x2_semMR =  displacSim_x2;
accelSim_x1_semMR =  accelSim_x1;
accelSim_x2_semMR =  accelSim_x2;

load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat')

displacSim_x1_comMR =  displacSim_x1;
displacSim_x2_comMR =  displacSim_x2;
accelSim_x1_comMR = accelSim_x1;
accelSim_x2_comMR = accelSim_x2;

figure(10)
subplot(2,2,1)
hold on
plot(vecT , 1000*displacSim_x1_semMR ,'b','LineWidth',1);
plot(vecT , 1000*displacSim_x1_comMR ,'r','LineWidth',2);
hold off
ylabel('displac. 1st floor')
xlabel('time (sec.)')
legend('no MR-damper','with MR damper')
title('First floor')

subplot(2,2,2)
hold on
plot(vecT , 1000*displacSim_x2_semMR,'b','LineWidth',1)
plot(vecT , 1000*displacSim_x2_comMR,'r','LineWidth',0.5)
hold off
ylabel('displac. 2nd floor')
xlabel('time (sec.)')
legend('no MR-damper','with MR damper')
title('Second floor')

subplot(2,2,3)
hold on
plot(vecT , accelSim_x1_semMR ,'b','LineWidth',1)
plot(vecT , accelSim_x1_comMR,'r','LineWidth',2)
hold off
ylabel('acceler. 1st floor')
xlabel('time (sec.)')
legend('no MR-damper','with MR damper')


subplot(2,2,4)
hold on
plot(vecT , accelSim_x2_semMR ,'b','LineWidth',1)
plot(vecT , accelSim_x2_comMR,'r','LineWidth',0.5)
hold off
ylabel('acceler. 2nd floor')
xlabel('time (sec.)')
legend('no MR-damper','with MR damper')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This part starts the simulation of the two-store structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen('elcentro.dat','r');
text=textscan(fid,'%f %f');
fclose(fid);
t=text{1,1};
dt=t(2)-t(1);
xgtt=0.1*9.80665*text{1,2};  % unity in N/m^2 (reduced by factor 0.1)

ddotxg = [];
for i=1:max(size(xgtt))
    ddotxg = [ddotxg   xgtt(i)*ones(1,20)];
end

f=70;
f_cutoff = 2; % cutoff frequency
fnorm =f_cutoff/(f/2); % normalized cut off freq, you can change it to any value depending on your requirements
[b1,a1] = butter(4,fnorm,'low'); % Low pass Butterworth filter of order 10
ddotxg = filtfilt(b1,a1,ddotxg); % filtering

TS = 0.001;
t = TS*[1:max(size(ddotxg))];

figure(1)
hold on
plot(t,ddotxg,'b','LineWidth',2)
plot(dt*[1:max(size(xgtt))],xgtt,'r')
hold off    
title('El Centro earthquake')
ylabel('accel. N/m^2')
xlabel('time(sec.)')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation of the two-story Dahl model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k1 = 0.682*10^4;
k2 = 0.822*10^4;
m1 = 24.3;
m2 = 24.3;
c1 = 0.939;
c2 = 0.29;

Ac = [0             1           0          0;
     -(k1+k2)/m1  -(c1+c2)/m1   k2/m1    c2/m1;
      0             0           0          1;
      k2/m2        c2/m2        -k2/m2    -c2/m2];
Bc = [ 0   0  0;
       -1   -1/m1  0;
       0   0  0;
       -1  0  -1/m2;];
Cc = eye(4,4);
Dc = zeros(4,3);
x0 = [0 ; 0 ; 0; 0];

%%%%%%%%%%%%%%%%%%
FlagSelect = 1;   % select either '0' or '1' (without or with MR damper)
%%%%%%%%%%%%%%%%%%

Kw=59.46;     % 0V in the damper
Kx=0.6835;    % 0V in the damper
rho = 30.57;  % 0V in the damper 
Volts = 0;    % 0V in the damper

%Kx=2.2698;      % 1.98V in the damper
%Kw=412.48;      % 1.98V in the damper
%rho=10.95;      % 1.98V in the damper
%Volts = 1.98;   % 1.98V in the damper

assignin ('base','Kw',Kw)
assignin ('base','Kx',Kx)
assignin ('base','Acceleration',ddotxg')
assignin ('base','Time',t')
assignin ('base','dt',TS)

% this piece of code simulates the two-story model
%-----------------
sim('twoStoryBuildingDahldissertacaoJoao')
%-----------------

load('MyOutput.mat');
load('dotxt.mat');

velocitySimulated = dotxt(2,1:end-1);
forceSimulated =  MyOutput(2,1:end-1);

load('SistemaOutput.mat');
tiempoSim = SistemaOutput(1,:);
displacSim_x1= SistemaOutput(2,:);
accelSim_x1 = SistemaOutput(3,:);
displacSim_x2= SistemaOutput(4,:);
accelSim_x2 = SistemaOutput(5,:);

figure(31),
subplot(2,2,1)
plot(tiempoSim, displacSim_x1,'LineWidth',2)
xlabel('time(sec)'), ylabel('displac. x1'),
grid,
title('First floor')
axis([0 54 -0.01 0.01])

subplot(2,2,2)
plot(tiempoSim, displacSim_x2,'LineWidth',2)
xlabel('time(sec)'), ylabel('displac. x2'),
grid,
title('Second floor')
axis([0 54 -0.02 0.02])

subplot(2,2,3)
plot(tiempoSim, accelSim_x1,'k','LineWidth',2)
xlabel('time(sec)'), ylabel('accelerac. x1'),
axis([0 54 -0.2 0.2])
grid,

subplot(2,2,4)
plot(tiempoSim, accelSim_x2,'k','LineWidth',2)
xlabel('time(sec)'), ylabel('accelerac. x2'),
axis([0 54 -0.2 0.2])
grid,

if FlagSelect == 0
    savefile = 'data_simulation_TwoStoryBuildingJoao_SemMRDamper.mat';
else
    if Volts == 0
        savefile = 'data_simulation_TwoStoryBuildingJoao_ComMRDamper0V.mat';
    else
        savefile = 'data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat';
    end
end
save(savefile,'t','ddotxg','TS','tiempoSim','displacSim_x1','accelSim_x1','displacSim_x2','accelSim_x2','-v7');

figure(32)
subplot(2,1,1)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper0V.mat');
hold on
plot(tiempoSim, displacSim_x1,'b','LineWidth',2)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat');
plot(tiempoSim, displacSim_x1,'k','LineWidth',1)
hold off
xlabel('time(sec)'), ylabel('displac. x1'),
legend('0V damper','1.98V damper'),
title('displacements')

subplot(2,1,2)
hold on
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper0V.mat');
plot(tiempoSim, displacSim_x2,'b','LineWidth',2)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat');
plot(tiempoSim, displacSim_x2,'k','LineWidth',1)
hold off
xlabel('time(sec)'), ylabel('displac. x2'),
legend('0V damper','1.98V damper'),


figure(33)
subplot(2,1,1)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper0V.mat');
hold on
plot(tiempoSim, accelSim_x1,'b','LineWidth',2)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat');
plot(tiempoSim, accelSim_x1,'k','LineWidth',1)
hold off
xlabel('time(sec)'), ylabel('accelSim. x1'),
legend('0V damper','1.98V damper'),
title('accelerations')

subplot(2,1,2)
hold on
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper0V.mat');
plot(tiempoSim, accelSim_x2,'b','LineWidth',2)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat');
plot(tiempoSim, accelSim_x2,'k','LineWidth',1)
hold off
xlabel('time(sec)'), ylabel('accelSim. x2'),
legend('0V damper','1.98V damper'),



figure(34)
subplot(2,1,1)
load('data_simulation_TwoStoryBuildingJoao_SemMRDamper.mat');
hold on
plot(tiempoSim, accelSim_x1,'r','LineWidth',2)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat');
plot(tiempoSim, accelSim_x1,'k','LineWidth',1)
hold off
xlabel('time(sec)'), ylabel('accelSim. x1'),
legend('NO damper','1.98V damper'),
title('accelerations')

subplot(2,1,2)
hold on
load('data_simulation_TwoStoryBuildingJoao_SemMRDamper.mat');
plot(tiempoSim, accelSim_x2,'r','LineWidth',2)
load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat');
plot(tiempoSim, accelSim_x2,'k','LineWidth',1)
hold off
xlabel('time(sec)'), ylabel('accelSim. x2'),
legend('NO damper','1.98V damper'),



load('data_simulation_TwoStoryBuildingJoao_SemMRDamper.mat');
disp('=========SEM MR damper=============')
max_displacSim_x1 = 1000*max(abs(displacSim_x1))
max_displacSim_x2 = 1000*max(abs(displacSim_x2))
max_accelSim_x1 = max(abs(accelSim_x1))
max_accelSim_x2 = max(abs(accelSim_x2))
disp('===========================')


load('data_simulation_TwoStoryBuildingJoao_ComMRDamper0V.mat');
disp('==========com MR DAMPER 0V =============')
max_displacSim_x1 = 1000*max(abs(displacSim_x1))
max_displacSim_x2 = 1000*max(abs(displacSim_x2))
max_accelSim_x1 = max(abs(accelSim_x1))
max_accelSim_x2 = max(abs(accelSim_x2))
disp('===========================')

load('data_simulation_TwoStoryBuildingJoao_ComMRDamper198V.mat');
disp('==========com MR damper 1.98v=================')
max_displacSim_x1 = 1000*max(abs(displacSim_x1))
max_displacSim_x2 = 1000*max(abs(displacSim_x2))
max_accelSim_x1 = max(abs(accelSim_x1))
max_accelSim_x2 = max(abs(accelSim_x2))
disp('===========================')

figure(35)
hold on
plot(t, forceSimulated , 'k','LineWidth',3 );
title('DahlSimulated');
xlabel('time (sec)'),ylabel('y')
legend('forceReal','displacement','forceSimulated')
hold off
grid

figure(36)
hold on
plot(velocitySimulated,forceSimulated, 'r','LineWidth',2 )
%plot(velocity_real,force_real,'LineWidth',1,'Color','b')
title('DahlSimulated');
xlabel('Velocity'),ylabel('outputForce')
grid

savefile = 'data_simulation_TwoStoryBuildingJoao.mat';
save(savefile,'t','forceSimulated','TS','t','-v7');
