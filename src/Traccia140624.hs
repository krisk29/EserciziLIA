--Haskell


--Esercizio 1
--Definire una funzione removeElementsByValues che prende in input due liste di interi: values e filters e  
--restituisce una nuova lista contenente solo gli elementi di values che non appaiono nella lista filters  
--nell'ordine in cui appaiono nella lista values. 
removeElementsByValues :: [Int] -> [Int] -> [Int]
removeElementsByValues [] _ = []
removeElementsByValues xs ys = [x | x<-xs, x `notElem` ys]
--removeElementsByValues xs ys = [x | x <- xs, and [x /= y | y <- ys]]
--removeElementsByValues xs ys = [x | x <- xs, all (/= x) ys]


--Esercizio 2
--Scrivere una funzione sumOflists che riceve in input una lista di liste di numeri l e restituisce una lista di numeri l1 
--tale che ogni elemento in posizione i-esima di l1 corrisponda alla somma degli elementi nella lista in posisione i-esima di l
sumOflists :: Num a => [[a]] -> [a]
sumOflists [] = []  -- Caso base: lista di liste vuota
sumOflists (x:xs) = mySum x (sumOflists xs)  -- Somma la lista corrente con il risultato ricorsivo

mySum :: Num a => [a] -> [a] -> [a]
mySum [] [] = []  -- Caso base: quando entrambe le liste sono vuote
mySum (x:xs) [] = x : mySum xs []  -- Caso: una lista è vuota, mantieni gli altri elementi
mySum [] (y:ys) = y : mySum [] ys  -- Caso: l'altra lista è vuota, mantieni gli altri elementi
mySum (x:xs) (y:ys) = (x + y) : mySum xs ys  -- Somma gli elementi corrispondenti


--Esercizio 3
{-
Qual'è il tipo dell'espressione seguente?
map (+1)
Motivare la risposta.
map (+1):: Num a => [a] -> [a]
-}



--PROLOG
{-
ESERCIZIO 1

%mia soluzione NON FUNZIONANTE
subsequences(L1, L2).
subsequences(L1,[]).
subsequences(L1,[X|L2]):-member(X,L1),subsequences(L1,L2).
/*
 Qui stai cercando di controllare se ogni elemento di L2 è membro di L1, ma questo controllo non garantisce che gli elementi di L2 appaiano in ordine rispetto a L1. La funzione member/2 verifica solo se un elemento esiste in una lista, non tiene conto dell'ordine. Questo è il motivo per cui la tua definizione non funziona correttamente per verificare che L2 sia una sottosequenza di L1.

Variabili singleton: Quando Prolog dice "Singleton variables: [L1]", significa che hai dichiarato una variabile (L1 in questo caso) ma non l'hai mai utilizzata nel corpo della clausola. Ad esempio, nella prima regola:
 * */



%soluzione di chat FUNZIONANTE
% Caso base: una lista vuota è sempre una sottosequenza di qualsiasi lista.
subsequences2(_, []).

% Caso ricorsivo: se il primo elemento di L1 è uguale al primo elemento di L2,
% prosegui con il resto di entrambe le liste.
subsequences2([H|T1], [H|T2]) :- subsequences2(T1, T2).

% Caso ricorsivo: se il primo elemento di L1 non è uguale al primo elemento di L2,
% salta il primo elemento di L1 e verifica con la stessa L2.
subsequences2([_|T1], L2) :- subsequences2(T1, L2).

%soluzione di claude FUNZIONANTE e forse anche migliore nella modalità +,-
% subsequences(+L1, +L2)
% Vero se L2 è una sottosequenza di L1
subsequences([], []).
subsequences([_|T], L2) :-
    subsequences(T, L2).
subsequences([H|T], [H|T2]) :-
    subsequences(T, T2).

spiegazione:
Il caso base: subsequences([], []) - una lista vuota è sottosequenza solo di una lista vuota
Caso ricorsivo 1: subsequences([_|T], L2) :- subsequences(T, L2)

Questo caso gestisce la situazione in cui decidiamo di "saltare" l'elemento corrente
Il _ indica che non ci interessa il valore dell'elemento che stiamo saltando


Caso ricorsivo 2: subsequences([H|T], [H|T2]) :- subsequences(T, T2)

Questo caso gestisce la situazione in cui decidiamo di mantenere l'elemento corrente
H viene mantenuto in entrambe le liste



Il predicato funziona in entrambe le modalità (+,+) e (+,-):

Modalità (+,+): verifica se L2 è una sottosequenza di L1
Modalità (+,-): genera tutte le possibili sottosequenze di L1


soluzione file FUNZIONANTE ma brutta
subsequences(L1,L1).
subsequences(L1,[]).
subsequences([T1|C1], [T1|C2]):- subsequences(C1,C2).                                                          
subsequences([T1|C1], [T2|C2]:-  subsequences(C1, [_|C2]).









ESERCIZIO 2

/*
 * subsequences([T1|C1], [T2|C2]:-  subsequences(C1, [_|C2]).

Supponendo di avere una base di fatti per i seguenti predicati: persona/2, 
amico/2, maschio/1, femmina/1, dove persona contenga come primo termine
il nome della persona e come secondo la sua età
Si definiscano i predicati seguenti:
 * */

%soloamicifemmine(X): vero se e solo X ha solamente amici di sesso femminile 
%(nel caso X non abbia amici il predicato è vero)
% 1. soloamicifemmine(X): vero se X ha solo amici femmine
soloamicifemmine(X) :-
    % Se X ha almeno un amico maschio, fallisce
    \+ (amico(X, Amico), maschio(Amico)).

%amicistessaeta(X): vero se e solo tutti almeno una coppia 
%di amici di X hanno la medesima età
amicistessaeta(X) :-
    amico(X, Amico1),
    amico(X, Amico2),
    Amico1 \= Amico2,
    persona(Amico1, Eta),
    persona(Amico2, Eta).

%stessiamici(X,Y): vero se e solo se X e Y hanno degli insiemi di amici AX e AY
% tali che AX e AY coincidono
stessiamici(X, Y) :-
    \+ ((amico(X, Amico), \+ amico(Y, Amico))),  % ogni amico di X è amico di Y
    \+ ((amico(Y, Amico), \+ amico(X, Amico))).  % ogni amico di Y è amico di X

% 3. stessiamici(X,Y): vero se X e Y hanno gli stessi amici - versione con findall
stessiamici2(X, Y) :-
    findall(Amico, amico(X, Amico), AmiciX),
    findall(Amico, amico(Y, Amico), AmiciY),
    sort(AmiciX, AmiciXOrdinati),    % sort rimuove anche i duplicati
    sort(AmiciY, AmiciYOrdinati),
    AmiciXOrdinati == AmiciYOrdinati.

% Persone e la loro età.
persona(anna, 25).
persona(luca, 25).
persona(marta, 30).
persona(paolo, 25).

% Maschi e femmine.
maschio(luca).
maschio(paolo).
femmina(anna).
femmina(marta).

% Amicizie.
amico(luca, marta).
amico(luca, anna).
amico(paolo, marta).
amico(paolo, anna).

-}
