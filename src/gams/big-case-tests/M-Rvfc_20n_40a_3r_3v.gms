$Title modelo sencillo reconstruccion + reparto 1

Set
j Nodos. Representan los asentamientos. /0*19/
t Periodos. Se asumen de misma duracion ademas de que todos los arcos se pueden recorrer en uno de estos periodos
 /0*19/
v Tipos de vehiculo /0*2/
;

Alias
(j,i,k)
;

Parameters
dem(j) Demanda por cada asentamiento de un  unico recurso en toneladas
/
0 0,
1 1,
2 1,
3 1,
4 8,
5 4,
6 4,
7 3,
8 2,
9 7,
10 2,
11 2,
12 2,
13 2,
14 2,
15 2,
16 2,
17 2,
18 2,
19 2
/
max_coste Maximo presupuesto que se puede invertir
 /80/
max_puentes Maximo numero de puentes que podemos reconstruir previo paso (un puente por cada sentido consideramos un grafo orientado)
 /2/
capacidad_vehiculo(v) Capacidad de hacer partir 1 vehiculo de tipo v /0 1,1 2,2 5/
coste_vehiculo(v) Coste total y fijo de hacer partir 1 vehiculo de tipo v /0 10,1 15,2 30/
P_total Probabilidad aceptable de que todos los convoys puedan pasar por todas las rutas elegidas 
/0.3/
coste_variable Coste variable por km recorrido /1/
;

* Matrices de ejemplo generadas con la versión buena de mi programa (la del 12-02-23)
* [num_nodos, num_cut, min_prob_rute] = [20, 3, 0.7]
Table E(i,j) Existe la ruta de i a j
      0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19
0     0     0     0     0     1     1     1     0     1     0     0     0     0     1     0     0     0     0     0     0     
1     0     0     0     0     0     0     0     0     0     1     0     1     0     0     0     0     0     1     0     0     
2     0     0     0     0     0     0     0     0     0     0     0     1     0     1     1     0     1     0     0     0     
3     0     0     0     0     0     1     1     0     1     0     0     0     1     0     0     0     1     1     1     0     
4     1     0     0     0     0     0     0     0     0     1     1     0     0     0     0     0     0     0     0     0     
5     1     0     0     1     0     0     1     0     1     0     0     0     0     0     1     1     1     0     1     0     
6     1     0     0     1     0     1     0     1     0     0     0     1     0     0     0     0     0     1     1     0     
7     0     0     0     0     0     0     1     0     0     0     0     0     0     1     1     0     1     1     1     0     
8     1     0     0     1     0     1     0     0     0     0     0     0     0     1     0     0     0     1     1     0     
9     0     1     0     0     1     0     0     0     0     0     1     0     0     0     0     1     0     0     1     1     
10    0     0     0     0     1     0     0     0     0     1     0     0     0     1     1     1     0     0     0     0     
11    0     1     1     0     0     0     1     0     0     0     0     0     1     0     1     0     0     1     0     1     
12    0     0     0     1     0     0     0     0     0     0     0     1     0     0     0     1     0     0     0     0     
13    1     0     1     0     0     0     0     1     1     0     1     0     0     0     0     1     0     0     1     0     
14    0     0     1     0     0     1     0     1     0     0     1     1     0     0     0     0     0     0     0     1     
15    0     0     0     0     0     1     0     0     0     1     1     0     1     1     0     0     0     1     1     1     
16    0     0     1     1     0     1     0     1     0     0     0     0     0     0     0     0     0     1     0     0     
17    0     1     0     1     0     0     1     1     1     0     0     1     0     0     0     1     1     0     1     0     
18    0     0     0     1     0     1     1     1     1     1     0     0     0     1     0     1     0     1     0     0     
19    0     0     0     0     0     0     0     0     0     1     0     1     0     0     1     1     0     0     0     0     
;
Table U(i,j) Al inicio es utilizable la ruta de i a j
      0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19
