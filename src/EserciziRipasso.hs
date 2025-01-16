--Traccia 14-06-2024
--Esercizio 1
--Definire una funzione removeElementsByValues che prende in input due liste di interi: values e filters e  
--restituisce una nuova lista contenente solo gli elementi di values che non appaiono nella lista filters  
--nell'ordine in cui appaiono nella lista values. 
removeElementsByValues :: [Int] -> [Int] -> [Int]
removeElementsByValues xs [] = xs
removeElementsByValues [] _ = []
removeElementsByValues xs ys = [x | x<-xs, x `notElem` ys]

--Esercizio 2
--Scrivere una funzione sumOflists che riceve in input una lista di liste di numeri l e restituisce una lista di numeri l1 
--tale che ogni elemento in posizione i-esima di l1 corrisponda alla somma degli elementi nella lista in posisione i-esima di l
sumOflists :: [[Int]] -> [Int]
sumOflists [] = []
sumOflists (x:xs) = (sum x):(sumOflists xs)  

--Esercizio 3
{-
Qual'è il tipo dell'espressione seguente?
map (+1)
mia sol: (a->b)->[a]->[b] in realtà questo è solo di map

ghci> :type map (+1)
map (+1) :: Num b => [b] -> [b]
-}


--Traccia 06-02-2023
--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input un intero x e una lista di interi xs restituisce la lista degli
--interi in xs diversi da x mantenendo però la prima occorrenza di x (elimina quindi da xs le ripetizioni di x). L’ordine di
--apparizione degli interi deve essere mantenuto.
elimOccSucc :: Int -> [Int] -> [Int]
elimOccSucc _ [] = []
elimOccSucc v (x:xs) = if v==x then x:[l | l<-xs, l/=x] else x:(elimOccSucc v xs)

--ESERCIZIO 2
--Definire la funzione
--estraisottoliste :: Int-> [Int] → [[Int]] che ricevendo in input un intero k e una lista 
--di interi xs restituisce una lista contenente tutte le sottoliste contigue di xs di lunghezza k
estraisottoliste :: Int-> [Int] -> [[Int]]
estraisottoliste _ [] = []
estraisottoliste k (x:xs) = if (length (x:xs)) >= k then [take k (x:xs)]++(estraisottoliste k xs) else []

--Esercizio 3
{-
Qual'è il tipo dell'espressione seguente?
map (+1)
ghci> :type map (+1)
map (+1) :: Num b => [b] -> [b]
-}


--Traccia 10-07-2023
--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input due liste di numeri xs e ys restituisce il prodotto scalare di xs e
--ys. Qualora xs e ys abbiano lunghezze diverse si consideri solo la porzione della lista più lunga fino alla lunghezza della
--lista più corta. Se una delle due liste è vuota il prodotto è 0.
prodScal :: [Int]->[Int]->Int
prodScal [] _ = 0
prodScal _ [] = 0
prodScal (x:xs) (y:ys)
    | (length (x:xs)) > (length (y:ys)) = prodScal (take (length (y:ys)) (x:xs)) (y:ys)
    | (length (y:ys)) > (length (x:xs)) = prodScal (x:xs) (take (length (x:xs)) (y:ys)) 
    | otherwise = x*y+(prodScal xs ys)

--ESERCIZIO 2
--Scrivi una funzione chiamata listaPalindroma che prenda in input una lista di elementi e restituisca True se la lista è
--palindroma, ossia se può essere letta nello stesso modo da sinistra a destra e da destra a sinistra. Altrimenti, restituisca False.
palindroma :: Eq a => [a] -> Bool
palindroma xs = xs == (reverse xs)

--ESERCIZIO 3
{-
Qual è il tipo dell’espressione definita nel seguente modo
map map
si ricorda che il tipo della funzione map è:
map :: (a -> b) -> [a] -> [b]
ghci> :type map map                         
map map :: [a -> b] -> [[a] -> [b]]
-}


--Traccia 13-01-2023
--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input un intero x e una lista di interi xs restituisce la lista degli
--interi in xs che sono più piccoli di x
smaller :: Int -> [Int] -> [Int]
smaller _ [] = []
smaller x xs = [y | y<-xs, y<x]

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
eval (Val x) = x
eval (App Add e1 e2) = eval e1 + eval e2
eval (App Mul e1 e2) = eval e1 * eval e2

{-
--ESERCIZIO 3
Qual è il tipo della funzione twice definita nel seguente modo
twice f x = f (f x)
mia sol: twice :: (a->b)->c->d  ((input)->input->output)
-}


--Traccia 14-01-2023
--ESERCIZIO 1
--Si scriva la definizione di una funzione che prese in input due liste di interi xs e ys di uguale lunghezza restituisce la
--lista degli interi in zs contenente la somma degli interi in posizione corrispondente di xs e ys
sommaliste :: [Int]->[Int]->[Int]
sommaliste _ [] = []
sommaliste [] _ = []
sommaliste (x:xs) (y:ys)
    | (length (x:xs)) > (length (y:ys)) = sommaliste (take (length (y:ys)) (x:xs)) (y:ys)
    | (length (y:ys)) > (length (x:xs)) = sommaliste (x:xs) (take (length (x:xs)) (y:ys)) 
    | otherwise = (x+y):(sommaliste xs ys)

--altra versione, il controllo sulla lunghezza lo fa in automatico, non ha bisogno di tutti quegli if
sumlist :: [Int] -> [Int] -> [Int]
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
{-
data Expr = Val Bool | App Op Expr Expr
data Op = And | Or | Not

eval :: Expr -> Bool
eval (Val b) = b
eval (App And e1 e2) = eval e1 && eval e2
eval (App Or e1 e2)  = eval e1 || eval e2
eval (App Not e1 _)  = not (eval e1)  
eval (App Not _ e2)  = not (eval e2)  
-} --funziona ma lo tengo commentato perchè c'è l'altra funzione con lo stesso nome

--ESERCIZIO 3
{-
Qual è il tipo dell’espressione:
filter (\y -> mod y 2 ==0)

filter :: (a -> Bool) -> [a] -> [a]
-}


--Traccia 19-06-2023
--ESERCIZIO 1
--Si scriva la definizione di una funzione che presi in input un intero x e una lista di interi xs restituisce la lista degli interi
--in xs che non sono multipli x. L’ordine di apparizione degli interi deve essere mantenuto.
nonmul :: Int -> [Int] -> [Int]
nonmul _ [] = []
nonmul x xs = [y | y<-xs, mod y x /= 0]

--ESERCIZIO 2
--Definire la funzione
--estraisottoliste :: Int-> [Int] → [[Int]]
--che ricevendo in input un intero k e una lista di interi xs restituisce una lista contenente tutte le sottoliste contigue di xs
--di lunghezza maggiore di 0 e minore o uguale a k. Le sottoliste devono apparire in ordine crescente di lunghezza e poi
--di apparizione nella lista in ingresso
--esempio: estraisottoliste 2 [1, 2, 3] è uguale a [[1],[2],[3],[1, 2], [2, 3]]
estraisublist :: Int -> [Int] -> [[Int]]
estraisublist k xs = [take len (drop i xs) | 
                        len <- [1..k],
                        i <- [0..length xs - len]]

--ESERCIZIO 3
{-
Qual è il tipo dell’espressione definita nel seguente modo
filter (==1)

filter :: (a->Bool)->[a]->[a]

ghci> :type filter (==1)
filter (==1) :: (Eq a, Num a) => [a] -> [a]

-}