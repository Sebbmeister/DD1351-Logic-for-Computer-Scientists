/* ---------------------------------------------*/

/* Uppgift 4: Rekursion

   Definiera predikatet partstring/3 som givet en lista som första
   argument genererar en lista F med längden L som man finner
   konsekutivt i den första listan!
   Alla möjliga svar skall kunna presenteras med hjälp av
   backtracking om man begär fram dem.

   Till exempel:

   ?- partstring( [ 1, 2 , 3 , 4 ], L, F).

   genererar t.ex.F=[4] och L=1
   eller F=[1,2] och L=2
   eller F=[2,3] och L=2
   osv. */

/* ---------------------------------------------*/

partstring(X, L, F) :- append([_, F, _], X), length(F, L), F\=[].

/* Anteckningar:
"append" med två termer, ex. append (A, B), betyder att A är en
lista vars alla argument är listor och att B är resultatet av att
lägga ihop dessa listor.

I partstring är därför listan X resultatet av att lägga ihop listorna
_, F och _. ("_" betyder att listan är godtycklig). _ kan också vara
[]. F är dvs. en lista "någonstans inuti" X.

Predikatet "length" tar ut längden av det första argumentet och sätter
den till värdet för det andra argumentet - L blir alltså längden av F.

"F \=[]" är med för att förhindra att F blir en tom lista (annars kan
F = [] uppfylla ([_, F, _], L)). */