0     0     0     0     0     1     1     1     0     1     0     0     0     0     0     0     0     0     0     0     0     
1     0     0     0     0     0     0     0     0     0     1     0     1     0     0     0     0     0     1     0     0     
2     0     0     0     0     0     0     0     0     0     0     0     0     0     1     1     0     1     0     0     0     
3     0     0     0     0     0     1     1     0     1     0     0     0     1     0     0     0     1     1     1     0     
4     1     0     0     0     0     0     0     0     0     1     1     0     0     0     0     0     0     0     0     0     
5     1     0     0     1     0     0     1     0     1     0     0     0     0     0     1     1     1     0     1     0     
6     1     0     0     1     0     1     0     1     0     0     0     1     0     0     0     0     0     1     1     0     
7     0     0     0     0     0     0     1     0     0     0     0     0     0     1     1     0     1     1     1     0     
8     1     0     0     1     0     1     0     0     0     0     0     0     0     1     0     0     0     1     1     0     
9     0     1     0     0     1     0     0     0     0     0     1     0     0     0     0     0     0     0     1     1     
10    0     0     0     0     1     0     0     0     0     1     0     0     0     1     1     1     0     0     0     0     
11    0     1     0     0     0     0     1     0     0     0     0     0     1     0     1     0     0     1     0     1     
12    0     0     0     1     0     0     0     0     0     0     0     1     0     0     0     1     0     0     0     0     
13    0     0     1     0     0     0     0     1     1     0     1     0     0     0     0     1     0     0     1     0     
14    0     0     1     0     0     1     0     1     0     0     1     1     0     0     0     0     0     0     0     1     
15    0     0     0     0     0     1     0     0     0     0     1     0     1     1     0     0     0     1     1     1     
16    0     0     1     1     0     1     0     1     0     0     0     0     0     0     0     0     0     1     0     0     
17    0     1     0     1     0     0     1     1     1     0     0     1     0     0     0     1     1     0     1     0     
18    0     0     0     1     0     1     1     1     1     1     0     0     0     1     0     1     0     1     0     0     
19    0     0     0     0     0     0     0     0     0     1     0     1     0     0     1     1     0     0     0     0     
;
Table P(i,j) Probabilidad de que la ruta de i a j sea usable
      0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19
0     1     1     1     1     0.91  0.74  0.93  1     0.86  1     1     1     1     1     1     1     1     1     1     1     
1     1     1     1     1     1     1     1     1     1     0.71  1     1.0   1     1     1     1     1     1.0   1     1     
2     1     1     1     1     1     1     1     1     1     1     1     1     1     0.86  0.86  1     0.98  1     1     1     
3     1     1     1     1     1     0.74  0.8   1     0.98  1     1     1     0.9   1     1     1     0.9   0.91  0.95  1     
4     0.91  1     1     1     1     1     1     1     1     0.9   0.8   1     1     1     1     1     1     1     1     1     
5     0.74  1     1     0.74  1     1     0.97  1     0.92  1     1     1     1     1     0.83  0.99  0.92  1     0.97  1     
6     0.93  1     1     0.8   1     0.97  1     0.84  1     1     1     0.72  1     1     1     1     1     0.96  0.9   1     
7     1     1     1     1     1     1     0.84  1     1     1     1     1     1     0.77  0.94  1     0.97  0.96  0.76  1     
8     0.86  1     1     0.98  1     0.92  1     1     1     1     1     1     1     0.93  1     1     1     0.79  0.93  1     
9     1     0.71  1     1     0.9   1     1     1     1     1     0.87  1     1     1     1     1     1     1     0.79  0.8   
10    1     1     1     1     0.8   1     1     1     1     0.87  1     1     1     0.8   0.92  0.98  1     1     1     1     
11    1     1.0   1     1     1     1     0.72  1     1     1     1     1     0.98  1     0.92  1     1     0.89  1     0.83  
12    1     1     1     0.9   1     1     1     1     1     1     1     0.98  1     1     1     0.96  1     1     1     1     
13    1     1     0.86  1     1     1     1     0.77  0.93  1     0.8   1     1     1     1     0.77  1     1     0.8   1     
14    1     1     0.86  1     1     0.83  1     0.94  1     1     0.92  0.92  1     1     1     1     1     1     1     0.96  
15    1     1     1     1     1     0.99  1     1     1     1     0.98  1     0.96  0.77  1     1     1     0.75  0.98  0.73  
16    1     1     0.98  0.9   1     0.92  1     0.97  1     1     1     1     1     1     1     1     1     0.73  1     1     
17    1     1.0   1     0.91  1     1     0.96  0.96  0.79  1     1     0.89  1     1     1     0.75  0.73  1     0.93  1     
18    1     1     1     0.95  1     0.97  0.9   0.76  0.93  0.79  1     1     1     0.8   1     0.98  1     0.93  1     1     
19    1     1     1     1     1     1     1     1     1     0.8   1     0.83  1     1     0.96  0.73  1     1     1     1     
;
Table Dist(i,j) Distancia de las rutas de i a j
      0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19
