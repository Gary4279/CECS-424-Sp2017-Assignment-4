:- dynamic i_am_at/1, at/2, holding/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

i_am_at(field).

path(field, w, buyer).
path(field, n, farmhouse).
path(field, s, car).

path(buyer, e, field).

path(car, n, field).

path(farmhouse, s, field).
path(farmhouse, e, bedroom).
path(farmhouse, n, shed) :- holding(deed).
path(farmhouse, n, shed) :-
          write('There is a mysterious old man blocking the door to the shed.'), nl,
          write('He refuses to move until you prove you are the owner of the'), nl,
          write('farm.'), nl,
          !, fail.

path(bedroom, w, farmhouse).

path(shed, s, farmhouse).
path(shed, n, woods).

path(woods, s, shed).

at(goldenapple, woods).
at(bullet1, field).
at(bullet2, car).
at(bullet3, shed).
at(shotgun, farmhouse).
at(deed, bedroom).


/* This fact is saying that the tree_monster is alive */

alive(tree_monster).


loadGun :-
        holding(bullet1),
        holding(bullet2),
        holding(bullet3),
        retract(holding(bullet1)),
        retract(holding(bullet2)),
        retract(holding(bullet3)),
        assert(holding(bullets)),
        write('Loaded your gun with bullets, you have 1 shot so be carful!'),
        !, nl.

loadGun :-
        write('You dont have enough bullets, you need 3 to load the gun!'),
        !, nl.
/* These rules describe how to pick up an object. */

take(X) :-
        holding(X),
        write('You''re already holding it!'),
        !, nl.

take(goldenapple) :-
        i_am_at(woods),
        at(goldenapple, woods),
        alive(tree_monster),
        write('What are you crazy!? You need to kill the tree monster first!'), !, nl.

take(goldenapple) :-
        i_am_at(woods),
        at(goldenapple, woods),
        \+ alive(tree_monster),
        retract(at(goldenapple, woods)),
        assert(holding(goldenapple)),
        write('OK.'),
        !, nl.

take(goldenapple) :-
        \+ i_am_at(woods),
        write('I don''t see it here.'),
        !, nl.

take(X) :-
        \+ (X == goldenapple),
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        write('OK.'),
        !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */

drop(X) :-
        holding(X),
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.
/* These rules describe how to check the player's inventory. */

i :-
        holding(X), write(X).

/* These rules define the direction letters as calls to go/1. */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).


/* This rule tells how to move in a given direction. */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).

/* These rules tell how to handle killing the tree_monster. */
shoot :-
        i_am_at(woods),
        holding(shotgun),
        holding(bullets),
        retract(alive(tree_monster)),
        retract(holding(bullets)),
        write('You pulled the trigger and completely destroyed the tree!'), nl,
        write('Along with all the shattered wood pieces a golden apple '), nl,
        write('came out of the tree, it is just what you needed.'), nl, !.

shoot :-
        i_am_at(woods),
        holding(shotgun),
        \+ holding(bullets),
        write('You pulled the trigger and nothing happend. The tree '), nl,
        write('monster then impaled you with its branches and you died.'), nl,
        write('Maybe you should have tried finding bullets for the shoutgun.'), nl,
        !, die.

shoot :-
        i_am_at(woods),
        holding(bullets),
        \+ holding(shotgun),
        write('You threw bullets at the tree and nothing happend.'), nl,
        write('Who throws bullets? You need to die.'), nl,
        write('Game over (natual selection at its finest.'), nl,
        !, die.

shoot :-
        i_am_at(woods),
        \+ holding(shotgun),
        \+ holding(bullets),
        write('What did you try to shoot?'), nl,
        write('Your imaginary gun?'), nl,
        write('The tree monster took offense to this.'), nl,
        write('The tree monster impaled you with its branches and you died.'), nl,
        write('Maybe you should have tried using a weapon.'), nl,
        !, die.

/* This rule tells how to die. */

die :-
        finish.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.


/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('i.                 -- to display items in possesion.'), nl,
        write('take(Object).      -- to pick up an object.'), nl,
        write('drop(Object).      -- to put down an object.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('loadGun.           -- load your gun to be able to shoot.'), nl,
        write('shoot.             -- to shoot an enemy.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.

/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        write('You just aquired a run down old farm.'), nl,
        write('It clearly needs some work done before it can be operational.'), nl,
        write('You need to find a way to make money.'), nl,
        write('Luckily your nieghbor will buy a golden apple for $10,000.'), nl,
        write('Go find that apple!!!!.'), nl,
        look.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(field) :-
        write('You are at a field.'), nl,
        write('To the west, there is a buyer.'), nl,
        write('Your car is parked south from here.'), nl,
        write('The farmhouse is up north.'), nl.

describe(buyer) :-
        holding(goldenapple),
        write('Buyer gave you $10,000 for your golden apple.'), nl,
        write('You can now fix up your farm and have a good life.'), nl,
        write('You win!'), nl,
        finish, !.

describe(buyer) :-
        write('You need a golden apple to sell the buyer'), nl,
        write('to save your farm.'), nl,
        write('Buyer will pay you $10,000 for a golden apple.'), nl,
        write('The field is to the east.'), nl.



describe(car) :-
        write('You are in your car.'), nl,
        write('The field is to the north.'), nl.

describe(farmhouse) :-
        write('You are in the farmhouse.'), nl,
        write('The farm shed is to the north.'), nl,
        write('Your bedroom is to the east.'), nl,
        write('The field is south.'), nl.

describe(bedroom) :-
        write('You are in your bedroom.'), nl,
        write('The farmhouse is to the west.'), nl.

describe(shed) :-
        write('You are in the shed.'), nl,
        write('The woods are to the north.'), nl,
        write('The farmhouse is the south.'), nl.

describe(woods) :-
        alive(tree_monster),
        write('You are in the woods.'), nl,
        write('There is a dangerous tree monster here.'), nl,
        write('Be careful!'), nl,
        write('The farm shed is south from here.'), nl.

describe(woods) :-
        write('You are in the woods.'), nl,
        write('Shards of wood from the tree monster are everywhere!'), nl,
        write('The farm shed is south from here.'), nl.
