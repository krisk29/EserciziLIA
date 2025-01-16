/*
Definire il predicato posizionen(N, ListaIn, ListaOut) che, presa una lista di elementi ground, ListaIn, restituisce la lista 
composta dagli elementi di ListaIn che si trovano in posizione multipla di N (assumiamo che il primo elemento di una 
lista occupi la posizione 1). 
 
Esempio: posizionen(3, [a, b(c), 7, [1,2,3], pippo, pluto, paperino],ListaOut) deve unificare ListaOut con [7, pluto].
*/

posizionen(_,[],[]).
posizionen(N,ListaIn,ListaOut):- helper(N,ListaIn,ListaOut,1).

helper(_,[],[],_).

helper(N,[H|T],[H|ListaOut],Inde):-
    Inde mod N =:= 0, 
    NewIndex is Inde+1,
    helper(N,T,ListaOut,NewIndex).

helper(N,[_|T],ListaOut,Inde):-
    Inde mod N =\= 0, 
    NewIndex is Inde+1,
    helper(N,T,ListaOut,NewIndex).

/*
Si considerino i seguenti predicati 
 
rally(nome) 
vincitore(nomepilota, nomerally, data) 
pilota(nome) 
 
si definisca il seguente predicato prolog: 
rallyvinti(nomepilota, valore)  # che restituisce vero se nomepilota ha vinto valore rally 
piubravo(nomepilota)   # che restituisce vero se nomepilota ha vinto il maggior numero di rally 
piùcontinuo(nomepilota)    # che restituisce vero se nomepilota ha vinto il maggior numero di rally consecutivi
*/
rallyvinti(Nome,Valore):-
    findall(Nome,(pilota(Nome),vincitore(Nome,_,_)),ListaVincite),
    length(ListaVincite,Valore).

% Predicato piubravo (non c'è pilota che ha vinto più di quello selezionato)
piubravo(NomePilota):-
    rallyvinti(NomePilota, VittoriePilota),    % Trova quanti rally ha vinto il pilota
    \+ (pilota(AltroPilota),                   % Verifica che non esista un altro pilota
        AltroPilota \= NomePilota,             % diverso da NomePilota
        rallyvinti(AltroPilota, VittorieAltro),% con un numero di vittorie
        VittorieAltro > VittoriePilota).       % maggiore

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
    
    



    