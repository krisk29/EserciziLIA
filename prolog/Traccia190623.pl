/*
Definire il predicato filtramultipli(N, ListaIn, ListaOut) che, presa una lista di numeri, ListaIn, restituisce la lista 
composta dagli elementi di ListaIn il cui valore è multiplo di N. 
 
Esempio: filtramultipli (3, [4, 6, 7, 5],ListaOut) deve unificare ListaOut con [4,7,5].
*/
filtramultipli(_,[],[]).
filtramultipli(N,[H|T],[H|ListaOut]):- H mod N =:= 0, filtramultipli(N,T,ListaOut).
filtramultipli(N,[H|T],ListaOut):- H mod N =\= 0, filtramultipli(N,T,ListaOut).


/*
Si considerino i seguenti predicati 
 
rally(nome) 
vincitore(nomepilota, nomerally, data) 
pilota(nome) 
 
si definiscano il seguenti predicato prolog: 
numvincitoridiversi(rally, valore)   # che restituisce vero se il rally rally è stato into da valore piloti diversi nell’arco 
della storia 
piupilotidiversi(rally)   # che restituisce vero se il rally rally è stato vinto da più piloti diversi nella storia 
*/
numvincitoridiversi(Rally, Valore) :-
    rally(Rally),  % Controlla che il nome del rally sia valido
    setof(Pilota, Data^vincitore(Pilota, Rally, Data), ListaPiloti), % Trova i piloti distinti che hanno vinto il rally
    length(ListaPiloti, Valore). % Conta il numero di piloti distinti

piupilotidiversi(RallyMax) :-
    findall((Rally, NumPiloti), 
        (rally(Rally), 
         setof(Pilota, Data^vincitore(Pilota, Rally, Data), ListaPiloti), 
         length(ListaPiloti, NumPiloti)), 
        ListaRally), % Ottieni una lista di coppie (Rally, Numero di piloti distinti)
    massimo_piloti(ListaRally, (RallyMax, _)). % Trova il rally con il massimo numero di piloti

massimo_piloti([(Rally, NumPiloti)], (Rally, NumPiloti)). % Caso base: un solo elemento nella lista
massimo_piloti([(Rally1, Num1), (Rally2, Num2) | T], Max) :-
    ( Num1 >= Num2 -> 
        massimo_piloti([(Rally1, Num1) | T], Max) % Mantieni il primo come massimo temporaneo
    ; 
        massimo_piloti([(Rally2, Num2) | T], Max) % Cambia il massimo temporaneo
    ).

