$Title Modelo de rutas con vehiculos, coste variable, coste por rehabilitacion y VUELTA
* 17-03-23: tiempo implementado
* 06-04-23: incluida Eq, se queda en un nodo implementado, quitamos auto_cero
* 06-04-23: optimizamos con $(E(i,j) > 0)
* 15-04-23: vuelta implementada
* 15-04-23: decido que es el definitivo

Set
j Nodos.
/0*5/
v Tipos de vehiculo.
/0*2/
w Vehiculos posibles de tipo v.
/0*25000/
;

Alias
(j,i,k)
;

Parameters
dem(j) Demanda de cada nodo en toneladas de paquetes de ayuda.
/
0 0,
1 1,
2 1,
3 1,
4 8,
5 4
/
capacidad_vehiculo(v) Capacidad en toneladas de una unidad vehicular de tipo v.
/
0 1
1 2
2 5
/
coste_fijo(v) Coste fijo en euros de hacer partir un vehiculo de tipo v.
/
0 10
1 20
2 30
/
coste_variable Coste variable en euros por km recorrido por cualquier vehiculo.
/2/
max_coste Maximo presupuesto que se puede invertir en total en la mision.
/2000/
max_habilitaciones Maximo numero de arcos que se pueden rehabilitar previo paso a los vehiculos.
/10/
M Cota de vehiculos maximos.
/999/
P_total Probabilidad aceptable de que todos los convoys puedan pasar por todas las rutas elegidas.
/0.01/
T_max Tiempo maximo asumible en horas para el reparto de toda la ayuda.
/150/
velocidad_vehiculo(v)  Inversa de la velocidad en h por km que recorre un vehiculo de tipo v.
/
0 0.4
1 0.3
2 0.2
/
;

Table E(i,j) Existe el arco de i a j.
      0     1     2     3     4     5
0     0     1     0     1     0     0     
1     1     0     1     0     0     0     
2     0     1     0     0     1     0     
3     1     0     0     0     0     0     
4     0     0     1     0     0     1     
5     0     0     0     0     1     0     
;
Table U(i,j) El inicio es utilizable el arco de i a j.
      0     1     2     3     4     5
0     0     1     0     1     0     0     
1     1     0     1     0     0     0     
2     0     1     0     0     0     0     
3     1     0     0     0     0     0     
4     0     0     0     0     0     0     
5     0     0     0     0     0     0     
;
Table dist(i,j) Distancia de las rutas de i a j en km.
      0     1     2     3     4     5
0     0     2     0     4     0     0     
1     2     0     1     0     0     0     
2     0     1     0     0     0     0     
3     4     0     0     0     0     0     
4     0     0     0     0     0     0     
5     0     0     0     0     0     0     
;
Table coste_rehabilitacion(i,j) Coste de rehabilitar el arco de i a j.
      0     1     2     3     4     5
0     0     2     0     4     0     0     
1     2     0     1     0     0     0     
2     0     1     0     0     0     0     
3     4     0     0     0     0     0     
4     0     0     0     0     0     0     
5     0     0     0     0     0     0     
;

Table P(i,j) Probabilidad de que se pueda utilizar el arco de i a j.
    0     1   2   3   4   5   
0   1     0.7 0.7 0.7 1   0.8  
1   0.7   1   1   1   1   1   
2   0.7   1   1   1   1   1      
3   0.7   1   1   1   0.7 1    
4   1     1   1   0.7 1   1    
5   0.8   1   1   1   1   1     
;
loop(i,
    loop(j,
        P(i, j) := log2(P(i,j));
        );
    );

P_total = log2(P_total);

Variables

X(i,j,v,w) El vehiculo de tipo v w-esimo va de i a j.
Z(j,v,w) El vehiculo de tipo v w-esimo reparte a j.
Ayuda(j) Ayuda total repartida a j.
H(i,j) Habilitamos el arco de i a j.
Insatis Total demanda insatisfecha.
Coste Coste total del proyecto.
Salio(v,w) Variable binaria que determina si un vehiculo partio a la mision.

t(v,w) Tiempo de servicio del vehiculo w-esimo de tipo v.

Usado(i,j) Variable binaria que determina si se usa el arco de i a j.
Fiabilidad Logaritmo de la robabilidad de que todos los convoys puedan pasar por todos los arcos elegidos.

Y(i,j,v,w) El vehiculo v wesimo va de i a j volviendo.

Prop_insatis(j) Proporcion de demanda insatisfecha en el nodo j.
Eq Funcion objetivo 2. Criterio de equidad. Maxima proporcion de demanda insatisfecha.
Insatisaux(j) Determina la demanda insatisfecha en el nodo j.
;

Positive variables t, Prop_insatis, Insatisaux;
Integer variables Ayuda;
Binary variables X, Z, H, Usado, Salio, Y;

Equations