0     0     0     0     0     3     3     4     0     3     0     0     0     0     0     0     0     0     0     0     0     
1     0     0     0     0     0     0     0     0     0     2     0     2     0     0     0     0     0     4     0     0     
2     0     0     0     0     0     0     0     0     0     0     0     0     0     5     5     0     2     0     0     0     
3     0     0     0     0     0     5     3     0     3     0     0     0     3     0     0     0     2     4     2     0     
4     3     0     0     0     0     0     0     0     0     2     3     0     0     0     0     0     0     0     0     0     
5     3     0     0     5     0     0     2     0     2     0     0     0     0     0     5     5     5     0     3     0     
6     4     0     0     3     0     2     0     2     0     0     0     2     0     0     0     0     0     2     2     0     
7     0     0     0     0     0     0     2     0     0     0     0     0     0     4     5     0     5     3     3     0     
8     3     0     0     3     0     2     0     0     0     0     0     0     0     4     0     0     0     5     3     0     
9     0     2     0     0     2     0     0     0     0     0     5     0     0     0     0     0     0     0     2     3     
10    0     0     0     0     3     0     0     0     0     5     0     0     0     4     4     2     0     0     0     0     
11    0     2     0     0     0     0     2     0     0     0     0     0     3     0     2     0     0     3     0     4     
12    0     0     0     3     0     0     0     0     0     0     0     3     0     0     0     4     0     0     0     0     
13    0     0     5     0     0     0     0     4     4     0     4     0     0     0     0     2     0     0     5     0     
14    0     0     5     0     0     5     0     5     0     0     4     2     0     0     0     0     0     0     0     4     
15    0     0     0     0     0     5     0     0     0     0     2     0     4     2     0     0     0     3     3     3     
16    0     0     2     2     0     5     0     5     0     0     0     0     0     0     0     0     0     3     0     0     
17    0     4     0     4     0     0     2     3     5     0     0     3     0     0     0     3     3     0     3     0     
18    0     0     0     2     0     3     2     3     3     2     0     0     0     5     0     3     0     3     0     0     
19    0     0     0     0     0     0     0     0     0     3     0     4     0     0     4     3     0     0     0     0     
;


loop(i,
    loop(j,
        P(i, j) := log2(P(i,j));
        );
    );

P_total = log2(P_total);

Variables
X(i,j,t,v)  Vehiculos de tipo v que van de i a j en el periodo t

Y(j,t,v) Vehiculos de tipo v que hay en j en el periodo t. Pueden seguir su ruta o bien quedarse en j para proseguir su ruta en otro periodo o bien permanecer en j hasta el final del ultimo periodo

Z(j,v) Vehiculos de tipo v totales emplazados en j al final del ultimo periodo. se asume que en ese momento hacen el reparto a j

Z_(j) Ayuda total repartida a j

auxZ(j) Variable binaria que representa si se reparte al menos un vehiculo de recurso a j

H(i,j) variable binaria que determina si habilitamos el puente de i a j

Coste Coste total del proyecto

Used(i,j)

