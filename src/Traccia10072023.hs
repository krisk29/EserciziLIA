--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input due liste di numeri xs e ys restituisce il prodotto scalare di xs e
--ys. Qualora xs e ys abbiano lunghezze diverse si consideri solo la porzione della lista più lunga fino alla lunghezza della
--lista più corta. Se una delle due liste è vuota il prodotto è 0.
scalarProduct :: Num a => [a] -> [a] -> a
scalarProduct [] [] = 0
scalarProduct (x:xs) (y:ys)
    | length (x:xs) > length (y:ys) = scalarProduct (take (length (y:ys)) (x:xs)) (y:ys)        
    | length (x:xs) < length (y:ys) = scalarProduct (x:xs) (take (length (x:xs)) (y:ys))
    |otherwise = (x*y)+(scalarProduct xs ys)           



--ESERCIZIO 2
--Scrivi una funzione chiamata listaPalindroma che prenda in input una lista di elementi e restituisca True se la lista è
--palindroma, ossia se può essere letta nello stesso modo da sinistra a destra e da destra a sinistra. Altrimenti, restituisca False.
listaPalindroma :: Eq a => [a] -> Bool
listaPalindroma [] = True
listaPalindroma xs = xs == (reverse xs) 



--ESERCIZIO 3
{-
Qual è il tipo dell’espressione definita nel seguente modo
map map
si ricorda che il tipo della funzione map è:
map :: (a -> b) -> [a] -> [b]

((a -> b) -> [a] -> [b]) -> c -> [a] -> [c] 

chatgpt: map map :: (a -> [b]) -> [[b]]

claude: map map :: ((a -> b) -> [a] -> [b]) -> [[(a -> b)]] -> [[b]]

la cosa giusta è: ghci> :type map map                         
map map :: [a -> b] -> [[a] -> [b]]

-}




--PROLOG
{-
--ESERCIZIO 1 FUNZIONANTE
%Definire il predicato filtrapari(ListaIn, ListaOut) che,
% presa una lista di numeri, ListaIn, restituisce la lista composta
%dagli elementi di ListaIn il cui valore è pari.
%Esempio: filtrapari ( [4, 6, 7, 5],ListaOut) deve unificare ListaOut con [4,6].
filtrapari([], []).
filtrapari([H|T], [H|ListaOut]) :-  % se H è pari, lo includiamo nella lista risultato
    0 is H mod 2,                   % verifica se H è pari. Posso anche usare H mod 2 =:= 0
    filtrapari(T, ListaOut).
filtrapari([H|T], ListaOut) :-      % se H è dispari, lo saltiamo
    1 is H mod 2,                   % verifica se H è dispari. Posso anche usare H mod 2 =\= 0
    filtrapari(T, ListaOut).



--ESERCIZIO 2
%Si considerino i seguenti predicati
%Prodotto(id, nome, prezzo)
%Ordine(id, data)
%Dettordine(idprodotto, idordine, qta)
%si definiscano il seguenti predicato prolog:
%ordineeconomico(idordine) che restituisce vero se e solo 
%se l’ordine con id idordine contiene solo prodotti il cui prezzo
%è minore o uguale a 10
%OrdiniUguali(a,b) che restituisce vero se e solo se
% l’ordine con id a contiene esattamente gli stessi prodotti dell’ordine
%con id b (anche la quantità ordinata deve essere uguale).
ordineeconomico(IdOrdine) :-
    findall(P, 
            (dettordine(IDP, IdOrdine, _),  % per ogni prodotto nell'ordine
             prodotto(IDP, _, P)),          % prendi il suo prezzo
            Prezzi),                        % metti tutti i prezzi in una lista
    max_list(Prezzi, Max),                 % trova il prezzo massimo
    Max =< 10.                             % verifica che sia <= 10

ordiniuguali(A, B) :-
    ordine(A, _),    % verifica che A sia un ordine valido
    ordine(B, _),    % verifica che B sia un ordine valido
    findall(prod(IDP, Q), 
            dettordine(IDP, A, Q),  % raccoglie prodotti e quantità dell'ordine A
            L1),
    findall(prod(IDP, Q), 
            dettordine(IDP, B, Q),  % raccoglie prodotti e quantità dell'ordine B
            L2),
    sort(L1, L1Ord),    % ordina le liste per garantire un confronto corretto
    sort(L2, L2Ord),
    L1Ord == L2Ord.     % confronta le liste ordinate




prodotto(1, 'penna', 5).
prodotto(2, 'quaderno', 8).
prodotto(3, 'zaino', 25).
prodotto(4, 'matita', 2).

% Se hai questi dati:
ordine(1, '2024-01-15').
ordine(2, '2024-01-16').
dettordine(1, 1, 2).  % 2 unità del prodotto 1 nell'ordine 1
dettordine(2, 1, 3).  % 3 unità del prodotto 2 nell'ordine 1
dettordine(1, 2, 2).  % 2 unità del prodotto 1 nell'ordine 2
dettordine(2, 2, 3).  % 3 unità del prodotto 2 nell'ordine 2
-}