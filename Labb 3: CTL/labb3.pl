verify(Input) :-
  see(Input), read(T), read(L), read(S), read(F), seen,
  check(T, L, S, [], F).

fetch_neighbours(T, L, S, U, F, Flag) :-
  member([S, NeighbourList], T),
  (
    Flag == 1 ->
    (traverse_some(T, L, U, F, NeighbourList), !)
    ;
    traverse(T, L, U, F, NeighbourList)
  ).

traverse(_, _, _, _, []).
traverse(T, L, U, F, [Neighbour|Tail]) :-
  check(T, L, Neighbour, U, F), traverse(T, L, U, F, Tail).

traverse_some(T, L, U, F, [Neighbour|Tail]) :-
  check(T, L, Neighbour, U, F) ; traverse_some(T, L, U, F, Tail), !.

isNotMember(S, U):-
  \+ member(S, U).

%p
check(T, L, S, [], X) :-
    member([S, Tail], L),
    member(X, Tail).

%neg
check(T, L, S, [], neg(X)) :-
    member([S, Tail], L),
    isNotMember(X, Tail).

%And
check(T, L, S, [], and(X,Y)) :-
    check(T, L, S, [], X),
    check(T, L, S, [], Y).

%or
check(T, L, S, [], or(X,Y)) :-
    check(T, L, S, [], X).

check(T, L, S, [], or(X,Y)) :-
    check(T, L, S, [], Y).

% A-REGLER ANVÄNDER FLAGGA 0 %
% E-REGLER ANVÄNDER FLAGGA 1 %

%AX
check(T, L, S, U, ax(X)) :-
  fetch_neighbours(T, L, S, [], X, 0).

%EX
check(T, L, S, U, ex(X)) :-
  fetch_neighbours(T, L, S, [], X, 1).

%AG
check(_, _, S, U, ag(_)) :-
  member(S, U).

check(T, L, S, U, ag(X)) :-
  isNotMember(S, U),
  check(T, L, S, [], X),
  fetch_neighbours(T, L, S, [S|U], ag(X), 0).

% EG
check(_, _, S, U, eg(_)) :-
  member(S, U).

check(T, L, S, U, eg(X)) :-
  isNotMember(S, U),
  check(T, L, S, [], X),
  fetch_neighbours(T, L, S, [S|U], eg(X), 1).

%EF
check(T, L, S, U, ef(X)) :-
  isNotMember(S, U),
  check(T, L, S, [], X).

check(T, L, S, U, ef(X)) :-
  isNotMember(S, U),
  fetch_neighbours(T, L, S, [S|U], ef(X), 1).

%AF
check(T, L, S, U, af(X)) :-
  isNotMember(S, U),
  check(T, L, S, [], X).

check(T, L, S, U, af(X)) :-
  isNotMember(S, U),
  fetch_neighbours(T, L, S, [S|U], af(X), 0).
