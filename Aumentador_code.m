%?????????????????
%??????????????????
%??????????????????????
%???????????????????????

%Autor: Rafael Ferrari
%Version: 1.0
%Convertidor DC-DC Elevador o Boost ideal

close all
tsim   =    0.150;         % Tiempo para la simulacion

%Datos
Fs     =    20e3;          % Frecuencia de conmutacion 
Ts     =    1/Fs;          % Periodo 
D      =    0.5;           % Ciclo de trabajo
Vd     =    12;            % Voltaje de entrada       
R      =    100;           % Carga Resistiva
L      =    470e-6;        % Bobina o Inductor (uH)
C      =    120e-6;        % Capacitor (uF)

%Calculo de paraetros del convertidor
G      =    1 / (1-D);           % Ganancia del convertidor
Vo     =    G*Vd;                % Voltaje de salida o voltaje en R
Io     =    Vo/R;                % Corriente de salida
Id     =    G*Io;                 % Corriente de entrada (desde la fuente)
Po     =    Vo*Io;               % Potencia de salida en R

% Calculo de la corriente:

Delta_iL   =  (Vd/L)*D*Ts;                  % Rizo de corriente en la bobina
IL_max     =  Id + (Delta_iL / 2);          % Corriente maxima en la bobina 
Il_min     =  Id - (Delta_iL / 2);          % Corriente minima en la bobina


% Corriente de riso 20%

Rizo_iL = (100 / Id)*(Delta_iL / 2);


%calculo de la tension de riso
Delta_Vo   =  (Vo*D*Ts)/(R*C);
Rizo_Vo    = (Delta_Vo / Vo)*100;


% ESTADO DE OPERACI?N DEL CONVERTIDOR (Modo de conducci?n)g
if (Id > Delta_iL/2) 
    disp('El convertidor opera en modo de conducci?n CONTINUO')
else
    disp('El convertidor opera en modo de conducci?n DISCONTINUO')
end


%Codigo con la vinculacion de codigo y simulacion
mysets=simset('Solver', 'ode23tb','MaxStep',1e-6,'RelTol',10^-5);
tt1=sim('Aumentador',tsim,mysets);

%Graficas
figure(1)
plot(tt1,V_o)
hold on
xlabel('Tiempo (segundos)')
ylabel('Voltaje (Volts)')
title('Voltaje de salida en la carga  V_{O}')
grid

figure(2)
plot(tt1,I_d,tt1,I_dprom)
hold on
xlabel('Tiempo (segundos)')
ylabel('Corriente (Amperes)')
title('Corriente de entrada i_{d} y su promedio I_{dprom}')
grid

figure(3)
plot(tt1,V_L)
hold on
xlabel('Tiempo (segundos)')
ylabel('Voltaje (Volts)')
title('Voltaje en el inductor  V_{L}')
grid



