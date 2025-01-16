--Definire una funzione mcm che riceva in input due numeri interi x e y e restituisca il minimo comune multiplo di x e y

mcm :: Integer -> Integer -> Integer
mcm x y = (x * y) `div` (mcd x y)

-- Definire una funzione mcd che riceva in input due numeri interi x e y e restituisca il massimo comune divisore di x e y (ho utilizzato l'algoritmo di euclide)
mcd :: Integer -> Integer -> Integer
mcd x y | x == 0 = y
        | y == 0 = x
        | x > y = mcd (x `mod` y) y
        | otherwise = mcd x (y `mod` x)

--Definire una funzione che riceva in input una lista di numeri xs e restituisca il numero di valori maggiori di zero che appaiono in xs
valoriMaggioriDiZero :: [Integer] -> Integer
valoriMaggioriDiZero [] = 0
valoriMaggioriDiZero (x:xs) = if x>0 then 1+valoriMaggioriDiZero(xs) else valoriMaggioriDiZero(xs)

--list comprehension
valoriMaggioriDiZero' :: [Int] -> Int
valoriMaggioriDiZero' xs = length [x | x<-xs, x>0]

--Definire una funzione che riceva in input un numero x e una lista di numeri xs e restituisca la somma dei valori 
--che appaiono nella lista e che sono minori di x
sommaMinoriXLista :: Integer -> [Integer] -> Integer
sommaMinoriXLista _ [] = 0
sommaMinoriXLista x (y:ys) = if y < x then y + sommaMinoriXLista x ys else sommaMinoriXLista x ys

--con guardie
sommaMinoriXLista' :: Integer -> [Integer] -> Integer
sommaMinoriXLista' _ [] = 0
sommaMinoriXLista' x (y:ys)
    | y < x     = y + sommaMinoriXLista' x ys
    | otherwise = sommaMinoriXLista' x ys

--list comprehension
sommaMinoriXLista'' :: Integer -> [Integer] -> Integer
sommaMinoriXLista'' x ys = sum [y | y <- ys, y < x] --ys è la lista da girare e per ogni valore controlla se y è minore, restituisce direttamente una lista questa modalità, perciò quell'y all'inizio sono i suoi valori. È come avere un for in y<-ys


--definire una funzione prodscal che riceve in ingresso due liste xs e ys di uguale dimensione e ne calcola il prodotto scalare
prodscal :: [Integer] -> [Integer] -> Integer
prodscal [] [] = 0
prodscal (x : xs) (y : ys) = x * y + prodscal xs ys

--definire una funzione che riceva in ingresso due liste e restituisca true se ys appare come sottolista contigua di xs
isSubList :: Eq a => [a] -> [a] -> Bool
isSubList _ [] = True
isSubList [] _ = False
isSubList xs ys = if take (length ys) xs == ys then True else isSubList (tail xs) ys  

--definire una funzione che riceve in ingresso due liste xs e ys e restituisce il numero di volte che ys appare come sottolista di xs
numIsSubList :: Eq a => [a] -> [a] -> Integer
numIsSubList _ [] = 0
numIsSubList [] _ = 0
numIsSubList xs ys = if take (length ys) xs == ys then 1 + numIsSubList (drop (length ys) xs) ys else numIsSubList (tail xs) ys

--definire una funzione che prenda in ingresso una lista xs e restituisca una lista contenente tutte le sottoliste contigue estraibili da xs, in qualunque ordine
everySubListContigue :: Eq a => [a] -> [[a]]
everySubListContigue [] = [[]] 
everySubListContigue xs = [take n xs | n <- [1..length xs]] ++ everySubListContigue (tail xs) -- prendi da 1 a n elementi da xs e poi chiama la funzione ricorsivamente con la coda di xs
--prima ti prendi il primo, poi il primo e il secondo, poi primo secondo e terzo ecc + richiamo ricorsivo sulla coda

-- definire una funzione che riceva in ingresso una lista xs e restituisca una lista contenente tutte le sottoliste (anche non contigue) estraibili da xs (in qualunque ordine) 
subLists :: Eq a => [a] -> [[a]]
subLists [] = [[]]
subLists (x:xs) =  [x:sc | sc <- subLists xs] ++ subLists xs 

