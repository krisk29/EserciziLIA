module Esercitazione3 where

--ESERCIZIO 1
--run length encoding ovvero dato una stringa dire le ricorrenze dei caratteri
encode :: Eq a => [a] -> [(a,Int)] 
encode [] = []
encode (x:xs) = [(x, f)] ++ encode (drop f (x:xs)) where f = length (takeWhile (==x) (x:xs)) --versione più compatta con il takeWhile (genera una lista di elementi contenenti i valori fino a che rispettano la condizione, poi si ferma) 
--encode (x:xs) = [(x, f)] ++ encode (drop f (x:xs)) where f = dropWhile (==x) (x:xs) --esiste anche il costrutto dropWhile che fa quello che ho fatto io sopra ma in una funzione
--encode (x:xs) = [(x, f)] ++ encode (drop f (x:xs)) where f = (contaChar (x:xs))

contaChar :: Eq a => [a] -> Int
contaChar (x:xs) = length (filter (==x) (x:xs)) --filter seleziona gli elementi della lista uguali alla condizione, non completamente adatto alla richiesta dell'esercizio



--ESERCIZIO 2
--verifica di un albero bilanciato
data Tree a = Empty | Node a (Tree a) (Tree a)
isBalanced :: Tree a -> Bool
isBalanced Empty = True
isBalanced (Node _ left right) = abs (height left - height right) <= 1 && (isBalanced left) && (isBalanced right)

height :: Tree a -> Int
height Empty = 0
height (Node _ left right) = 1 + max (height left) (height right)



--ESERCIZIO 3
--implementare uno zipper per liste ovvero consente di muoversi a destra e sinistra in una lista mantenendo il focus in un elemento e premette di inserire un elemento prima del corrente o eliminare l'elemento corrente
data Zipper a = Zipper [a] a [a]

instance Show a => Show (Zipper a) where  --bisogna mettere che è una sottoclasse di show per stampare a video
    show (Zipper ls focus rs) = "Zipper " ++ show ls ++ " " ++ show focus ++ " " ++ show rs


moveLeft :: Zipper a -> Maybe (Zipper a)
moveLeft (Zipper [] _ _) = Nothing
moveLeft (Zipper (l:ls) focus rs) = Just (Zipper ls l (focus:rs))

moveRight :: Zipper a -> Maybe (Zipper a)
moveRight (Zipper _ _ []) = Nothing
moveRight (Zipper ls focus (r:rs)) = Just (Zipper (focus:ls) r rs)

insert :: a -> Zipper a -> Zipper a
insert newElement (Zipper ls focus rs) = Zipper (newElement:ls) focus rs

delete :: Zipper a -> Maybe (Zipper a)
delete (Zipper ls _ (r:rs)) = Just (Zipper ls r rs)
delete (Zipper (l:ls) _ []) = Just (Zipper ls l [])
delete (Zipper [] _ []) = Nothing
