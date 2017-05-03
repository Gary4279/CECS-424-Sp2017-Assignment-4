Adventure Game by Gary


Game Description:
You recently acquired a run down farm and you need to raise 10,000 dollars to
fix it up. Your neighbor offers you $10,000 for a golden apple. The goal is to
take down the tree monster and recover the golden apple on its branches to be
able to sell to your neighbor. The game ends when you go see him with the
golden apple in hand.

1. Limited Resource:
The limited resource in the game is in the form of bullets.  The gun in the game
requires 3 bullets to be able to shoot.  There are 3 bullets in the world and
player will only be able to load the gun when they have all 3.

2. Locked Door:
The locked door comes in the form of an old man blocking your way to the
shed until you prove ownership of the farm by presenting a deed which is
located in the bedroom.

3. Hidden Object:
The hidden object is a golden apple that is hidden in a tree monster that must
be defeated before it can be picked up.

4. Incomplete Object:
The shotgun will be the incomplete object as it needs bullets to be fired.


List of Queries to beat the game:
?- consult('p2.pl').
?- start.
?- take(bullet1).
?- s.
?- take(bullet2).
?- n.
?- n.
?- take(shotgun).
?- e.
?- take(deed).
?- w.
?- n.
?- take(bullet3).
?- n.
?- loadGun.
?- shoot.
?- take(goldenapple).
?- s.
?- s.
?- s.
?- w.
?- halt.
