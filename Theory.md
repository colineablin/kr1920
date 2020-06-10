# Knowledge Representation in Artificial Intelligence
:calendar: 2019-2020  

## Introduction
First of all, to talk about Knowledge Representation (KR), we need to agree on what is KR : it is the field of artificial intelligence (AI) dedicated to representing information about the world in a form that a computer system can utilize to solve complex tasks. [1] [2]
But Knowledge is a broad term, different types of knowledge are existing [3][4]  : 
* __Meta Knowledge__ – It’s a knowledge about knowledge and how to gain them.
* __Heuristic Knowledge__ – Representing knowledge of some expert in a field or subject. 
* __Procedural Knowledge__ – Gives information/ knowledge about how to achieve something. 
* __Declarative Knowledge__ – Its about statements that describe a particular object and its attributes , including some behavior in relation with it. 
* __Structural Knowledge__ – Describes what relationship exists between concepts/ objects.

## Techniques of Knowledge Representation in AI
There are 4 techniques of knowledge representation [4][5]: 
<p align="center">
  <img width="300" height="300" src="Imagenes/Reinas1.png">
</p>

## Predicados complementarios 
En este apartado se explicarán los predicados/declaraciones de los que se valen cada una de las implementaciones para resolver el problema.
### range( +A, +B, -L ) 
*Es cierto si L unifica con una lista que contiene número enteros consecutivos empezando en A y terminando en B.*  
Para el desarrollo de este predicado se ha usado la inducción matemática partiendo del caso base en el que la A y B son el mismo elemento. En cuyo caso L es una lista que contiene solo a A.  
En otros casos mientras A sea menor que B, se realizan llamadas recursivas a si misma con A incrementada en 1. En cuyo caso L es una lista que tiene en la cabeza a A y en la cola la L obtenida de la llamada recursiva.  
```
range(A,A,[A]).  
range(A,B,[A|L]):-  A < B, A1 is A+1,  range(A1,B,L). 
```
```
?- range(1,5,L).  
L = [1, 2, 3, 4, 5].
```
### del( +A, +B, -C ) 
*Es cierto si C unifica con una lista que contiene a los elementos de B menos el elemento A.*  
Para el desarrollo de esta función se ha usado la inducción matemática partiendo del caso base en el que el primer elemento de B es A. En cuyo caso C es una lista con los elementos del resto de B.  
En otros casos realiza una llamada recursiva a si misma con el resto de B. En cuyo caso C es una lista que contiene en la cabeza la cabeza de B y en el resto la C obtenida de la llamada recursiva.  
```
del(A,[A|C],C).  
del(A,[B|Bs],[B|Cs]):- del(A,Bs,Cs).  
```
```
?- del(2,[1,2,3,4],C).  
C = [1, 3, 4].  
```
### permu( +A, -B ) 
*Es cierto si B unifica con una de las posibles permutaciones de los elementos de A.*  
Para el desarrollo de esta función se ha usado la inducción matemática partiendo del caso base en el que A es una lista vacía. En cuyo caso C es una lista vacía.  
En otros casos primero se elimina un elemento de A y se llama recursivamente a si mismo con el resto. En cuyo caso B es una lista que contiene al elemento eliminado en la cabeza y en el resto a la B obtenida de la llamada recursiva.  
```
permu([],[]).  
permu(A,[B|Bs]):- del(B,A,Rs), permu(Rs,Bs).  
```
```
?- permu([1,2],B).  
B = [1, 2];  
B = [2, 1].  
```
### test( +A, +B, +C, +D)
*Es cierto si A unifica con una lista en la que cada uno de sus elementos no aparecen en las listas C y D. Conteniendo estas elementos de las diagonales de cada elemento de A.Y B es un contador para controlar el elemento de la lista en revisión.*  
Para el desarrollo de esta función se ha usado la inducción matemática partiendo del caso base en el que A es una lista vacía. En cuyo es caso independientemente del contenido de los demás elementos la regla será verdadera.  
En otros casos se comprobará si las diagonales del elemento en análisis no están en C (diagonal superior) y D (diagonal inferior). En caso positivo realizara una llamada recursiva a si mismo sin el elemento analizado, con B incrementada en 1 y añadiendo a C y D las diagonales calculadas anteriormente.  
Debido a la presencia de un contador podemos observar que este predicado ha sido creado a partir de la programación iterativa. Y para su correcta ejecución se debe llamar con B = 1 y C,D = [] inicialmente.  
Cabe destacar una función que no se ha dado en clase de Representación del Conocimiento de 2019-2020.  
* memberchk( +G , +H ) Es cierto si H contiene al elemento G.
```
test([],_,_,_).  
test([Y|Ys],X,Cs,Ds):- 
C is X-Y, 
\+ memberchk(C,Cs), 
D is X+Y, 
\+ memberchk(D,Ds), 
X1 is X + 1, 
test(Ys,X1,[C|Cs],[D|Ds]).
```
```
?- test([2, 4, 1, 3], 1, [], []). 
true
```
### test( +A )
*Es cierto si A unifica con una lista que satisface las condiciones de test( A, 1, [], [] ).*  
La única función de este predicado es llamar a test( +A, +B, +C, +D ) pasándole como parámetro A, el contador empezando en 1 y dos listas vacías que representan las listas de las diagonales. Para comprobar si este satisface las condiciones de  test( +A, +B, +C, +D ).  
```
test(Qs):- test(Qs,1,[],[]). 
```
```
?- test([2, 4, 1, 3]). 
true.
```
### permu_test( +A, +B, +C, +D, +E ) 
*Es cierto si B unifica con una permutación de A en la que cada elemento no aparece en las listas D y E. Conteniendo estas a los elementos de las diagonales de cada uno de los elementos de B. Y C es un contador para controlar el elemento de la lista en revisión.*  
Este predicado es una combinación de permu( +A, -B ) y  test( +A, +B, +C, +D).  
Para el desarrollo de esta función se ha usado la inducción matemática partiendo del caso base en el que A y B son listas vacías. En cuyo caso independientemente del contenido de las demás variables devolverá verdadero.  
En caso contrario se generará una permutación de la lista A (igual que en permu( +A, -B ))y se comprobará que las diagonales de cada uno de sus elementos no esta en las listas de las diagonales D y E  (igual que en test( +A, +B, +C, +D)).  
Igual que en test( +A, +B, +C, +D ) observamos la presencia de un contador por lo que este predicado tambien ha sido creado a partir de la programación iterativa. Y para su correcta ejecución se debe llamar con C = 1 y D,E = [] inicialmente.  
```
permu_test([],[],_,_,_). 
permu_test(Qs,[Y|Ys],X,Cs,Ds):-  
del(Y,Qs,Rs),  
C is X-Y,  
\+ memberchk(C,Cs), 
D is X+Y,  
\+ memberchk(D,Ds), 
X1 is X+1, 
permu_test(Rs,Ys,X1,[C|Cs],[D|Ds]).
```
```
?- permu_test([1, 2, 3, 4],Qs,1,[],[]). 
Qs= [2, 4, 1, 3]. 
```
## Primera implementación
queens_1( +N, -Qs).  
*Es cierto si Qs unifica con una lista de N elementos en la que cada elemento representa la posición de una reina en una fila determinada. Siendo la posición ese elemento en la lista la columna esa reina.*  
En esta implementación se usan los siguientes predicados:  
* range( +A, +B, -L ): se usa para generar una lista de elementos de 1 a N. 
* permu( +A, -B ): se usa para generar una permutación de los elementos de la lista generada con range( +A, +B, -L ). 
* Test( +Qs ): se usa para comprobar si la permutación generada con permu( + A, -B ) es una solución valida del problema.
```
queens_1(N,Qs):-  
range(1,N,Rs),  
permu(Rs,Qs),  
test(Qs).
```
```
?- queens_1(4,Qs). 
Qs = [2, 4, 1, 3].
```
## Segunda implementación
queens_2( +N, -Qs).
*Es cierto si Qs unifica con una lista de N elementos en la que cada elemento representa la posición de una reina en una fila determinada. Siendo la posición ese elemento en la lista la columna esa reina*  
En esta implementación se usan los siguientes predicados:  
* range( +A, +B, -L ): se usa para generar una lista de elementos de 1 a N. 
* permu_test: se usa para ir generar permutaciones de los elementos de la lista generada con range( +A, +B, -L ) y al mismo tiempo ir comprobando si una permutación es una solución valida.
```
queens_2(N,Qs):-
range(1,N,Rs), 
permu_test(Rs,Qs,1,[],[]). 
```
```
?- queens_2(5,Qs). 
Qs = [1, 3, 5, 2, 4]. 
```
## Pruebas de ejecución
<p align="center">
  <img width="500" height="600" src="Imagenes/Reinas2.png">
</p>
Se puede observar que ninguna de las reinas esta en conflicto con otra y  las dos implementaciones nos dan la misma solución 

## Posibles mejoras
### Eliminar llamadas innecesarias a predicados en queens_1
Esta mejora se basa en dejar de usar el predicado test(+A) en el predicado queens_1(+N,-Qs) y usar directamente el predicado test( +A, +B, +C, +D ). Lo que no altera ni el resultado ni la definición del predicado.  
```
queens_1(N,Qs):-  
range(1,N,Rs),  
permu(Rs,Qs),  
test(Qs,1,[],[]). 
```
## Bibliografía
Para el desarrollo del siguiente trabajo se han consultado los siguientes enlaces:  
* [P-99: Ninety-Nine Prolog Problems](https://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/)
* [Guías de Prolog](https://www.youtube.com/channel/UCdPmeK-zVtvYS4qX_Wa87Wg)