conexion_ruta(j,v,w) Un vehiculo solo puede salir de un nodo al que ha entrado.
destino_unico(i,v,w) Un vehiculo que sale de un nodo puede llegar a un unico contiguo.
consistencia_reparto_llegada(j,v,w) Se reparte en un nodo al que se llega.
consistencia_reparto_salida(j,v,w) No se puede salir de un nodo al que se reparte.
reparto_unico(v,w) Obliga a los vehiculos que han partido a repartir en un nodo y a los que se detienen a haber partido.
def_salio(v,w) Define la variable binaria que determina si un vehiculo partio a la mision.
existencia(i,j,v,w) Impide el paso por arcos no existentes.
usabilidad(i,j,v,w) Impide el paso por arcos no usables ni rehabilitados.
lim_coste 
lim_habilitaciones
def_Ayuda(j) Ayuda total en toneladas que llega al nodo j.
lim_demanda(j) Impide superar la demanda de cada nodo.
def_Coste Definicion del coste.

def_tiempos(v,w) Define los tiempos de servicio de los vehiculos.
lim_tiempo(v,w) Establece el limite temporal de la mision.

def_fiabilidad Define el valor de la fiabilidad.
lim_fiabilidad Obliga a la solucion a contemplar una fiabilidad minima.
arco_usado(i,j) Determina si el arco de i a j se ha utilizado.

Y_conexion_ruta(j,v,w)
Y_destino_unico(i,v,w)
Y_usabilidad(i,j,v,w)
Y_existencia(i,j,v,w)
vuelta_inicio(i,v,w) Un vehiculo debe volver desde donde reparte.
vuelta_consistente_inicial(j,v,w) No pueden volver vehiculos desde el nodo inicial.
vuelta_final(v,w) El vehiculo que sale debe volver al nodo inicial.

def_Eq(j) Funcion objetivo 2. Criterio de equidad. Maxima proporcion de demanda insatisfecha.
def_prop(j) Determina la proporcion de demanda insatisfecha en el nodo j.
def_insatisaux(j) Determina la demanda insatisfecha en el nodo j.

f_Insatis

;

conexion_ruta(j,v,w)$(ord(j)>1).. sum(i, X(i,j,v,w)) =G= sum(i, X(j,i,v,w));
consistencia_reparto_llegada(j,v,w).. Z(j,v,w) =L= sum(i, X(i,j,v,w));
consistencia_reparto_salida(j,v,w).. Z(j,v,w) =L= 1 - sum(i, X(j,i,v,w));
destino_unico(i,v,w).. sum(j, X(i,j,v,w)) =L= 1;
reparto_unico(v,w).. Salio(v,w) =E= sum(j, Z(j,v,w));
def_salio(v,w).. sum(j, X("0",j,v,w)) =E= Salio(v,w);
existencia(i,j,v,w).. X(i,j,v,w) =L= E(i,j);
usabilidad(i,j,v,w)$(E(i,j) > 0).. X(i,j,v,w) =L= U(i,j) + H(i,j);
lim_coste.. Coste =L= max_coste;
lim_habilitaciones.. sum(i, sum(j, H(i,j))) =L= max_habilitaciones;
def_Ayuda(j).. Ayuda(j) =E= sum(v, sum(w, Z(j,v,w)*capacidad_vehiculo(v)));
lim_demanda(j).. Ayuda(j) =L= dem(j);
def_Coste.. Coste =E= sum(i, sum(j, sum(v, sum(w, (X(i,j,v,w) + Y(i,j,v,w))*coste_variable*Dist(i,j))))) +
                      sum(i, sum(j, H(i,j)*coste_rehabilitacion(i,j))) +
                      sum(v, sum(w, Salio(v,w)*coste_fijo(v)));

def_tiempos(v,w).. t(v,w) =E= sum(i,sum(j, (X(i,j,v,w) + Y(i,j,v,w))*dist(i,j)*velocidad_vehiculo(v)));
lim_tiempo(v,w).. t(v,w) =L= T_max;

arco_usado(i,j)$(E(i,j) > 0).. M*Usado(i,j) =G= sum(v, sum(w, X(i,j,v,w) + Y(i,j,v,w)));
def_fiabilidad.. Fiabilidad =E= sum(i, sum(j, Usado(i,j)*P(i,j)));
lim_fiabilidad..  Fiabilidad =G= P_total;

Y_conexion_ruta(j,v,w).. sum(i, Y(i,j,v,w)) + Z(j,v,w) =G= sum(i, Y(j,i,v,w));
Y_destino_unico(i,v,w)..sum(j, Y(i,j,v,w)) =L= 1;
Y_usabilidad(i,j,v,w)$(E(i,j) > 0).. Y(i,j,v,w) =L= U(i,j) + H(i,j);
Y_existencia(i,j,v,w)$(E(i,j) > 0).. Y(i,j,v,w) =L= E(i,j);
vuelta_inicio(i,v,w).. Z(i,v,w) =L= sum(j,Y(i,j,v,w));
vuelta_consistente_inicial(j,v,w).. Y("0",j,v,w) =E= 0;
vuelta_final(v,w).. Salio(v,w) =E= sum(i, Y(i,"0",v,w));

def_Eq(j).. Eq =G= Prop_insatis(j);
def_prop(j).. Prop_insatis(j)*dem(j) =E= Insatisaux(j);
def_insatisaux(j).. Insatisaux(j) =E= dem(j) - Ayuda(j);

f_Insatis.. Insatis =E= sum(j, Insatisaux(j));

model modelo1 /all/;

solve modelo1 using MIP minimizing Insatis;
solve modelo1 using MIP minimizing Eq;

