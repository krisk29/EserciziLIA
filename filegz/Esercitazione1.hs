data Person=Person String deriving (Show)
data Figlio =Figlio String String deriving (Show)

nongenitore::[Person]->[Figlio]->[Person]
nongenitore [] _= []
nongenitore p []= p
nongenitore (p:ps) fs= if nonpresente p fs then (p:(nongenitore ps fs)) else nongenitore ps fs

nonpresente:: Person->[Figlio]->Bool
nonpresente _ []=True
nonpresente (Person x) ((Figlio y z):fs) 
                                        |x==y=False
                                        |otherwise=nonpresente (Person x) fs

genitoriprolifici::[Person]->[Figlio]->[Person]
genitoriprolifici [] _=[]
genitoriprolifici ps []=ps
genitoriprolifici ps fs=[p|p<-ps, figli p fs==massimo ps fs]


massimo::[Person]->[Figlio]->Int
massimo ps []=0
massimo ps fs=maximum[figli p fs|p<-ps]

figli:: Person->[Figlio]->Int
figli _ []=0
figli (Person x) ((Figlio z y):fs) 
                                    |x==z=1+figli (Person x) fs
                                    |otherwise= figli (Person x) fs

data Tree a = Leaf a | Node (Tree a) (Tree a)

leaves:: Tree a ->[a]
leaves (Leaf x)=[x]
leaves (Node sx dx)=leaves sx++leaves dx

size::Tree a->Int
size (Leaf x)=1
size (Node sx dx)=size sx +size dx