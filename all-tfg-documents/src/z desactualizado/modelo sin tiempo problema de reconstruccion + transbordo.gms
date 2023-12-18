$Title modelo sin tiempo reconstruccion + reparto

Set
j nodos. representan los asentamientos. en este modelo hemos de distinguir entre transitorios-destino-origen /0*6/
;

Alias
(j,i,k)
;

Parameters
dem(j) demanda por cada asentamiento de un unico recurso en cierta unidad continua /0 0,
                         1 0,
                         2 0,
                         3 0
                         4 3
                         5 1
                         6 1/
max_ayuda maximo numero de ayuda que podemos mandar en total a la mision. se asume que se puede transportar cualquier cantidad sin coste temporal o economico alguno /3/
max_puentes maximo numero de puentes que podemos reconstruir previo paso a los camiones /1/
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
X(i,j ) flujo de i a j. es continuo. puede ser negativo si el de j a a i es positivo
Y(j ) flujo que se queda en j
auxZ(j) variable binaria que determina si llega alguna ayuda a j

H(i,j) variable binaria que determina si habilitamos el puente de i a j

Insatis 
Insatisaux
Eq 
;

Positive variables Insatisaux;
Binary variables H, auxZ;

Equations

definir_Y(j) ecuacion de flujo

solo_arcos_buenos(i,j) consideramos de flujo nulo la mitad de los nodos. asi consideramos un grafo no orientado

*lim_demanda(j) 
lim_provisiones restriccion que fija la cantidad de ayuda que podemos enviar
flujo_nulo(j) en los nodos transitorios el flujo es nulo


existencia_ruta(i,j)
usabilidad_ruta(i,j)
existencia_ruta_min(i,j) en este modelo son necesarias 2 restricciones para que el flujo sea nulo y no negativo en los arcos no existentes
usabilidad_ruta_min(i,j) ídem con los no usables
lim_puentes

def_insatisaux definimos la demanda insatisfecha

def_auxZ1(j) definimos los nodos a los que llega alguna ayuda
def_auxZ2(j) a los nodos transitorios no puede llegar ninguna ayuda por lo que no cuentan

f_insatis funcion objetivo 1. demanda insatisfecha total
f_eq funcion objetivo 2. criterio de equidad. numero de nodos a los que se les reparte alguna cantidad de ayuda
;

definir_Y(j).. Y(j) =E= sum(i, X(i,j)) - sum(i, X(j,i));

solo_arcos_buenos(i,j)$(ord(i)<=ord(j)).. X(j,i) =E= 0; 

*lim_demanda(j).. Y(j) =L= dem(j);
lim_provisiones.. Y("0") =G= -max_ayuda;
flujo_nulo(j)$(ord(j)>1 and ord(j)<=4).. Y(j) =E= 0;

existencia_ruta(i,j).. X(i,j) =L= 99*E(i,j);
usabilidad_ruta(i,j).. X(i,j) =L= 99*(U(i,j) +  H(i,j));
existencia_ruta_min(i,j).. X(i,j) =G= -99*E(i,j);
usabilidad_ruta_min(i,j).. X(i,j) =G= -99*(U(i,j) +  H(i,j));
lim_puentes..  sum(i, sum(j, H(i,j))) =L= max_puentes;

def_insatisaux(j)$(ord(j)>=5).. Insatisaux =G= dem(j) - Y(j);

def_auxZ1(j)$(ord(j)>=5).. auxZ(j) =L= 99*Y(j);
def_auxZ2(j)$(ord(j)<=4).. auxZ(j) =E= 0;

f_eq.. Eq =E= sum(j, auxZ(j));
f_insatis.. Insatis =E= sum(j, Insatisaux);

model modelo1 /all/;

solve modelo1 using MIP minimizing Insatis;
solve modelo1 using MIP maximizing Eq;
