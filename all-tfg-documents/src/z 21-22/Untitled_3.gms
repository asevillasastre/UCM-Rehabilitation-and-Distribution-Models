$TITLE **** Grupo 10 Niger Multiobjetivo ****
sets
i centros de reparto /Tanout, Agadez, Zinder, Maradi/
j poblaciones /In-Gall, Aderbissinat, Tessaoua, Dakoro, Tatokou, Bakatchiraba, Mayahi, Koundoumaoua, Sabon-Kafi/
;
parameters
c(i) coste [€ por T] de gestion por tonelada en el centro i
/Tanout 70, Agadez 50,Zinder 30,Maradi 90/
dem(j) demanda [T] de la poblacion j
/In-Gall 156, Aderbissinat 81, Tessaoua 129, Dakoro 213, Tatokou 39,
Bakatchiraba 30, Mayahi 273, Koundoumaoua 30, Sabon-Kafi 19/
M(i) valor artificialmente grande sobre i
/Tanout 1334, Agadez 1334, Zinder 1334, Maradi 1334/
;
table d(j,i) distancia [km] del centro i a la poblacion
              Tanout Agadez Zinder Maradi
In-Gall       396    119    541    625
Aderbissinat  147    161    286    454
Tessaoua      191    492    114    122
Dakoro        244    562    300    124
Tatokou       43     258    188    355
Bakatchiraba  8      306    152    320
Mayahi        252    553    156    95
Koundoumaoua  197    490    71     183
Sabon-Kafi    43     336    102    269
;
variables
X(i,j) toneladas [T] recogidas en i para j
Y(i) se establece el centro i
Z(i,j) se manda una delegacion de j a i
obj valor de la funcion objetivo
;
positive variables
X(i,j)
;
binary variables
Y(i), Z(i,j)
;
equations
fpresupuesto
fcentros
fcarreteras
fsesenta
fY
fZ
fobjDEM
fobjCOSTE
fobjEQUITATIVO
fobjDISTANCIA
;
fpresupuesto.. sum(i, 1000*Y(i)) + sum(i, sum(j, c(i)*X(i,j))) =L= 40000;
fcentros.. sum(i, Y(i)) =L= 3;
fcarreteras(i,j).. d(j,i)*Z(i,j) =L= 200;
fsesenta.. sum(i, sum(j, X(i,j))) =G= 0.6*970;
fY(i,j).. X(i,j) =L= M(i)*Y(i);
fZ(i,j).. X(i,j) =L= M(i)*Z(i,j);
fobjDEM.. obj =E= sum(j, dem(j) - sum(i, X(i,j)));
fobjCOSTE.. obj =E= sum(i, 1000*Y(i)) + sum(i, sum(j, c(i)*X(i,j)));
fobjEQUITATIVO.. obj =E= sum(j, (dem(j) - sum(i, X(i,j)))/dem(j));
fobjDISTANCIA.. obj =E= sum(i, sum(j, d(j,i)*Z(i,j)));

model Niger_DEM /fpresupuesto, fcentros, fcarreteras, fsesenta, fY, fZ,
fobjDEM/;
model Niger_COSTE /fpresupuesto, fcentros, fcarreteras, fsesenta, fY, fZ,
fobjCOSTE/;
model Niger_EQUITATIVO /fpresupuesto, fcentros, fcarreteras, fsesenta, fY, fZ,
fobjEQUITATIVO/;
model Niger_DISTANCIA /fpresupuesto, fcentros, fcarreteras, fsesenta, fY, fZ,
fobjDISTANCIA/;

solve Niger_DEM using MIP minimizing obj;
solve Niger_COSTE using MIP minimizing obj;
solve Niger_EQUITATIVO using MIP minimizing obj;
solve Niger_DISTANCIA using MIP minimizing obj;
