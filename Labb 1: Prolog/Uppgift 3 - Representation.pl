/* ---------------------------------------------*/

/* Uppgift 3: Representation

   En lista är en representation av sekvenser där
   den tomma sekvensen representeras av symbolen []
   och en sekvens bestående av tre heltal 1 2 3
   representeras av [1,2,3].

   Den exakta definitionen av en lista är:

   list([]).
   list([H|T]) :- list(T).


   Vi vill definiera ett  predikat som givet en lista som
   representerar en sekvens skapar en annan lista som innehåller
   alla element som förekommer i inlistan i samma ordning, men
   om ett element har fōrekommit tidigare i listan skall det
   inte vara med i den resulterande listan.

   Till exempel:

   ?- remove_duplicates([1,2,3,2,4,1,3,4], E).

   skall generera E=[1,2,3,4]

   Definiera alltså predikatet remove_duplicates/2! */

/* ---------------------------------------------*/

reverselist([],[]).
reverselist([H|T],Revlist):- reverselist(T,Revtail), append(Revtail,[H],Revlist).

remove_duplicates([], []).
remove_duplicates(L, E) :- reverselist(L, R), remove_duplicates2(R, R2), reverselist(R2, E).

remove_duplicates2([], []).
remove_duplicates2([H|T], NewT) :- member(H, T), remove_duplicates2(T, NewT).
remove_duplicates2([H|T], [H|NewT]) :- \+ (member(H, T)), remove_duplicates2(T, NewT).

/* Anteckningar:
remove_duplicates2/2:
  remove_duplicates2(L, NyL) -> L och NyL är samma listor, med enda skillnaden
  att duplicerade element tagits bort.
  De tas bort genom att det finns två olika varianter på det rekursiva
  remove_duplicates2-predikatet. Den första varianten gäller om första elementet
  också dyker upp senare i listan (kollas med member/2), i vilket fall man bara går
  vidare genom listan utan att göra något. Den andra varianten är om elementet inte
  dyker upp igen i listan, i vilket fall det sparas (genom att sätta [H|NewT] i
  början som listan utan duplicerade element), vartefter man går vidare genom listan.

remove_duplicates/2:
  Kör man bara remove_duplicates2/2 så kommer listan man får ut att vara samma
  som den man skickat in fast utan upprepade element. Dock så kommer inte ordningen
  att bevaras - eftersom element som förekommer senare i listan skippas så kommer
  upprepade element bara tas med sista gången dem är med istället för första. Dvs;

  remove_duplicates2([1,2,3,1,2,4],E) resulterar i [3,1,2,4] istället för [1,2,3,4].

  Därför vänder remove_duplicates/2 om ordningen i listan, kör remove_duplicates2
  och vänder sedan tillbaka ordningen.

reverselist/2:
  Predikat för att vända om ordningen i en lista. "Revlist", dvs. den omvända
  listan, är "Revtail" + H (det första elementet i listan). Eftersom T skickas in
  i reverselist rekursivt i själva predikatet kommer listan då att vändas om.
*/
