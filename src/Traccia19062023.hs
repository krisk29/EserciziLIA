--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input un intero x e una lista di interi xs restituisce la lista degli interi
--in xs che non sono multipli x. L’ordine di apparizione degli interi deve essere mantenuto.
deleteMul:: Int-> [Int] -> [Int]
deleteMul _ [] = []
deleteMul n xs = [x | x<-xs, mod x n /= 0]   



--ESERCIZIO 2
--Definire la funzione
--estraisottoliste :: Int-> [Int] → [[Int]]
--che ricevendo in input un intero k e una lista di interi xs restituisce una lista contenente tutte le sottoliste contigue di xs
--di lunghezza maggiore di 0 e minore o uguale a k. Le sottoliste devono apparire in ordine crescente di lunghezza e poi
--di apparizione nella lista in ingresso
--esempio: estraisottoliste 2 [1, 2, 3] è uguale a [[1],[2],[3],[1, 2], [2, 3]]
estraisottoliste :: Int -> [Int] -> [[Int]]
estraisottoliste _ [] = []
estraisottoliste k xs = concatMap (\l -> sottolisteDiLunghezza l xs) [1..k]

sottolisteDiLunghezza :: Int -> [Int] -> [[Int]]
sottolisteDiLunghezza l xs
  | l > length xs = []
  | otherwise = [take l (drop i xs) | i <- [0..(length xs - l)]]



--ESERCIZIO 3
{-
Qual è il tipo dell’espressione definita nel seguente modo
filter (==1)

filter (==1) :: (Eq a, Num a) => [a] -> [a]
-}



--PROLOG
{-
-ESERCIZIO1
%Definire il predicato filtramultipli(N, ListaIn, ListaOut) che,
% presa una lista di numeri, ListaIn, restituisce la lista
%composta dagli elementi di ListaIn il cui valore è multiplo di N.
%Esempio: filtramultipli (3, [4, 6, 7, 5],ListaOut) deve unificare ListaOut con [4,7,5].
filtramultipli(_,[],[]).
filtramultipli(N,[H|T],[H|ListaOut]):- H mod N =:= 0, filtramultipli(N,T,ListaOut).
filtramultipli(N,[H|T],ListaOut):- H mod N =\= 0, filtramultipli(N,T,ListaOut).


-}