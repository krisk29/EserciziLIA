/*
Definire il predicato filtrapari(ListaIn, ListaOut) che, presa una lista di numeri, ListaIn, restituisce la lista composta 
dagli elementi di ListaIn il cui valore è pari. 
 
Esempio: filtrapari ( [4, 6, 7, 5],ListaOut) deve unificare ListaOut con [4,6]. 
*/
filtrapari([], []). % Caso base: una lista vuota restituisce una lista vuota.
filtrapari([H|T], [H|ListaOut]) :-
    H mod 2 =:= 0, % Verifica che H sia pari.
    filtrapari(T, ListaOut). % Continua con il resto della lista.
filtrapari([_|T], ListaOut) :-
    filtrapari(T, ListaOut). % Salta l'elemento dispari e continua con il resto della lista.

/*
Si considerino i seguenti predicati 
 
Prodotto(id, nome, prezzo) 
Ordine(id, data) 
Dettordine(idprodotto, idordine, qta) 
 
si definiscano il seguenti predicato prolog: 
ordineeconomico(idordine) che restituisce vero se e solo se l’ordine con id idordine contiene solo prodotti il cui prezzo 
è minore o uguale a 10 
OrdiniUguali(a,b) che restituisce vero se e solo se l’ordine con id a contiene esattamente gli stessi prodotti dell’ordine 
con id b (anche la quantità ordinata deve essere uguale).
*/
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
