--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input un intero x e una lista di interi xs restituisce la lista degli
--interi in xs che sono più piccoli di x
smaller:: Int-> [Int] -> [Int]
smaller _ [] = []
smaller n xs = [x | x<-xs, x<n] 



--ESERCIZIO 2
--Si consideri il tipo di dati
--data Expr = Val Int | App Op Expr Expr
--data Op = Add | Mul
--Si definisca la funzione
--eval :: Expr → Int
--che restisca il valore intero derivante dalla valutazione dell’espressione
data Expr = Val Int | App Op Expr Expr
data Op = Add | Mul

eval :: Expr -> Int
eval (Val n) = n
eval (App Add e1 e2) = eval e1 + eval e2 --e1 ed e2 sono espressioni di tipo Expr, quindi bisogna chiamare eval su di loro per ottenere i valori numerici
eval (App Mul e1 e2) = eval e1 * eval e2



{-
--ESERCIZIO 3
Qual è il tipo della funzione twice definita nel seguente modo
twice f x = f (f x)

twice :: (a -> a) -> a -> a ((input)->input->output)

-}



--PROLOG
{-
ESERCIZIO 1
%Data una lista L1 e un numero intero N, scrivere un predicato Prolog 
%domanda1(L1,N,L2) che restituisca in L2 la lista
%degli elementi di L1 che sono liste contenenti solo due valori interi
% positivi fra 1 e 9 la cui somma valga N.
%Esempio:
%:- domanda1([[3,1],5,[2,1,1],[3],[1,1,1],a, [2,2]],4,L2).
%yes, L2 = [[3,1], [2,2]]

% Caso base: lista vuota
domanda1([], _, []).

% Caso ricorsivo: l'elemento corrente soddisfa i criteri
domanda1([H|T], N, [H|L2]) :-
    is_list(H),          % Verifica che H sia una lista
    contieneDue(H),      % Controlla che la lunghezza della lista sia 2
    sommaUguale(H, N),   % Controlla che la somma dei due elementi valga N
    domanda1(T, N, L2).

% Caso ricorsivo: l'elemento corrente non soddisfa i criteri
domanda1([_|T], N, L2) :-
    domanda1(T, N, L2).

% Verifica che una lista abbia esattamente due elementi
contieneDue(L) :-
    length(L, 2).

% Verifica che la somma dei due elementi sia uguale a N e che siano interi positivi tra 1 e 9
sommaUguale([H1, H2], N) :-
    integer(H1), H1 > 0, H1 =< 9,
    integer(H2), H2 > 0, H2 =< 9,
    N is H1 + H2.




--ESERCIZIO2
%Si considerino i seguenti predicati
%studente(nome, cognome, matricola)
%esame(idcorso, matricola, voto)
%corso(idcorso, nome)
%si definiscano il seguente predicato prolog:
%media(matricola, valore) # che restituisce vero se la media 
%degli esami sostenuti dallo studente avente come matricola il
%primo termine è uguale a valore (si assuma che ogni corso sia
% caratterizzato dallo stesso numero di crediti)

% Predicato principale
media(Matricola, Valore) :-
    findall(Voto, esame(_, Matricola, Voto), Voti),  % Ottieni tutti i voti dello studente
    calcola_media(Voti, Valore).                    % Calcola la media dei voti

% Calcola la media di una lista di numeri
calcola_media(Voti, Media) :-
    somma_voti(Voti, Somma),                        % Somma tutti i voti
    length(Voti, NumeroEsami),                      % Conta il numero di voti (esami)
    NumeroEsami > 0,                                % Verifica che ci siano esami (evita divisione per 0)
    Media is Somma / NumeroEsami.                   % Calcola la media

% Somma i voti di una lista
somma_voti([], 0).                                  % Caso base: somma di una lista vuota è 0
somma_voti([H|T], Somma) :-
    somma_voti(T , SommaRestante),                   % Ricorsivamente somma il resto della lista
    Somma is H + SommaRestante.                     % Aggiungi il voto corrente


% Fatti per studente
studente('Mario', 'Rossi', 12345).
studente('Giulia', 'Bianchi', 67890).

% Fatti per esami sostenuti
esame(1, 12345, 28).
esame(2, 12345, 30).
esame(3, 12345, 26).

esame(1, 67890, 24).
esame(2, 67890, 25).
-}