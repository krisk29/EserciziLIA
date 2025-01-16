zipunequals(L1,L2,L3):-length(L1,L),length(L2,L),genera(L1,L2,L3).

genera([],[],[]).
genera([H|T],[H1|T1],L):-H=\=H1,genera(T,T1,L1),append([(H,H1)],L1,L);genera(T,T1,L).


% persona(Nome, Età)
persona(giovanni, 30).
persona(mario, 25).
persona(anna, 35).
persona(luca, 40).
persona(pietro, 50).
persona(giuseppe,22).
persona(antonio,22).
persona(domenico,22).
persona(aldo,12).
persona(mattia,43).
persona(ahmed,1).

amico(aldo,ahmed).
amico(aldo,mattia).

amico(giuseppe,antonio).
amico(giuseppe,domenico).
% amico(P1, P2) - P1 è amico di P2
amico(giovanni, mario).
amico(giovanni, anna).
amico(mario, anna).
amico(mario, luca).
amico(luca, pietro).
amico(anna, pietro).

% maschio(Nome) - Nome è un maschio
maschio(giovanni).
maschio(mario).
maschio(luca).
maschio(pietro).

% femmina(Nome) - Nome è una femmina
femmina(anna).



/**Supponendo di avere una base di fatti per i seguenti predicati: persona/2, amico/2, maschio/1, femmina/1, dove persona
 *  contenga come primo termine il nome della persona e come secondo la sua età-

Si definiscano i predicati seguenti:

soloamicigrandi(X): vero se e solo X ha solamente amici più grandi di lui
amicistessaeta(X): vero se e solo tutti gli amici di X hanno la medesima età
stessaetadegliamici(X,Y): vero se e solo se X e Y hanno degli insiemi di amici AX e AY tali che la somma delle età degli amici 
in AX e AY coincidano**/

soloamicigrandi(X):-persona(X,E),\+amicoPiuPiccolo(X,E).

amicoPiuPiccolo(X,E):-amico(X,Y),persona(Y,E2),E2=<E.

amicistessaetea(X):-persona(X,_),amico(X,Y),persona(Y,E),\+amicoDiXconetaDiversaDaY(X,Y,E).

amicoDiXconetaDiversaDaY(X,Y,E):-amico(X,Z),Z\=Y,persona(Z,E1),E1\=E.

stessaetadegliamici(X,Y):-etaAmici(X,E),etaAmici(Y,E).

etaAmici(P,E):-findall(X,trovaAmiciConEta(P,X),L),sommaLista(L,E).

sommaLista([],0).
sommaLista([H|T],N):-sommaLista(T,N1),N is H+N1.
    
trovaAmiciConEta(X,E):-amico(X,Y),persona(Y,E).