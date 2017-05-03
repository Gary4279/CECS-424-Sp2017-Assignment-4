% Problem 3
person(barrada).
person(gort).
person(klatu).
person(nikto).

seen(balloon).
seen(clothesline).
seen(frisbee).
seen(water_tower).

earlier(tue, wed). earlier(tue, thu). earlier(tue, fri).
earlier(wed, thu). earlier(wed, fri).
earlier(thu, fri).

solve :-
    person(TuePer), person(WedPer), person(ThuPer), person(FriPer),
    all_different([TuePer, WedPer, ThuPer, FriPer]),

    seen(TueSeen), seen(WedSeen),
    seen(ThuSeen), seen(FriSeen),
    all_different([TueSeen, WedSeen, ThuSeen, FriSeen]),

    Triples = [ [tue, TuePer, TueSeen],
                [wed, WedPer, WedSeen],
                [thu, ThuPer, ThuSeen],
                [fri, FriPer, FriSeen] ],


    \+ member([_, klatu, balloon], Triples),
    \+ member([_, klatu, frisbee], Triples),
    \+ member([_, gort, frisbee], Triples),
    (member([A, _, frisbee], Triples), earlier(A, B),
    member([B, klatu, _], Triples), earlier(B, C)),
    member([C, _, balloon], Triples),

    \+ member([tue, nikto, _], Triples),
    \+ member([_, klatu, water_tower], Triples),

    (member([fri, barrada, _], Triples);
    member([fri, _, clothesline], Triples)),

    tell(tue, TuePer, TueSeen),
    tell(wed, WedPer, WedSeen),
    tell(thu, ThuPer, ThuSeen),
    tell(fri, FriPer, FriSeen).

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write(X), write(': '), write(Y),
    write(' saw a '), write(Z), write('.'), nl.
