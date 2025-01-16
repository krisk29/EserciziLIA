--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input un intero x e una lista di interi xs restituisce la lista degli
--interi in xs diversi da x mantenendo però la prima occorrenza di x (elimina quindi da xs le ripetizioni di x). L’ordine di
--apparizione degli interi deve essere mantenuto.
deleteWF:: Int-> [Int] -> [Int]
deleteWF _ [] = []
deleteWF f (x:xs) = if x == f then x:[y | y<-xs, y/=f] else x:(deleteWF f xs)



--ESERCIZIO 2
--Definire la funzione
--estraisottoliste :: Int-> [Int] → [[Int]] che ricevendo in input un inter k e una lista 
--di interi xs restituisce una lista contenente tutte le sottoliste contigue di xs di lunghezza k
estraisottoliste :: Int -> [Int] -> [[Int]]
estraisottoliste _ [] = []
estraisottoliste l (x:xs) = if length (x:xs) >= l then  (take l (x:xs)) : estraisottoliste l xs else [] --se non metto il controllo all'inizio da risultati del tipo estraisottoliste 2 [1,2,3] -> [[1,2],[2,3],[3]]

{-
Qual è il tipo dell’espressione definita nel seguente modo
map (+1)
map :: (a->b) -> [a] -> [b]
-}



