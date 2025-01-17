/*
NON SO SE GLI ESERCIZI SONO CORRETTI, NON TESTATI
*/

% esercizio 1
/*
Data una base di conoscenza prolog che contiene i predicati
arco(X,Y) -- dove X e Y sono termini (semplici) che rappresentano nodi
nodo(X,V) --- dove X è un nodo e V un valore numerico che rappresenta il valore di un nodo.
Definire in prologo i seguenti predicati:
valoreraggiungibile(X,V) che è vero se e solo se X è un nodo e V e è il valore di un nodo raggiungibile da X.
maxVraggiungibile(X,V) che  vero se e solo se X è un nodo e V e è il massimo fra i valori associati ai nodi raggiungibili da X.
*/

valoreraggiungibile(X,V):-nodo(X,V)-
valoreraggiungibile(X,V):-arco(X,Y),valoreraggiungibile(Y,V).
maxVraggiungibile(X,V):- nodo(X,_), findall(Y, arco(X,Y), NodiRaggiungibili), NodiRaggiungibili \=[], controllaMax(NodiRaggiungibili,V).
controllaMax([H|T],Max):- controllaMax(T,MaxTemp), Max is max(H,MaxTemp). 


% esercizio 2
/* Data una base di conoscenza prolog che contiene i predicati
arco(X,Y) -- dove X e Y sono termini (semplici) che rappresentano nodi
nodo(X,V) --- dove X è un nodo e V un valore numerico che rappresenta il valore di un nodo.
Definire in prolog il predicato  cricca(K) che restituisce vero se esiste un insieme di nodi X (suggerimento: si può rappresentare come una lista) tale che:
|X|>=k
per ogni coppia di nodi A,B in X arco(A,B) è vero
*/
cricca(K):- K>0,selezionaNodi(K,Nodi),eCricca(Nodi).

selezionaNodi(K,Nodi):-findall(X,nodo(X,_),TuttiNodi),length(Nodi,K),sottoinsieme(Nodi,TuttiNodi).

sottoinsieme([],[]).
sottoinsieme([H|T],[H2|T2]):-sottoinsieme(T,T2).
sottoinsieme(X,[_|T]):-sottoinsieme(X,T).

eCricca([]).
eCricca([_]).
eCricca([H|T]):-eCricca(T),connessoATutti(H,T).

connessoATutti(_,[]).
connessoATutti(X,[H|T]):-connesso(X,H),connessoATutti(X,T).

connesso(A,B):-arco(A,B).
connesso(A,B):-arco(B,A). %questo perchè l'arco va considerato simmetrico