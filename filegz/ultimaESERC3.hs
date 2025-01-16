-- 1)Definire una funzione removeElementsByValues che prende in input due liste di interi: values e filters e
--restituisce una nuova lista contenente solo gli elementi di values che non appaiono nella lista filters  
--nell'ordine in cui appaiono nella lista values. 
-- Esempio:

-- removeElementsByIndices [1,4,2,1] [2,1] restituisce [4]

removeElementsByValues :: [Int] -> [Int] -> [Int]
removeElementsByValues xs []=xs
removeElementsByValues [] _=[]
removeElementsByValues xs ys=[x|x<-xs,not(contenuto x ys)]

contenuto:: Int->[Int]->Bool
contenuto _ []=False
contenuto x (y:ys)=if x==y then True else contenuto x ys 

-- 2)Scrivere una funzione sumOfLists che riceve in input una lista di liste di numeri l e restituisce una lista
-- di numeri l1 tale che ogni elemento in posizione i-esima di l1 corrisponda alla somma degli elementi nella lista 
--in posisione i-esima di l
-- Esempio
--  sumoflists [[1,5,3],[4, -2]] = [9,2]

sumoflists :: Num a => [[a]] -> [a]
sumoflists xs =[sum x|x<-xs]