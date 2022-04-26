%Codigo que calcula los balances horarios de la instalacion
%Antonio Luis Mata Garcia
%TFG 2022 ETSIT

%Lectura de datos
Econanual=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B2:B2'); %Suma de energia total consumida a lo largo del año
Econ=readmatrix('Balances.xlsx','sheet', 'Balance', 'Range', 'C2:C8761'); %Datos horarios de energia consumida
irradiancia=readmatrix('Balances.xlsx','sheet', 'Irradiancia', 'Range', 'C2:C8761'); %Datos horarios de irradiancia
Tc=readmatrix('Balances.xlsx','sheet', 'Irradiancia', 'Range', 'E2:E8761'); %Datos horarios de temperatura de celula
gamma=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B5:B5'); %??
rendimiento=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B6:B6'); %Rendimiento de la instalacion

%Definicion de variables
Efv=1:8760; %Energia fotovoltaica generada
diferencia=1:8760; %Diferencia entre generacion y consumo
SOC=1:8760; %Estado de carga de la bateria
Ebat=1:8760; %Energia intercambiada con la bateria
Ered=1:8760; %Energia intercambiada con la red
Eautoconsumo=1:8760; %Energia consumida en el momento de la generacion

%Calculo de la energia fotovoltaica genera en la instalacion
for i=1:8760
    Efv(i)= Pn*irradiancia(i)*(1+gamma*(Tc(i)-25))*rendimiento/1000;
    diferencia(i) = Efv(i) - Econ(i); %Exceso de energia generado por la instalacion
end

SOC(1)=0; %Inicialmente la bateria esta descargada
Ebat(1)=0; %Inicialmente no se intercambia energia con la bateria
Ered(1)=diferencia(1); %Inicialmente el exceso de generacion se intercambia en la red
Eautoconsumo(1)=Efv(1); %Se consume siempre toda la energia generada

%Algoritmo para el calculo de balances todas las horas del año
for i=2:8760
    if(Cbat == 0)
        SOC(i) = 0;
    else
        SOC(i) = round(SOC(i-1) + (Ebat(i-1)/Cbat),3);
    end

    if(diferencia(i) > 0)
        if(SOC(i) < 1)
            if(diferencia(i)>(1-SOC(i))*Cbat)
                Ebat(i)=(1-SOC(i))*Cbat;
                Ered(i)=diferencia(i) - (1-SOC(i))*Cbat;
            elseif(diferencia(i)<(1-SOC(i))*Cbat)
                Ebat(i)=diferencia(i);
                Ered(i)=0;
            end
        elseif(SOC(i) == 1)
            Ebat(i) = 0;
            Ered(i) = diferencia(i);
        end
        Eautoconsumo(i) = Efv(i) - Ebat(i) - Ered(i);
    
    elseif(diferencia(i) < 0)
        if(SOC(i) > 0)
            if(abs(diferencia(i)) > SOC(i)*Cbat)
                Ebat(i) = - SOC(i)*Cbat;
                Ered(i) = diferencia(i) + SOC(i)*Cbat;
            elseif(abs(diferencia(i)) < SOC(i)*Cbat)
                Ebat(i)=diferencia(i);
                Ered(i)=0;
            end
        elseif(SOC(i) == 0)
            Ebat(i) = 0;
            Ered(i) = diferencia(i);
        end
        Eautoconsumo(i) = Efv(i);
    
    elseif(diferencia(i) == 0)
        Ebat(i) = 0;
        Ered(i) = 0;
        Eautoconsumo(i) = Efv(i);
    end
end

%Suma de los datos totales a lo largo del año
carga_bateria = sum(Ebat(Ebat > 0))/Econanual;
descarga_bateria = abs(sum(Ebat(Ebat < 0)))/Econanual;
venta_red = sum(Ered(Ered > 0))/Econanual;
compra_red = abs(sum(Ered(Ered < 0)))/Econanual;
autoconsumo = sum(Eautoconsumo)/Econanual;

