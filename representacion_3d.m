%Codigo para representar los balances variando c_pv y c_st
%Antonio Luis Mata Garcia
%TFG 2022 ETSIT

%Lectura de datos del Excel
cpv1=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'B7:B7'); %Lectura de Pn que garantiza c_pv=1
cst1=readmatrix('Balances.xlsx','sheet', 'Dimensionado', 'Range', 'J2:J2'); %Lectura de Cbat que garantiza c_st=1

%Matrices con resultados de balances
matriz_descarga = zeros(11, 11);
matriz_venta = zeros(11, 11);
matriz_compra = zeros(11, 11);
matriz_autoconsumo = zeros(11, 11);

%Variables que recorren las matrices
x = 0;
y = 0;
        
for c_st = 0: 0.1: 1.0
    x = x + 1;
    y = 0;
    Cbat = cst1 * c_st;
    
    for c_pv = 0: 0.2: 2
        y = y + 1;
        Pn = cpv1 * c_pv;
        balances;
        matriz_descarga(x, y) = descarga_bateria;
        matriz_venta(x, y) = venta_red;
        matriz_compra(x, y) = compra_red;
        matriz_autoconsumo(x, y) = autoconsumo;
    end    
end

%Representacion grafica
eje_x = (0: 0.2: 2);
eje_y = (0: 0.1: 1);

figure(1)
mesh(eje_x, eje_y, matriz_venta);
title("Venta a la red");
xlabel('Dimensionado instalación c_{pv}');
ylabel('Dimensionado bateria c_{st}');

figure(2)
mesh(eje_x, eje_y, matriz_compra);
title("Compra a la red");
xlabel('Dimensionado instalación c_{pv}');
ylabel('Dimensionado bateria c_{st}');

figure(3)
mesh(eje_x, eje_y, matriz_descarga);
title("Consumo desde la batería");
xlabel('Dimensionado instalación c_{pv}');
ylabel('Dimensionado bateria c_{st}');

figure(4)
mesh(eje_x, eje_y, matriz_autoconsumo);
title("Consumo en el momento de generación");
xlabel('Dimensionado instalación c_{pv}');
ylabel('Dimensionado bateria c_{st}');