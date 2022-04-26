%Codigo que escribe en la hoja Excel los resultados horarios del balance
%Antonio Luis Mata Garcia
%TFG 2022 ETSIT

Pn=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B7:B7')*1; %Potencia nominal que garantiza c_pv=1
Cbat=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'J2:J2')*1; %Capacidad de la bateria que garantiza c_st=1

balances; %Llamada a la funcion balances

%Escritura en la hoja Excel los resultados horarios detallados
writematrix(Efv(:), 'Balances.xlsx','sheet', 'Balance', 'Range', 'D2:D8761'); %Estado de carga de la bateria
writematrix(SOC(:), 'Balances.xlsx','sheet', 'Balance', 'Range', 'E2:E8761'); %Estado de carga de la bateria
writematrix(round(Ebat(:),3), 'Balances.xlsx','sheet', 'Balance', 'Range', 'F2:F8761'); %Energia consumida a traves de la bateria
writematrix(round(Ered(:),3), 'Balances.xlsx','sheet', 'Balance', 'Range', 'G2:G8761'); %Energia intercambiada en la red
writematrix(round(Eautoconsumo(:),3), 'Balances.xlsx','sheet', 'Balance', 'Range', 'H2:H8761'); %Energia consumida en el momento de la generacion