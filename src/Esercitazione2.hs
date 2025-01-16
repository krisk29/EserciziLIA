module Esercitazione2 where

--ESERCIZIO 1
--Decide if all logical values in a list are true:
--ricorsiva
andR :: [Bool] -> Bool
andR [] = True
andR (x:xs) = x && andR xs

-- con foldr
andFoldr :: [Bool] -> Bool
andFoldr xs = foldr (&&) True xs

--si puo fare anche senza parametri
andFoldrNP :: [Bool] -> Bool
andFoldrNP = foldr (&&) True

--con if
andIF :: [Bool] -> Bool
andIF [] = True
andIF (x:xs) = if x==False then False else andIF xs    



--ESERCIZIO 2
--Concatenate a list of lists
concatLC :: [[a]] -> [a]
concatLC xs = [y | x <- xs, y <- x]

--con foldr
concatF :: [[a]] -> [a]
concatF = foldr (++) []

--ricorsiva
concatR :: [[a]] -> [a]
concatR [] = []
concatR (x:xs) = x ++ concatR xs



--ESERCIZIO 3
--Produce a list with n identical elements:
--ricorsiva (mia soluzione)
replicateR :: Int -> a -> [a]
replicateR 0 _ = []
replicateR num x = [x] ++ replicateR (num-1) x 

--ricorsiva 
replicateR2 :: Int -> a -> [a]
replicateR2 0 _ = []
replicateR2 num x = x : replicateR2 (num-1) x 

--list comprehension      --credo che il foldr non lo posso usare perchè non c'è una lista da scorrere come input
replicateLC :: Int -> a -> [a]
replicateLC n x = [x | y<-[1..n]] --anche se non viene usato y è tipo l'indice del for, quante volte viene usato



--ESERCIZIO 4
--Select the nth element of a list:
--(!!) :: [a] -> Int -> a    questo è quello base di prelude
nth :: [a] -> Int -> a
nth (x:xs) 0 = x
nth (x:xs) num = nth xs (num-1)


--ESERCIZIO 5:
--Decide if a value is an element of a list:
elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' y (x:xs) = if x==y then True else elem' y xs 



--ESERCIZIO 6:
-- merges two sorted lists of values to give a single sorted list
merge' :: Ord a => [a] -> [a] -> [a]
merge' [] ys = ys
merge' xs [] = xs
merge' (x:xs) (y:ys) = if x <= y then [x] ++ merge' xs (y:ys) else [y] ++ merge' (x:xs) ys
--merge' (x:xs) (y:ys) = if x <= y then x : merge' xs (y:ys) else y : merge' (x:xs) ys si può fare anche così
--prendo la testa di entrambe le liste e le controllo, se una è minore dell'altra la metto al risultato e ricontrollo 
--ricorsivamente passando i rimanenti, altrimenti se maggiore faccio la stessa cosa ma con l'altra testa



--ESERCIZIO 7:
-- Define a recursive function that implements merge sort, which can be specified by the following two rulse:
-- Lists of lenght <= 1 are already sorted
-- Other lists can be sorted by sorting the two halves and merging the resulting lists
msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x] --Lists of lenght <= 1 are already sorted
msort xs = merge' (msort (firstH xs)) (msort (secondH xs)) -- se non passo msort, non continua a dividerle, merge' prende in input due liste già ordinate
-- msort xs = merge' (firstH xs) (secondH xs) -> Il problema con la tua implementazione di msort sta nel fatto che non stai applicando msort ricorsivamente alle due metà (firstH e secondH) prima di passarle alla funzione merge'. Questo significa che stai semplicemente dividendo la lista in due metà e poi le stai "mescolando" (merge) senza che queste metà siano effettivamente ordinate.

firstH :: Ord a => [a] -> [a]
firstH [] = []
firstH xs = take (length xs `div` 2) xs

secondH :: Ord a => [a] -> [a]
secondH [] = []
secondH xs = drop (length xs `div` 2) xs