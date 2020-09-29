/* ---------------------------------------------*/

/* Uppgift 6: Stabil regering

   Landet Filurien har åtta partier i parlamentet.

   Senaste valet blev rafflande. Ingen vann.

   Partierna fick dessa mandat:
   p1 38 , p2 17, p3 51, p4 23, p5 27, p6 35, p7 18, p8 25

   Varje parti fick bedöma hur mycket de har gemensamt med de
   andra partierna på en skala från -10 till +10,
   Vi har alltså en matris med 8*8 signifikanta värden.
   Hitta på lämpliga värden själva!
   Sätt värdet 0 som partiets självvärdering.

   En stabil regering uppfyller två villkor:

   1. summan av antalet mandat för de valda partierna är
      minst hälften av totalantalet.
   2. summan av gemensam-index för de valda partierna
      sinsemellan är positivt.
      (De har totalt mer gemensamt än motsatsen.)

   Skriv ett Prolog-program som föreslår
   en stabil regering i Filurien! */

/* ---------------------------------------------*/
/* (Lösningen fungerar inte) */

mandat(p1, 38).
mandat(p2, 17).
mandat(p3, 51).
mandat(p4, 23).
mandat(p5, 27).
mandat(p6, 35).
mandat(p7, 18).
mandat(p8, 25).

      /* p1   p2   p3   p4   p5   p6   p7   p8 */
row(p1, [ 0,   1,   2,   3,   4,   5,   6,   7]).
row(p2, [-1,   0,  -2,  -3,  -4,  -5,  -6,  -7]).
row(p3, [ 1,   2,   0,   3,   4,   5,   6,   7]).
row(p4, [-1, -10,  -2,   0,  -4,  -5,  -6,  -7]).
row(p5, [-1,   0,  -2,  -3,   0,   5,   6,   7]).
row(p6, [-1,   5,  -2,  -3,  -4,   0,  -6,  -7]).
row(p7, [ 1,   2,   8,   3,   4,   5,   0,   7]).
row(p8, [-1, -10,  -2,   0,  -4,  -5,  -6,   0]).

gemensam(X, Y, Val) :-
         nth1(Yindex, Xlist, Val),
         row(X, Xlist),
         nth1(Yindex, [p1, p2, p3, p4, p5, p6, p7, p8], Y).

regering(Govlist, Mdt, Gdex) :-
         Gdex > 0, Mdt > 117,
         mandatregering(Govlist, Mdt),
         gemensamregering(Govlist, Gdex).

mandatregering([H|[]], Mdt) :-
         mandat(H, Mdt).
mandatregering([H|T], Mdt) :-
         mandat(H, X1),
         Mdt = X1 + Mdt2,
         mandatregering(T, Mdt2).

/* av någon anledning så fungerar inte det här predikatet som det ska*/
gemensamregering([], 0).
gemensamregering([H|T], Gdex) :-
         Gdex = Firstparty + Restofparties.
         addition_iterate([H|T], Firstparty),
         gemensamregering(T, Restofparties).

addition_iterate([_], 0).
addition_iterate([H1, H2], Gindex) :-
         gemensam(H1, H2, Gindex).
addition_iterate([H1, H2, H3|T], Gindex) :-
         gemensam(H1, H2, Val),
         Gindex = Val + Gindex2,
         addition_iterate([H1, H3|T], Gindex2).

/* Anteckningar:
Predikatet mandat/2 kopplar ihop antal mandat med rätt parti. Den totala
mängden mandat i en föreslagen regering måste vara minst 117.

Row/2-predikaten är matrisen med 8x8 signifikanta värden och ger gemensam-
index för alla partierna. Plats 1 i varje lista är vad partiet i fråga
tycker om p1, plats 2 är vad det tycker om p2 o.s.v.

Predikatet gemensam/3 kollar gemensam-index för två partier, vilket den ger
ut som variabeln "Val" om man matar in två olika partier som "X" och "Y".
Ex; gemensam(p1, p2, Val) kommer ge Val = 1.
* predikatet nth1/3 är inbyggt i prolog; nth1(N, List, Element) betyder att
  "Element" ligger på index "N" i listan "List". Här säger det att "Val" (som
  man vill ha ut) ligger på index "Yindex" i listan "Xlist".
* "row(X, Xlist)" säger att listan "Xlist" (som man kollar på) är den lista som
  hör ihop med partiet "X". Man får ut den genom att kolla på row-predikaten.
* "nth1(Yindex, [p1, p2, p3, p4, p5, p6, p7, p8], Y)" betyder att "Yindex" i
  listan med gemensam-index är den position som hör ihop med det partiet man
  söker.

Predikatet regering/3 tar fram förslag på regeringar. Man kollar om antalet
mandat är fler än 117, och om summan av gemensam-index är över 0.

Predikatet mandatregering/2 itererar rekursivt genom listan på partier,
kollar deras respektive mandat och adderar mandaten.

Predikatet addition_iterate/2 itererar rekursivt genom listan på partier och
kollar gemensam-index från ett parti till alla de andra. Eftersom det här
behöver göras för varje parti så måste man också köra det här predikatet
rekursivt i gemensamregering/2 för alla partier i listan.
*/
