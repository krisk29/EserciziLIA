--NON SO SE CORRETTA, NON PROVATA

--esercizio 1
--Definire in Haskell una funzione che riceve una lista di liste di numeri  e restituisce una lista di tuple
-- in cui ogni tupla contiene la somma, il numero degli elementi e la media della corrispondente lista nella lista di liste in input
--convertiLista:: Int -> [[Num]] -> [(Num, Int, Num)]
--Esempio
--convertilista [[1,2,3],[4,5]] = [(6,3,2),(9,2,4.5)]
convertiLista:: [[Num]] -> [(Num, Int, Num)]
convertiLista [] = []
convertiLista [x:xs] = [ ( (sum x), (length x), ( (sum x)/(lengthx) ) ) ] ++ [convertiLista xs] 


--esercizio 2
--Definire una funzione haskell che ricevuta in input una lista di interi restituisce una lista di liste 
--contenente tutte le permutazioni della lista in input
--permutazioni:: [Int] ->[[Int]]
--permutazioni [1,2,3] = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
permutazioni:: [Int] ->[[Int]]
permutazioni [] = []
premutazioni xs = [y : zs | y <- xs, zs <- permutazioni (remove y xs)]

--definisco la remove
remove _ [] = []
remove e (x:xs) = if e == x then xs else x : remove e xs


--esercizio 2
{-
Qual'è il tipo della seguente espressione HAskell? Motivare la risposta.
(\f x -> f (f x))

(a->a)->a->a
questo perchè la funzione ha tipo (a->b) e x ha tipo a e questi due sono gli input. 
L'output invece ha come tipo a. Concatenando i tipo della lamda e expression, si ha il tipo che è quello sopraindicato 
-}

