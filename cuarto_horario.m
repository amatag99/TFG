Fecha=readmatrix('Balances_campus_arbo.xlsx','sheet', 'Hoja2', 'Range', 'A2:A35401');
Hora=readmatrix('Balances_campus_arbo.xlsx','sheet', 'Hoja2', 'Range', 'B2:B35401');
Ec=readmatrix('Balances_campus_arbo.xlsx','sheet', 'Hoja2', 'Range', 'C2:C35401');
acumulado=0;
Ecfinal=zeros();
j=1;

for x=1:4:35040
    for i=0:1:3
        acumulado = Ec(x+i)+acumulado;
    end
    Ecfinal(j)=acumulado;
    acumulado=0;
    j=j+1;
end

writematrix(Ecfinal(:), 'Balances_campus_arbo.xlsx','sheet', 'Hoja1', 'Range', 'C2:C8761');
