-- 1)Definire una funzione segmentList che, data una lista di interi,
--  la suddivide in sottoliste consecutive, rispettando le seguenti regole:
-- Ogni sottolista deve contenere numeri consecutivi in base alla differenza di 1 (esempio: [3, 4, 5] o [10, 11]).
-- Quando la sequenza si interrompe (esempio: passando da 5 a 8), inizia una nuova sottolista.
-- La funzione deve restituire una lista di sottoliste.
-- Input: [3, 4, 5, 8, 9, 10, 3, 4, 12, 13, 14, 20]
-- Output: [[3, 4, 5], [8, 9, 10], [3, 4], [12, 13, 14], [20]]

segmentList :: [Int] -> [[Int]]
segmentList []=[]
segmentList (x:xs)=crea [x] x xs

crea:: [Int]->Int->[Int]->[[Int]]
crea lista _ []=[lista]
crea sottoCorr corr (y:ys)=if corr+1==y then crea (sottoCorr++[y]) y ys else sottoCorr:crea [y] y ys


-- 2)Si considere il tipo

data AlberoBInt = Vuota | Nodo Int AlberoBInt AlberoBInt

-- Scrivere una funzione sommalivello x a che restituisce la somma dei valori che appaiono in a al livello x.  
--Si deve restituire 0 se non vi sono nodi al livello x in a.  La radice è al livello 0.

-- Esempio si considerino:
albero1 = Nodo 1 (Nodo 2 Vuota Vuota) (Nodo 3 Vuota Vuota) 
albero2 = Vuota 
albero3 = Nodo 4 (Nodo 5 Vuota Vuota) (Nodo 6 (Nodo 7 Vuota Vuota) Vuota)

-- sommalivello 1 albero1 = 5
-- sommalivello 2 albero2 =  0
-- sommalivello  2 albero3 = 7

sommalivello:: Int->AlberoBInt->Int
sommalivello x Vuota = 0
sommalivello 0 (Nodo val _ _)=val
sommalivello x (Nodo val sx dx)= sommalivello (x-1) sx + sommalivello (x-1) dx 

