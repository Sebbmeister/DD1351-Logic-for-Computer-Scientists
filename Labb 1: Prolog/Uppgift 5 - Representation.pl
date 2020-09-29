/* ---------------------------------------------*/

/* Uppgift 5: Representation

   Du skall definiera ett program som arbetar med grafer.

   Föreslå en representation av grafer så att varje nod har ett
   unikt namn (en konstant) och grannarna finns indikerade.

   Definiera ett predikat som med denna representation och utan
   att fastna i en loop tar fram en väg som en lista av namnen på
   noderna i den ordning de passeras när man utan att passera
   en nod mer än en gång går från nod A till nod B!
   Finns det flera möjliga vägar skall de presenteras
   en efter en, om man begär det. */

/* ---------------------------------------------*/

edge(1, 6).
edge(2, 1).
edge(2, 3).
edge(2, 4).
edge(3, 1).
edge(3, 4).
edge(4, 5).
edge(5, 2).
edge(5, 6).
edge(6, 4).

path(Start, Dest, Path) :- path(Start, Dest, [], Path).

path(Start, Start, _, [Start]).
path(Start, Dest, Visitednodes, [Start|Pathnodes]) :-
    \+ member(Start, Visitednodes),
    edge(Start, Node),
    path(Node, Dest, [Start|Visitednodes], Pathnodes).


/* Anteckningar:
"edge"-predikaten skapar en riktad graf. "edge(A, B)" säger att det finns
en kant som går från nod A till nod B.
"path"-predikatet hittar en väg från en nod till en annan. "path(A, B)"
kommer att ge ut möjliga vägar från nod A till nod B. Det första "path"-
predikatet gäller om vi redan är på destinationsnoden; då är vägen bara
den noden. Det andra "path"-predikatet är andra fall; man kollar så att
noden man är på (start) inte redan besökts, hittar en nod som som sitter
ihop med den och går vidare till den rekursivt.
*/