--PROLLOG
{-

ESERCIZIO 1
------CHATGPT
SOL1 RICORSIONE
/*
 * Definire il predicato posizionen(N, ListaIn, ListaOut) che, presa una lista 
 * di elementi ground, ListaIn, restituisce la lista
composta dagli elementi di ListaIn che si trovano in posizione multipla
di N (assumiamo che il primo elemento di una
lista occupi la posizione 1).
Esempio: posizionen(3, [a, b(c), 7, [1,2,3], pippo, pluto, paperino],ListaOut) 
deve unificare ListaOut con [7, pluto].
 * */

% Caso base: se la lista di input è vuota, anche la lista di output è vuota.
posizionen(_, [], []).

% Caso ricorsivo 1: se l'indice corrente è un multiplo di N, includi l'elemento in ListaOut.
posizionen(N, [H|T], [H|Out]) :-
    length(T, Len), % Calcola quanti elementi ci sono dopo l'elemento corrente.
    Pos is Len + 2, % La posizione corrente è la lunghezza rimanente + 2 (compensa la ricorsione).
    0 is Pos mod N, % Verifica se la posizione è un multiplo di N.
    posizionen(N, T, Out).

% Caso ricorsivo 2: se l'indice corrente non è un multiplo di N, salta l'elemento.
posizionen(N, [_|T], Out) :-
    length(T, Len), % Calcola quanti elementi ci sono dopo l'elemento corrente.
    Pos is Len + 2, % La posizione corrente è la lunghezza rimanente + 2 (compensa la ricorsione).
    Pos mod N =\= 0, % Verifica se la posizione NON è un multiplo di N.
    posizionen(N, T, Out).

SOL2 CONTATORE
% Predicato principale: parte dalla posizione 1.
posizionen(N, ListaIn, ListaOut) :-
    posizionen(N, ListaIn, 1, ListaOut).

% Caso base: lista vuota.
posizionen(_, [], _, []).

% Caso ricorsivo 1: se la posizione è un multiplo di N, include l'elemento.
posizionen(N, [H|T], Pos, [H|Out]) :-
    Pos mod N =:= 0,        %in alternativa si può fare 0 is Pos mod N
    NextPos is Pos + 1,
    posizionen(N, T, NextPos, Out).

% Caso ricorsivo 2: se la posizione NON è un multiplo di N, salta l'elemento.
posizionen(N, [_|T], Pos, Out) :-
    Pos mod N =\= 0,        %in alternativa si può fare \+ (0 is Pos mod N)
    NextPos is Pos + 1,
    posizionen(N, T, NextPos, Out).


--ESERCIZIO 2
/*
 * Si considerino i seguenti predicati
 
rally(nome)
vincitore(nomepilota, nomerally, data)
pilota(nome)

si definisca il seguente predicato prolog:
rallyvinti(nomepilota, valore) # che restituisce vero se nomepilota ha vinto valore rally
piubravo(nomepilota) # che restituisce vero se nomepilota ha vinto il maggior numero di rally
piùcontinuo(nomepilota) # che restituisce vero se nomepilota ha vinto il maggior numero di rally consecutivi

 * 
 *  */


rally(montecarlo).
rally(sardegna).
rally(finlandia).
rally(svezia).

pilota(loeb).
pilota(ogier).
pilota(tanak).

% I fatti sono già ordinati temporalmente
vincitore(loeb, montecarlo, 1).
vincitore(ogier, svezia, 2).
vincitore(tanak, sardegna, 3).
vincitore(tanak, finlandia, 4).


% rallyvinti(nomepilota, valore) restituisce il numero di rally vinti dal pilota nomepilota.
rallyvinti(Pilota, Valore) :-
    findall(NomePilota, vincitore(Pilota, _, _), ListaRally),
    length(ListaRally, Valore).

% piubravo(NomePilota)
% Vero se NomePilota ha vinto il maggior numero di rally
piubravo(NomePilota) :-
    pilota(NomePilota),
    rallyvinti(NomePilota, VittoriePilota),
    \+ (pilota(AltroPilota),
        AltroPilota \= NomePilota,
        rallyvinti(AltroPilota, VittorieAltro),
        VittorieAltro > VittoriePilota).


% Predicato ausiliario per ottenere le sequenze consecutive di vittorie
sequenze_consecutive(Pilota, MaxSeq) :-
    findall(N, vincitore(Pilota, _, N), Vittorie),
    conta_sequenza(Vittorie, 0, 0, MaxSeq).

% Conta la lunghezza della sequenza più lunga
conta_sequenza([], CurrSeq, MaxSeq, Res) :-
    Res is max(CurrSeq, MaxSeq).
conta_sequenza([_], CurrSeq, MaxSeq, Res) :-
    NewSeq is CurrSeq + 1,
    Res is max(NewSeq, MaxSeq).
conta_sequenza([N1,N2|Rest], CurrSeq, MaxSeq, Res) :-
    N2 =:= N1 + 1 ->
        NewCurrSeq is CurrSeq + 1,
        conta_sequenza([N2|Rest], NewCurrSeq, MaxSeq, Res)
    ;
        NewCurrSeq is CurrSeq + 1,
        NewMaxSeq is max(NewCurrSeq, MaxSeq),
        conta_sequenza([N2|Rest], 0, NewMaxSeq, Res).

% piucontinuo(+NomePilota)
piucontinuo(NomePilota) :-
    pilota(NomePilota),
    sequenze_consecutive(NomePilota, MaxSeqPilota),
    \+ (pilota(AltroPilota),
        AltroPilota \= NomePilota,
        sequenze_consecutive(AltroPilota, MaxSeqAltro),
        MaxSeqAltro > MaxSeqPilota).



--ESERCIZIO 3
Quale tra i seguenti predicati implementa il not (inteso non come negazione logica ma come incapacità di provare un
goal a partire dalle informazioni contenute nella base di conoscenza di Prolog)? Motivare la risposta.
not1(X) :- X, !, fail.
not1(X).
not2(X) :- !, X, fail.
not2(X).
not3(X) :- X, fail, !.
not3(X)

not1/1 è l'implementazione corretta del not in Prolog, perché utilizza il cut e il fail nel modo giusto.
Gli altri predicati (not2/1 e not3/1) non rispettano il comportamento richiesto:
not2/1 applica il cut troppo presto e fallisce sempre.
not3/1 è mal progettato e contiene operazioni inutili
-}