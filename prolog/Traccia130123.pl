/*
Data una lista L1 e un numero intero N, scrivere un predicato Prolog domanda1(L1,N,L2) che restituisca in L2 la lista 
degli elementi di L1 che sono liste contenenti solo due valori interi positivi fra 1 e 9 la cui somma valga N. 
 
Esempio: 
:- domanda1([[3,1],5,[2,1,1],[3],[1,1,1],a, [2,2]],4,L2). 
yes, L2 = [[3,1], [2,2]] 
*/
domanda1([],_,[]).

domanda1([H|T],N,[H|L2]):- 
    is_list(H),
    length(H,2),
    controlla(H,N),
    domanda1(T,N,L2).

domanda1([_|T],N,L2):-domanda1(T,N,L2).

controlla([H1,H2|_],N):-
    integer(H1),
    integer(H2),
    H1>0,H1<10,
    H2>0,H2<10,
    N is H1+H2.

/*
Si considerino i seguenti predicati 
 
studente(nome, cognome, matricola) 
esame(idcorso, matricola, voto) 
corso(idcorso, nome) 
 
si definiscano il seguente predicato prolog: 
media(matricola, valore) # che restituisce vero se la media degli esami sostenuti dallo studente avente come matricola il 
primo termine è uguale a valore (si assuma che ogni corso sia caratterizzato dallo stesso numero di crediti)
*/
media(Matricola,Valore):-
	findall(Voti,esame(_,Matricola,Voti),ListaVoti),
    sommavoti(ListaVoti,Somma),
    length(ListaVoti,NumEsami),
    Valore is Somma/NumEsami.

sommavoti([], 0).                              
sommavoti([H|T], Somma) :-
    sommavoti(T , SommaRestante),                   
    Somma is H + SommaRestante.                     

% Fatti per studente
studente('Mario', 'Rossi', 12345).
studente('Giulia', 'Bianchi', 67890).

% Fatti per esami sostenuti
esame(1, 12345, 28).
esame(2, 12345, 30).
esame(3, 12345, 26).

esame(1, 67890, 24).
esame(2, 67890, 25).