-- 1)Definire una funzione subsetsum che prende in input un intero x e una lista di interi s e restituisce una lista 
-- contenente tutte le sottoliste s1 di s tali che la somma degli elementi di s1 è uguale a x
-- Esempi:
-- subsetsum 10 [2, -1, 4, 5, 3, 6, 1] == [[3,6,1],[4,6],[4,5,1],[-1,5,6],[-1,4,6,1],[2,5,3],[2,4,3,1],[2,-1,3,6],[2,-1,5,3,1],[2,-1,4,5]]
-- subsetsum 10 [2, -1, 4, 3] == [ ]

subsetsum :: Int-> [Int] -> [[Int]]
subsetsum 0 []=[[]]
subsetsum _ []=[]
subsetsum x xs =[elem|elem<-trovaSottoliste xs, sum elem==x]

trovaSottoliste:: [Int]->[[Int]]
trovaSottoliste []=[[]]
trovaSottoliste (x:xs) = map(x:)(trovaSottoliste xs)++trovaSottoliste xs


-- Si considere il tipo



-- Scrivere una funzione pathtutto x a che restituisce vero se esiste un nodo foglia di a tale che il cammno dalla
-- radice verso questo nodo foglia è composto da nodi che hanno tutti valore x.
-- Esempio


data AlberoBInt = Vuota | Nodo Int AlberoBInt AlberoBInt
-- si considerino:
albero1 = Nodo 1 (Nodo 1 Vuota Vuota) (Nodo 3 Vuota Vuota) 
albero2 = Vuota 
albero3 = Nodo 1 (Nodo 5 Vuota Vuota) (Nodo 1 (Nodo 7 Vuota Vuota) Vuota)

-- pathtutto 1 albero1 = true
-- pathtutto 1 albero2 =  false
-- pathtutto 1 albero3 = false


pathTutto:: Int->AlberoBInt->Bool
pathTutto _ Vuota=False
pathTutto x (Nodo val Vuota Vuota)= val==x --cosi se è foglia e ha quel valore sono apposto
pathTutto x (Nodo val sx dx)=val==x && (pathTutto x sx || pathTutto x dx)