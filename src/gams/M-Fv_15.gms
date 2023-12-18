$Title modelo sin tiempo reconstruccion + reparto

Set
j nodos. representan los asentamientos. en este modelo hemos de distinguir entre transitorios-destino-origen /0*15/
v Tipos de vehiculo /0*1/
;

Alias
(j,i,k)
;

Parameters
dem(j) demanda por cada asentamiento de un unico recurso en cierta unidad continua /0 0,
                         1 0
                         2 0
                         3 0
                         4 3
                         5 1
                         6 1
                         7 2
                         8 4
                         9 2
                         10 1
                         11 2
                         12 3
                         13 1
                         14 2
                         15 1
                         /
max_coste Maximo presupuesto que se puede invertir
 /65/
max_puentes maximo numero de puentes que podemos reconstruir previo paso a los camiones /1/
capacidad_vehiculo(v) Capacidad de hacer partir 1 vehiculo de tipo v /0 1,1 2/
coste_vehiculo(v) Coste total y fijo de hacer partir 1 vehiculo de tipo v /0 10,1 15/
;

Table E(i,j) existe la ruta de i a j
    0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15
0   0   1   1   0   0   0   0   1   0   0   0   1   0   0   0   0
1   0   0   0   1   1   0   0   0   0   0   1   1   0   1   0   1
2   0   0   0   0   0   1   0   0   0   0   0   0   0   0   1   1
3   0   0   0   0   0   0   1   0   0   1   0   0   0   0   0   0
4   0   0   0   0   0   0   1   0   1   0   0   0   1   0   0   0
5   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
6   0   0   0   0   0   0   0   0   0   0   1   0   0   1   1   0
7   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1
8   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0
9   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
10  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
11  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
12  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
13  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
14  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
15  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  
;

Table U(i,j) al inicio es utilizable la ruta de i a j
    0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15
0   0   1   0   0   0   0   0   0   0   0   0   1   0   0   0   0
1   0   0   0   0   1   0   0   0   0   0   1   1   0   1   0   1
2   0   0   0   0   0   1   0   0   0   0   0   0   0   0   1   1
3   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0
4   0   0   0   0   0   0   1   0   0   0   0   0   1   0   0   0
5   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
6   0   0   0   0   0   0   0   0   0   0   1   0   0   0   1   0
7   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
8   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
9   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
10  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
11  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
12  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
13  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
14  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
15  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
;

Variables
Xmas(i,j,v ) el flujo es discreto. esta variable sirve para denotar el flujo positivo
Xmenos(i,j,v) esta variable sirve para denotar el flujo negativo
Y(j,v ) flujo de vehiculos que se queda en j
Z_(j) toneladas que se quedan en j
auxZ(j) variable binaria que determina si llega alguna ayuda a j

H(i,j) variable binaria que determina si habilitamos el puente de i a j

Insatis 
Insatisaux
Eq 
;

Positive variables Insatisaux;
Binary variables H, auxZ;
Integer variables Xmas, Xmenos; 

Equations

definir_Y(j,v) ecuacion de flujo

solo_arcos_buenos_mas(i,j,v) consideramos de flujo nulo la mitad de los nodos. asi consideramos un grafo no orientado
solo_arcos_buenos_menos(i,j,v)

*lim_demanda(j) 
lim_provisiones restriccion que fija la cantidad de ayuda que podemos enviar
flujo_nulo(j,v) en los nodos transitorios el flujo es nulo

flujo_destinos(j,v)

existencia_ruta(i,j,v)
usabilidad_ruta(i,j,v)
existencia_ruta_min(i,j,v) en este modelo son necesarias 2 restricciones para que el flujo sea nulo y no negativo en los arcos no existentes
usabilidad_ruta_min(i,j,v) ídem con los no usables
lim_puentes

def_insatisaux definimos la demanda insatisfecha

def_auxZ1(j) definimos los nodos a los que llega alguna ayuda
def_auxZ2(j) a los nodos transitorios no puede llegar ninguna ayuda por lo que no cuentan

def_Z_(j)

f_insatis funcion objetivo 1. demanda insatisfecha total
f_eq funcion objetivo 2. criterio de equidad. numero de nodos a los que se les reparte alguna cantidad de ayuda
;

definir_Y(j,v).. Y(j,v) =E= sum(i, Xmas(i,j,v)-Xmenos(i,j,v)) - sum(i, Xmas(j,i,v)-Xmenos(j,i,v));

solo_arcos_buenos_mas(i,j,v)$(ord(i)<=ord(j)).. Xmas(j,i,v) =E= 0;
solo_arcos_buenos_menos(i,j,v)$(ord(i)<=ord(j)).. Xmenos(j,i,v) =E= 0;

*lim_demanda(j).. Y(j) =L= dem(j);
lim_provisiones.. sum(v,Y("0",v)*coste_vehiculo(v)) =G= -max_coste;
flujo_nulo(j,v)$(ord(j)>1 and ord(j)<=13).. Y(j,v) =E= 0;

flujo_destinos(j,v)$(ord(j)>=14).. Y(j,v) =G= 0;

existencia_ruta(i,j,v).. Xmas(i,j,v)-Xmenos(i,j,v) =L= 99*E(i,j);
usabilidad_ruta(i,j,v).. Xmas(i,j,v)-Xmenos(i,j,v) =L= 99*(U(i,j) +  H(i,j));
existencia_ruta_min(i,j,v).. Xmas(i,j,v)-Xmenos(i,j,v) =G= -99*E(i,j);
usabilidad_ruta_min(i,j,v).. Xmas(i,j,v)-Xmenos(i,j,v) =G= -99*(U(i,j) +  H(i,j));
lim_puentes..  sum(i, sum(j, H(i,j))) =L= max_puentes;

def_insatisaux(j)$(ord(j)>=14).. Insatisaux =G= dem(j) - Z_(j);

def_auxZ1(j)$(ord(j)>=14).. auxZ(j) =L= 99*Z_(j);
def_auxZ2(j)$(ord(j)<=13).. auxZ(j) =E= 0;

def_Z_(j).. Z_(j) =E= sum(v, Y(j,v)*capacidad_vehiculo(v));

f_eq.. Eq =E= sum(j, auxZ(j));
f_insatis.. Insatis =E= sum(j, Insatisaux);

model modelo1 /all/;

solve modelo1 using MIP minimizing Insatis;
solve modelo1 using MIP maximizing Eq;

$ ontext
con 2 vehiculos
---   489 rows  276 columns  1,546 non-zeroes
---   252 discrete-columns


$offtext