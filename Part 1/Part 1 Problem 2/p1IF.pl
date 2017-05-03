% Problem 2
child(joanne).
child(lou).
child(ralph).
child(winnie).

animal(grizzly_bear).
animal(moose).
animal(seal).
animal(zebra).

adventure(circus).
adventure(rock_band).
adventure(spaceship).
adventure(train).

solve :-
    animal(JoanneIF), animal(LouIF), animal(RalphIF), animal(WinnieIF),
    all_different([JoanneIF, LouIF, RalphIF, WinnieIF]),

    adventure(JoanneAdv), adventure(LouAdv),
    adventure(RalphAdv), adventure(WinnieAdv),
    all_different([JoanneAdv, LouAdv, RalphAdv, WinnieAdv]),

    Triples = [ [joanne, JoanneIF, JoanneAdv],
                [lou, LouIF, LouAdv],
                [ralph, RalphIF, RalphAdv],
                [winnie, WinnieIF, WinnieAdv] ],

    \+ member([_, seal, spaceship], Triples),
    \+ member([_, seal, train], Triples),

    \+ member([joanne, seal, _], Triples),
    \+ member([lou, seal, _], Triples),

    \+ member([joanne, grizzly_bear, _], Triples),
     member([joanne, _, circus], Triples),

    member([winnie, zebra, _], Triples),
    \+ member([_, grizzly_bear, spaceship], Triples),

    tell(joanne, JoanneIF, JoanneAdv),
    tell(lou, LouIF, LouAdv),
    tell(ralph, RalphIF, RalphAdv),
    tell(winnie, WinnieIF, WinnieAdv).

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write(X), write(' imagined '), write(Y),
    write(' going to the '), write(Z), write('.'), nl.
