--ESERCIZIO 1
--Si scriva la definizione di una funzione che prese in input due liste di interi xs e ys di uguale lunghezza restituisce la
--lista degli interi in zs contenente la somma degli interi in posizione corrispondente di xs e ys
sumlist:: [Int] -> [Int] -> [Int]
sumlist _ [] = []
sumlist [] _ = []
sumlist (x:xs) (y:ys) = (x+y):(sumlist xs ys) 



--ESERCIZIO 2
--Si consideri il tipo di dati
--data Expr = Val Bool | App Op Expr Expr
--data Op = And | Or | Not
--Si definisca la funzione
--eval :: Expr -> Bool
--che restisca il valore Bool derivante dalla valutazione dell’espressione
data Expr = Val Bool | App Op Expr Expr
data Op = And | Or | Not

eval :: Expr -> Bool
eval (Val b) = b
eval (App And e1 e2) = eval e1 && eval e2
eval (App Or e1 e2)  = eval e1 || eval e2
eval (App Not e1 _)  = not (eval e1)  
eval (App Not _ e2)  = not (eval e2)  



--ESERCIZIO 3
{-
Qual è il tipo dell’espressione:
filter (\y -> mod y 2 ==0)

filter :: (a -> Bool) -> [a] -> [a]

(a -> Bool) è dato dall'espressione booleana == , il primo [a] è dove si applica la lambda, quindi il secondo [a] è l'output
\y -> mod y 2 == 0 :: Integral a => a -> Bool 
il filter di base funziona che prendi una funzione, una lista e poi restituisci una lista -> filter:: (a -> Bool) -> [a] -> [a]


filter va visto non come una funzione definita ma come una di prelude
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
    contieneTre(H),      % Controlla che la lunghezza della lista sia 2
    sommaUguale(H, N),   % Controlla che la somma dei due elementi valga N
    domanda1(T, N, L2).

% Caso ricorsivo: l'elemento corrente non soddisfa i criteri
domanda1([_|T], N, L2) :-
    domanda1(T, N, L2).

% Verifica che una lista abbia esattamente due elementi
contieneTre(L) :-
    length(L, 3).

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
%studentebravo(X) che restituisce vero se X ha fatto gli esami di tutti i corsi
%devo trasformarlo in x ha almeno un esame che non ha fatto, almeno uno basta l'and
% quindi devo controllare se c'è l'esame non dato da X
studentebravo(X) :-
    studente(_, _, X),  % Verifica che X sia una matricola valida
    \+ (
        corso(IdCorso, _),  % Prende un corso qualsiasi
        \+ esame(IdCorso, X, _)  % Verifica che NON esista un esame non fatto
    ). %significa NON ESISTE UN CORSO DI CUI NON HA FATTO ESAME

/* Spiegazione del funzionamento:
1. studente(_, _, X) verifica che X sia una matricola valida
2. \+ (...) è la negazione
3. corso(IdCorso, _) trova un corso
4. \+ esame(IdCorso, X, _) verifica se NON esiste l'esame per quel corso
5. La doppia negazione (\+ \+) equivale a verificare che lo studente 
   abbia fatto TUTTI gli esami */


studente(mario, rossi, m123).
studente(luigi, verdi, m456).
corso(c1, matematica).
corso(c2, fisica).
esame(c1, m123, 28).
esame(c2, m123, 30).
esame(c1, m456, 25).
-}