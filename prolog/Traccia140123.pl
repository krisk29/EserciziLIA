/*
 Esercizio1 uguale a 13-01-2023
 */

/*
Si considerino i seguenti predicati 
 
studente(nome, cognome, matricola) 
esame(idcorso, matricola, voto) 
corso(idcorso, nome) 
 
si definiscano il seguente predicato prolog: 
studentebravo(X) che restituisce vero se X ha fatto gli esami di tutti i corsi
*/
%false se c'è almeno un corso di cui esame non ha fatto 
%non c'è un corso di cui non ha fatto l'esame
studentebravo(X):-
    studente(_,_,X),
    \+ (corso(ID,_),
           \+ esame(ID,X,_)).

studente(mario, rossi, m123).
studente(luigi, verdi, m456).
corso(c1, matematica).
corso(c2, fisica).
esame(c1, m123, 28).
esame(c2, m123, 30).
esame(c1, m456, 25).