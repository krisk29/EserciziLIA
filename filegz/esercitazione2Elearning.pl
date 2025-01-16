/**Definire una predicato segmentList/2. segmentList(X,Y) è vero se X è una lista di interi e Y una
 lista di interi dove le liste in Y sono le sottoliste consecutive di X ottenute rispettando le seguenti regole:

Ogni sottolista deve contenere numeri consecutivi in base alla differenza di 1 (esempio: [3, 4, 5] o [10, 11]).
Quando la sequenza si interrompe (esempio: passando da 5 a 8), inizia una nuova sottolista.
La funzione deve restituire una lista di sottoliste.

segmentList([3, 4, 5, 8, 9, 10, 3, 4, 12, 13, 14, 20], [[3, 4, 5], [8, 9, 10], [3, 4], [12, 13, 14], [20]])
**/

segmentList([],[]).
segmentList([X], [[X]]).
segmentList(L,[PrimaParte|Resto]):-isList(L),trovaComposizione(L,PrimaParte,Resto1),segmentList(Resto1,Resto).

isList([]).
isList([_|T]):-isList(T).

trovaComposizione([],[],[]).
trovaComposizione([H1,H2|T],[H1|Sottolista],Rimanente):-H2=:=H1+1,trovaComposizione([H2|T],Sottolista,Rimanente).
trovaComposizione([H1,H2|T],[H1],[H2|T]):-H2=\=H1+1.
trovaComposizone([X],[X],[]).


tutteLeSottolisteConsecutive([],[]).
tutteLeSottolisteConsecutive(L,Ret):-findall(X,trovaSotto(L,X),Ret).

trovaSotto(L,Ris):-append(_,Suffisso,L),append(Ris,_,Suffisso),length(Ris,M),M >0.


/**Supponendo di avere una base di fatti per i seguenti predicati: persona/2, amico/2, maschio/1, femmina/1,
 *  dove persona contenga come primo termine il nome della persona e come secondo la sua età-
Si definiscano i predicati seguenti:
p1(X): vero se e solo X tutte le amiche femmine di X sono più grandi di almeno un amico maschio di X
p2(X): vero se e solo se almeno uno degli amici più anziani di X (che non sono più piccoli di un altro amico di X) è maschio
stessaetadegliatri(X): vero se e solo se X ha un amico Y la cui età è uguale alla somma delle età degli altri amici di X**/
persona(chiara,10).
persona(giuseppe,22).
persona(sofia,22).
persona(miriam,21).
persona(kira,20).
persona(antonio,1).
persona(andreafuda,0).
%persona(rocco,74).

femmina(kira).
femmina(sofia).
femmina(miriam).
femmina(chiara).
maschio(giuseppe).
maschio(antonio).
maschio(andreafuda).
maschio(rocco).

%amico(giuseppe,rocco).
amico(giuseppe,chiara).
amico(giuseppe,kira).
amico(giuseppe,miriam).
amico(giuseppe,sofia).
amico(giuseppe,antonio).
amico(giuseppe,andreafuda).

/**p1(X): vero se e solo X tutte le amiche femmine di X sono più grandi di almeno un amico maschio di X**/
p1(X):- \+(unaamicapiccola(X)).
unaamicapiccola(X):-amico(X,Y),femmina(Y),persona(Y,E),\+piugrandedialmenouno(X,E).
piugrandedialmenouno(X,E):-amico(X,Z),maschio(Z),persona(Z,E1),E>E1.

/**p2(X): vero se e solo se almeno uno degli amici più anziani di X (che non sono più piccoli di un
 *  altro amico di X) è maschio**/
p2(X):- amico(X,Y),\+piupiccolodiunaltro(X,Y),maschio(Y).
piupiccolodiunaltro(X,Y):-amico(X,Z),maschio(Z),persona(Z,E1),persona(Y,E2),E2<E1.


/**stessaetadegliatri(X): vero se e solo se X ha un amico Y la cui età 
 * è uguale alla somma delle età degli altri amici di X**/
stessaetadeglialtri(X):- amico(X,Y),persona(Y,E),sommaEtaSi(X,Y,E).

sommaEtaSi(X,Y,E):-trovaEta(X,Y,E1),E=:=E1.

trovaEta(X,Y,E1):-findall(E2,(amico(X,Z),Y\=Z,persona(Z,E2)),L),sommavalori(L,E1).

sommavalori([],0).
sommavalori([H|T],E):-sommavalori(T,Ris),E is H+Ris.

