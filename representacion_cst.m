%Codigo para representar los balances fijando c_st
%Antonio Luis Mata Garcia
%TFG 2022 ETSIT

%Lectura de datos del Excel
cpv1=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B7:B7'); %Lectura de Pn que garantiza c_pv=1
cst1=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'J2:J2'); %Lectura de Cbat que garantiza c_st=1

c_st = 0.6; %Definimos el valor de c_st que vamos a utilizar
Cbat = cst1 * c_st; %Capacidad de la bateria
matriz = zeros(16, 4); %Matriz con los resultados
x = 0; %Variable que recorre la matriz
        
for c_pv = 0: 0.1: 1.5 %Distintos valores para c_pv
    x = x + 1;
    Pn = cpv1 * c_pv;
    balances; %Llamada a la funcion balances.m
    matriz(x, 1) = autoconsumo;
    matriz(x, 2) = descarga_bateria;
    matriz(x, 3) = compra_red;
    matriz(x, 4) = venta_red; 
end

%Representacion grafica
y = (0: 0.1: 1.5);

plot(y, matriz(:, 1), 'LineWidth', 1.3);
hold on
plot(y, matriz(:, 2), 'LineWidth', 1.3);
hold on;
plot(y, matriz(:, 3), 'LineWidth', 1.3);
hold on;
plot(y, matriz(:, 4), 'LineWidth', 1.3);
ylim([0 1])

title("Balances c_{st} = " + c_st);
xlabel('Dimensionado instalacón c_{pv}');
legend('Autoconsumo directo', 'Consumo a través de la bateria', 'Compra a la red', 'Venta a la red');