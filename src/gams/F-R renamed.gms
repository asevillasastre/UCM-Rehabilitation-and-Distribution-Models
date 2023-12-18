$Title M-F renamed

Set
j nodos representan los asentamientos /0*6/
t periodos se asumen de misma duración además de que todos los arcos se pueden recorrer en uno de estos periodos

 /0*6/
;

Alias
(j,i,k)
;

Parameters
dem(j) demanda por cada asentamiento de un único recurso en cierta unidad discreta
                        /0 0,
                         1 1,
                         2 1,
                         3 1,
                         4 8,
                         5 4,
                         6 4/
max_camiones máximo número de camiones que podemos mandar en total a la misión. se asume que cada camión transporta exactamente una unidad del recurso a repartir
 /10/
max_puentes máximo número de puentes que podemos reconstruir previo paso a los camiones (un puente por cada sentido consideramos un grafo orientado)
 /2/
;

Table E(i,j) existe la ruta de i a j
    0   1   2   3   4   5   6
0   0   1   1   1   0   1   0
1   1   0   0   0   0   0   0
2   1   0   0   0   0   0   0
3   1   0   0   0   1   0   0
4   0   0   0   1   0   0   0
5   1   0   0   0   0   0   1
6   0   0   0   0   0   1   0   
;

Table U(i,j) al inicio es utilizable la ruta de i a j
    0   1   2   3   4   5   6
0   0   1   0   1   0   0   0
1   1   0   0   0   0   0   0
2   0   0   0   0   0   0   0
3   1   0   0   0   0   0   0
4   0   0   0   0   0   0   0
5   0   0   0   0   0   0   1
6   0   0   0   0   0   1   0 
;

Variables
X(i,j,t)  camiones que van de i a j en el periodo t

Y(j,t) camiones que hay en j en el periodo t. se asume que pueden seguir su ruta o bien quedarse en j para proseguir su ruta en otro periodo o bien permanecer en j hasta el final del último periodo

Z(j) camiones totales emplazados en j al final del último periodo. se asume que en ese momento hacen el reparto a j

auxZ(j) variable binaria que representa si se reparte al menos una unidad de recurso a j


H(i,j) variable binaria que determina si habilitamos el puente de i a j


Ayuda aa
Eq aa
;

Integer variables X, Y, Z;
Binary variables auxZ, H;

Equations

definir_Y(j,t) restricción de almacenamiento. en cierto nodo permanece lo almacenado en el anterior periodo más lo que entra a él en el presente menos lo que sale

definir_Z(j) determina lo repartido como lo ubicado en cierto nodo en el último periodo

definir_auxZ(j) 


lim_salida(j,t) limita las unidades que pueden salir de un nodo a las almacenadas en el mismo
flujo_ini(j) no hay almacenado nada en ningun nodo no inicial
flujo_ini_0 en el nodo inicial está almacenada la totalidad de los camiones

existencia_ruta(i,j,t)
usabilidad_ruta(i,j,t)
orientacion(i,j) si se habilita un sentido se ha de habilitar el opuesto
lim_puentes límite de puentes que podemos reconstruir

lim_demanda(j) no se puede superar la demanda

f_ayuda función objetivo 1. cantidad total del recurso repartida en cierta unidad
f_equidad función objetivo 2.  criterio de equidad. número de nodos a los que se les reparte al menos una unidad de recurso
;

definir_Y(j,t)$(ord(t)>1).. Y(j,t) =E=
                            Y(j,t-1) + sum(i, X(i,j,t)) - sum(i, X(j,i,t));
definir_Z(j).. Z(j) =E= Y(j,"3");
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

model modelo1 /all/;

solve modelo1 using MIP maximizing Ayuda
;
solve modelo1 using MIP maximizing Eq
;



