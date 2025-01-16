module Operazioni where

somma :: Integer -> Integer -> Integer
somma x y = x + y

doppio :: Integer -> Integer
doppio x = x + x

quadruplo :: Integer -> Integer --non sono necessari per il funzionamento del programma in questi semplici
quadruplo x = doppio (doppio x)

-- pattern matching
fattoriale 0 = 1
fattoriale n = n * fattoriale (n - 1)

-- list comprehension
pari = [x | x <- [1..10], even x]
--credo siano la stessa cosa con i:
-- generatori dipendenti
concat :: [[a]] -> [a]
concat xss = [x | xs <- xss, x <- xs]  -- xs <- xss prende ogni lista interna in xss, x <- xs prende ogni elemento della lista xs

--generatori indipendenti con guardie
fattori :: Integer -> [Integer]
fattori n = [x | x <- [1..n], n `mod` x == 0] -- x <- [1..n] prende ogni x da 1 a n, n `mod` x == 0 controlla se x è un divisore di n

-- guardie
fattoriale' n | n == 0 = 1
              | n > 0 = n * fattoriale' (n - 1)

ePrimo :: Integer -> Bool
ePrimo n = fattori n == [1, n]

--zip 
paia :: [a] -> [(a,a)] --questo si riferisce a paia, ma zip funziona [a] -> [b] -> [(a,b)]
paia xs = zip xs (tail xs)  -- [(1,2),(2,3),(3,4)]

sorted :: Ord a => [a] -> Bool
sorted xs = and [x <= y | (x,y) <- paia xs] -- x <= y controlla se x è minore o uguale a y, and controlla se tutti gli elementi sono True

posizioni :: Eq a => a -> [a] -> [Integer]
posizioni x xs = [i | (x', i) <- zip xs [0..], x==x'] -- x' è l'elemento della lista xs, i è l'indice, zip xs [0..] crea una lista di coppie (elemento, indice)

-- le stringhe sono liste di caratteri
--conta :: Char -> String -> Integer
--conta x xs = length [x' | x' <- xs, x==x'] -- x' è l'elemento della lista xs, lenght conta il numero di elementi

--prodotto scalare (provare se funziona)
--prodottoScalare :: Num a => [a] -> [a] -> a
--prodottoScalare xs ys = somma [x*y | (x,y) <- zip xs ys] -- x*y moltiplica gli elementi delle due liste, sum somma tutti gli elementi

--reverse :: [a] -> [a]
--reverse (x:xs) = reverse xs ++ [x] -- x:xs prende il primo elemento e lo mette in coda, reverse xs chiama la funzione ricorsivamente 

--foldr
somma' :: Num a => [a] -> a
somma' xs = foldr (+) 0 xs -- foldr (+) 0 xs somma tutti gli elementi della lista xs