Ayuda Total demanda satisfecha
Eq Criterio de equidad. Numero de nodos a los que se reparte al menos un vehiculo
;

Integer variables X, Y, Z;
Binary variables auxZ, H, Used;

Equations

definir_Y(j,t,v) Restriccion de almacenamiento. En cierto nodo permanece lo almacenado en el anterior periodo mas lo que entra a el en el presente menos lo que sale

definir_Z(j,v) Determina lo repartido como lo ubicado en cierto nodo en el ultimo periodo

definir_Z_(j) Lo repartido a j en toneladas

definir_auxZ(j) 

lim_salida(j,t,v) Limita los vehiculos que pueden salir de un nodo a las almacenados en el mismo
flujo_ini(j,v) No hay almacenado nada en ningun nodo no inicial
flujo_ini_0 En el nodo inicial esta almacenada la totalidad de los camiones

existencia_ruta(i,j,t,v)
usabilidad_ruta(i,j,t,v)
orientacion(i,j) Si se habilita un sentido se ha de habilitar el opuesto
lim_puentes Limite de puentes que podemos reconstruir

lim_demanda(j) No se puede superar la demanda

arco_usado(i,j) Pasa algun vehiculo por este nodo
arco_usado_orientacion(i,j)
fiabilidad Restriccion que impide elegir alguna ruta que tenga mas de cierta probabilidad de no ser usable

f_ayuda Funcion objetivo 1. Cantidad total del recurso repartida en cierta unidad
f_equidad Funcion objetivo 2.  Criterio de equidad. Numero de nodos a los que se les reparte al menos una unidad de recurso
;

definir_Y(j,t,v)$(ord(t)>1).. Y(j,t,v) =E=
                            Y(j,t-1,v) + sum(i, X(i,j,t,v)) - sum(i, X(j,i,t,v));
definir_Z(j,v).. Z(j,v) =E= Y(j,"19",v);
definir_Z_(j).. Z_(j) =E= sum(v, Z(j,v)*capacidad_vehiculo(v));
definir_auxZ(j).. auxZ(j) =L= Z_(j);

lim_salida(j,t,v).. sum(i,X(j,i,t,v)) =L= Y(j,t-1,v);
flujo_ini(j,v)$(ord(j)>1).. Y(j,"0",v) =E= 0;
flujo_ini_0.. sum(v,Y("0","0",v)*coste_vehiculo(v)) + sum(i, sum(j, sum(t, sum(v, X(i,j,t,v)*Dist(i,j)*coste_variable)))) =L= max_coste;
existencia_ruta(i,j,t,v).. X(i,j,t,v) =L= 99*E(i,j);
usabilidad_ruta(i,j,t,v).. X(i,j,t,v) =L= 99*(U(i,j) +  H(i,j));
orientacion(i,j).. H(i,j) =E= H(j,i);
lim_puentes..  sum(i, sum(j, H(i,j))) =L= max_puentes;

lim_demanda(j).. Z_(j) =L= dem(j);

arco_usado(i,j).. 99*Used(i,j) =G= sum(t, sum(v, X(i,j,t,v)));
arco_usado_orientacion(i,j).. Used(i,j)=E= Used(j,i);
fiabilidad.. sum(i, sum(j, Used(i,j)*(P(i,j)))) =G= P_total;

f_ayuda.. Ayuda =E= sum(j, Z_(j)-dem(j));
f_equidad.. Eq =E= sum(j, auxZ(j));
;

display P;
display P_total;

model modelo1 /all - lim_demanda/;

solve modelo1 using MIP maximizing Ayuda
;
solve modelo1 using MIP maximizing Eq
;

*


*con 2 tipos de vehiculos
*---   1,647 rows  863 columns  4,237 non-zeroes
*---   854 discrete-columns
*utiliza vehiculos y puentes distintos (los de menor capacidad para mayor equidad)

*con 3 tipos de vehiculos:
*---   2,437 rows  1,262 columns  6,267 non-zeroes
*---   1,253 discrete-columns
*The model exceeds the demo license limits for linear models of more than 2000 rows or columns


