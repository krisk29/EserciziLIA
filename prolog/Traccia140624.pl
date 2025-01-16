/*
Definire un predicato prolog subsequences/2 che abbia come primo e secondo termine due liste L1 e L2  tali che
subsequences(L1, L2) restisca vero se e solo se L2 si può ottenere da L1 rimuovendo alcuni dei suoi elementi (anche nessuno o tutti)
esempi:
•	subsequences([1,2,3],[2,1]) è falso
•	subsequences([1,2,3],[1,3]) è vero
•	subsequences([1,2,3],[1,5]) è falso
•	subsequences([1,2,3],[]) è vero
il predicato deve funzionare (almeno) in modalità +, +, ma è preferibile che funzioni anche in modalità +,-
*/

% Caso base: la lista vuota è una sottosequenza di qualsiasi lista
subsequences(_, []).

% Caso ricorsivo per quando prendiamo l'elemento
subsequences([X|Xs], [X|Ys]) :- subsequences(Xs, Ys).

% Caso ricorsivo per quando saltiamo l'elemento
subsequences([_|Xs], Ys) :- subsequences(Xs, Ys).


/*
Supponendo di avere una base di fatti per i seguenti predicati: 
persona/2, amico/2, maschio/1, femmina/1, 
dove persona contenga come primo termine il nome della persona
e come secondo la sua età
Si definiscano i predicati seguenti:
1.	soloamicifemmine(X): vero se e solo X ha solamente amici di 
sesso femminile (nel caso X non abbia amici il predicato è vero)
2.	amicistessaeta(X): vero se e solo tutti almeno 
una coppia di amici di X hanno la medesima età
3.	stessiamici(X,Y): vero se e solo se X e Y hanno degli insiemi 
di amici AX e AY tali che AX e AY coincidono
*/

persona(mario, 20).
persona(luigi, 20).
persona(anna, 20).
persona(sara, 21).
maschio(mario).
maschio(luigi).
femmina(anna).
femmina(sara).
amico(mario, mario).
amico(mario, anna).
amico(luigi, anna).

soloamicifemmine(X):-
    findall(Amici,amico(X,Amici),ListaAmici),
    verificafemmine(ListaAmici).

verificafemmine([]).
verificafemmine([H|T]):-
    femmina(H),
    verificafemmine(T).

% vero se almeno due amici di X hanno la stessa età
amicistessaeta(X) :-
    amico(X, Amico1),
    amico(X, Amico2),
    Amico1 \= Amico2,
    persona(Amico1, Eta),
    persona(Amico2, Eta).

stessiamici(X,Y):-
    findall(Amici,amico(X,Amici),ListaAmiciX),
    findall(Amici,amico(Y,Amici),ListaAmiciY),
    sort(ListaAmiciX, SListaAmiciX),
	sort(ListaAmiciY, SListaAmiciY),
    SListaAmiciX==SListaAmiciY.