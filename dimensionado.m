%Codigo para dimensionar el valor de la potencia nominal (Pn) que garantiza c_pv=1
%Antonio Luis Mata Garcia
%TFG 2022 ETSIT

%Lectura de datos del Excel donde se almacenan los datos
Econanual=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B2:B2'); %Suma de la energia total consumida a lo largo del año
irradiancia=readmatrix('Balances.xlsx','sheet', 'Irradiancia', 'Range', 'C2:C8761'); %Datos horarios de irradiancia a lo largo del año
Tc=readmatrix('Balances.xlsx','sheet', 'Irradiancia', 'Range', 'E2:E8761'); %Datos horario de temperatura de celula a lo largo del año
gamma=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B5:B5'); %??
rendimiento=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B6:B6'); %Rendimiento de la instalacion

ponderacion=1:8760; 
denominador=0;

%Con cada iteracion se actualiza el valor del denominador para el calculo de Pn 
for x=1:8760
    ponderacion(x) = irradiancia(x)*(1+gamma*(Tc(x)-25))*rendimiento/1000;
    denominador = denominador + ponderacion(x);
end

Pn=Econanual/denominador; %Potencia nominal que garantiza c_pv=1
writematrix(Pn, 'Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B7:B7'); %Se escribe el resultado en la hoja Excel
