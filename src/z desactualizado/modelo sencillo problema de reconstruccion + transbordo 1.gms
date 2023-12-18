$Title modelo sencillo reconstruccion + reparto 1

Set
j nodos de llegada /0*3/
t periodos (cota superior) /0*4/
;

Alias
(j,i,k)
;

Parameters
dem(j) demanda por nodo /0 0,
                         1 4,
                         2 1,
                         3 1/
max_camiones máximo número de camiones que podemos mandar /3/
max_puentes máximo número de puentes que podemos reconstruir /2/
* un puente por cada sentido, grafo orientado
;

Table E(i,j) existe la ruta de i a j
         0       1       2       3
0        0       1       1       0
1        1       0       0       0
2        1       0       0       1
3        0       0       1       0
;

Table U(i,j) al inicio es utilizable la ruta de i a j
         0       1       2       3
0        0       0       0       0
1        0       0       0       0
2        0       0       0       1
3        0       0       1       0
;

Variables
X(i,j,t) camiones que van de i a j en el periodo t
Y(j,t) camiones que hay en j en el periodo t
Z(j) camiones totales repartidos a j al final del ultimo periodo
auxZ(j) se reparte algun camion a j al final del ultimo periodo

H(i,j) habilitamos el puente de i a j

Ayuda ayuda total repartida
Eq criterio de equidad = numero de nodos a los que se les reparte algun camion
;

Integer variables X, Y, Z;
Binary variables auxZ, H;

Equations

definir_Y(j,t) ecuacion de flujo
definir_Z(j) ultimo valor del almacenaje Y
definir_auxZ(j) nulidad de Z

lim_salida(j,t) de un nodo como mucho sale lo almacenado en el periodo anterior
flujo_ini(j) no hay almacenado nada en ningun nodo no inicial
flujo_ini_0 en el nodo inicial esta almacenada la totalidad de camiones

existencia_ruta(i,j,t)
usabilidad_ruta(i,j,t)
orientacion(i,j) si se habilita un sentido se ha de habilitar el opuesto
lim_puentes

lim_demanda(j)

f_ayuda funcion objetivo 1
f_equidad funcion objetivo 2
;

definir_Y(j,t)$(ord(t)>1).. Y(j,t) =E=
                            Y(j,t-1) + sum(i, X(i,j,t)) - sum(i, X(j,i,t));
definir_Z(j).. Z(j) =E= Y(j,"3");
* "4" porque es el numero de periodos
definir_auxZ(j).. auxZ(j) =L= Z(j);

lim_salida(j,t).. sum(i,X(j,i,t)) =L= Y(j,t-1);
flujo_ini(j)$(ord(j)>1).. Y(j,"0") =E= 0;
flujo_ini_0.. Y("0","0") =E= max_camiones;

existencia_ruta(i,j,t).. X(i,j,t) =L= 99*E(i,j);
usabilidad_ruta(i,j,t).. X(i,j,t) =L= 99*(U(i,j) +  H(i,j));
orientacion(i,j).. H(i,j) =E= H(j,i);
lim_puentes..  sum(i, sum(j, H(i,j))) =L= max_puentes;

lim_demanda(j).. Z(j) =L= dem(j);

f_ayuda.. Ayuda =E= sum(j, Z(j)-dem(j));
f_equidad.. Eq =E= sum(j, auxZ(j));
;

model modelo1 /all - lim_demanda/;

solve modelo1 using MIP maximizing Ayuda;
solve modelo1 using MIP maximizing Eq;



