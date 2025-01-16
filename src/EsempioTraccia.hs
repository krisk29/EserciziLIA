--Esercizio 1
--Scrivere una funzione che calcola i il prodotto scalare di due liste di numeri. 

prodScal :: [Int] -> [Int] -> Int
prodScal [] _ = 0
prodScal _ [] = 0
prodScal (x:xs) (y:ys) = (x * y) + (prodScal xs ys) 

--Scrivere una funzione che costruisce, a partire da una lista di numeri, una lista di coppie in cui:
--1. il primo elemento di ogni coppia è uguale alla somma di tutti gli elementi che seguono nella lista originale e
--2. il secondo elemento di ogni coppia è uguale alla somma di tutti gli elementi antecedenti della lista originale.
--esCouple :: [Int] -> [(Int,Int)]
--esCouple [] = []
--esCouple (x:xs) = (f1,f2) : (esCouple xs)
--    where 
--       f1 = sum xs
--       f2 = sum (takeWhile (==x) (x:xs)) questo credo non vada bene perchè a ogni giro si droppa la testa, siccome passo solo xs

esCouple :: [Int] -> [(Int, Int)]
esCouple xs = go xs 0
  where
    go [] _ = []
    go (x:xs) prefixSum = (sum xs, prefixSum) : go xs (prefixSum + x) --prefixsum è una variabile che si mantiene la somma dei precedenti
