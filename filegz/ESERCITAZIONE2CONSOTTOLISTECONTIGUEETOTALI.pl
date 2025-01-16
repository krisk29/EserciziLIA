/**Definire una predicato segmentList/2. segmentList(X,Y) è vero se X è una lista di interi e Y 
 * una lista di interi dove le liste in Y sono le sottoliste consecutive di X ottenute rispettando le seguenti regole:
Ogni sottolista deve contenere numeri consecutivi in base alla differenza di 1 (esempio: [3, 4, 5] o [10, 11]).
Quando la sequenza si interrompe (esempio: passando da 5 a 8), inizia una nuova sottolista.
La funzione deve restituire una lista di sottoliste.

segmentList([3, 4, 5, 8, 9, 10, 3, 4, 12, 13, 14, 20], [[3, 4, 5], [8, 9, 10], [3, 4], [12, 13, 14], [20]])**/

segmentList([],[]).
segmentList(X,[H|T]):-creaLista(X,H,Rimanente),segmentList(Rimanente,T).

creaLista([],[],[]).
creaLista([X],[X],[]).
creaLista([H1,H2|T],[H1|Successiva],Rimanente):-H1+1=:=H2,creaLista([H2|T],Successiva,Rimanente).
creaLista([H1,H2|T],[H1],[H2|T]):-H1+1=\=H2.

creaSottolisteContigue([],[]).
creaSottolisteContigue(X,Y):-findall(Z,trovaSottoliste(X,Z),Y).

trovaSottoliste(Lista,Risultato):-append(_,Suffisso,Lista),append(Risultato,_,Suffisso),length(Risultato,M),M >0.

all_sublists(X,L):-setof(Z,sublist(Z,X),L).
sublist([], _).
sublist([X|Xs], [X|Rest]) :- 
    sublist(Xs, Rest).
sublist(Sublist, [_|Rest]) :-
    sublist(Sublist, Rest).

% Base di conoscenza
persona(anna, 25).
persona(luca, 62).
persona(marta, 35).
persona(mario, 28).
persona(sara, 20).

amico(anna, luca).
amico(anna, marta).
amico(anna, mario).
amico(luca, mario).
amico(luca, sara).
amico(marta, mario).
amico(sara, luca).

maschio(luca).
maschio(mario).
femmina(anna).
femmina(marta).
femmina(sara).

/**5)Supponendo di avere una base di fatti per i seguenti predicati: persona/2, amico/2, maschio/1, femmina/1, 
 * dove persona contenga come primo termine il nome della persona e come secondo la sua età-

Si definiscano i predicati seguenti:

p1(X): vero se e solo X tutte le amiche femmine di X sono più grandi di almeno un amico maschio di X
p2(X): vero se e solo se almeno uno degli amici più anziani di X (che non sono più piccoli di un altro amico di X)
è maschio
stessaetadegliatri(X): vero se e solo se X ha un amico Y la cui età è uguale alla somma delle età degli altri 
amici di X
**/
p1(X):-findall(Z,(amico(X,Y),femmina(Y),persona(Y,Z)),L),valido(X,L).%estraggo le eta delle amiche e vedo se valide
valido(_,[]). %se non ha amiche femmine è vero
valido(X,[H|T]):- esisteAmicoPiuPiccoloDiQuestaEta(X,H),valido(X,T). %se per ogni amica femmina esiste un amico piccolo è valido

esisteAmicoPiuPiccoloDiQuestaEta(X,E):-amico(X,Y),persona(Y,E1),maschio(Y),E1<E.%esiste amico piu piccolo


p2(X):-etaMassimaAmici(X,E),findall(Z,(amico(X,Z),persona(Z,E),maschio(Z)),L),length(L,N),N>0.
%cosi cerco eta massima degli amici, cerco tutti gli amici che abbiano quell'eta massima e che siano maschi
%se ottengo lista con almeno un elemento è true
etaMassimaAmici(X,E):-findall(Z,(amico(X,Y),persona(Y,Z)),L),trovaMassimo(L,E).

trovaMassimo([],0).
trovaMassimo([H],H).
trovaMassimo([H|T],H):-trovaMassimo(T,E),H>=E.
trovaMassimo([H|T],E):-trovaMassimo(T,E),H<E.

stessaetadegliatri(X):-amico(X,Y),persona(Y,E),findall(Z,(amico(X,A),persona(A,Z),A\=Y),L),somma(L,S),S=:=E.
%per ogni amico di X che ha eta E trovo tutti gli amici di X diversi da quello che sto considerando inserendo in L le età.
% Trovo la somma delle eta e vedo se è uguale a quella dell'amico in questione?

somma([],0).
somma([H|T],S):-somma(T,S1),S is H+S1.







