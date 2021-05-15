size(game,9,9).
bomb(game,4,1).
bomb(game,5,1).
bomb(game,7,2).
bomb(game,3,6).
bomb(game,8,6).
bomb(game,1,7).
bomb(game,3,7).
bomb(game,6,7).
bomb(game,3,9).
bomb(game,8,9).

size_entity(Game, row, col) :- size(Game, X, Y), row = X, col = Y.
/*question1*/
open_at(Game,X,Y,bomb) :- bomb(Game,X,Y).

open_at(Game,X,Y,N) :- findall(A, (neighbor(Game,X,Y,A,B),bomb(game,A,B)), L), length(L, N), N>0.

open_at(Game,X,Y,empty) :- findall(A, (neighbor(Game,X,Y,A,B),bomb(game,A,B)), L), length(L, N), N==0.

notsame(X,Y,A,B) :- not([X,Y] = [A,B]).

nextto(Game,X,Y,A,B) :- (A is X-1; A=X;A is X+1),(B is Y-1; B = Y; B is Y+1),proper_range(Game,A,B).

proper_range(Game,X,Y) :- size(Game,A,B), X > 0, Y > 0, X =< A, Y =< B.

neighbor(Game,X,Y,A,B) :- nextto(Game,X,Y,A,B), notsame(X,Y,A,B).

all_bombs(Game,L) :- findall([A,B], bomb(Game,A,B), L). 

/*question 2*/
show_answer(Game) :- print_matrix(Game, 1,1).

/*base cases*/
count(Game, X) :- size(Game,A,B), X is A*B.
print_matrix(Game, Row, Col) :- size(Game,X,Y), Row==X, Col==Y, open_at(Game,Row,Col,R), 
not(R == 'bomb'), not(R == 'empty'), format("~d", R).

print_matrix(Game, Row, Col) :- size(Game,X,Y),  Row==X, Col==Y,  bomb(Game,Row,Col), format("* ").

print_matrix(Game, Row, Col) :- size(Game,X,Y),  Row==X, Col==Y, format("_ "). 

/*recursive cases*/
print_matrix(Game, Crow, Ccol) :- size(Game, _, Col), bomb(Game, Crow, Ccol), format("* "), 
((Ccol == Col, nl, X is Crow+1); (X = Crow)), ((Ccol == Col, Y = 1); (Y is Ccol+1)),
print_matrix(Game, X, Y).

print_matrix(Game, Crow, Ccol) :- size(Game, _, Col), open_at(Game,Crow,Ccol,R), not(R == 'bomb'), not(R == 'empty'), format("~d ", R), 
((Ccol == Col, nl, X is Crow+1); (X = Crow)), ((Ccol == Col, Y = 1); (Y is Ccol+1)), 
print_matrix(Game, X, Y).

print_matrix(Game, Crow, Ccol) :- size(Game, Row, Col), ((Crow =< Row), (Ccol =< Col)), format("_ "),
((Ccol == Col, nl, X is Crow+1); (X = Crow)), ((Ccol == Col, Y = 1); (Y is Ccol+1)),
print_matrix(Game, X, Y).

/*question 3*/
no_same([],_).

no_same(_,[]).

no_same([X|Y],[A|B]) :- not(X==A), no_same(Y,[A|B]), no_same(B,[X|Y]).

is_survive(_,[]).

is_survive(Game,Opened) :- all_bombs(Game, Y), no_same(Opened,Y).

/*question 4*/

show_status(Game, Opened) :- print_status(Game, 1,1, Opened).

/*base cases*/
print_status(Game, Row, Col, L) :- size(Game,X,Y), Row == X, Col == Y, member([Row,Col], L), 
open_at(Game, Row,Col,R), not(R == 'bomb'), not(R == 'empty'), format("~d", R).

print_status(Game, Row, Col, L) :- size(Game,X,Y), Row == X, Col == Y, member([Row,Col], L),
bomb(Game,Row,Col), format("* ").

print_status(Game, Row, Col, L) :- size(Game,X,Y), Row == X, Col == Y, member([Row,Col], L), format("  "). 

print_status(Game, Row, Col, _) :- size(Game,X,Y), Row == X, Col == Y, format("? "). 

/*recursive cases*/
print_status(Game, Crow, Ccol, L) :- size(Game,_,Col), member([Crow,Ccol], L), bomb(Game,Crow,Ccol), format("* "),
((Ccol == Col, nl, X is Crow+1); (X = Crow)), ((Ccol == Col, Y = 1); (Y is Ccol+1)),
print_status(Game, X, Y, L).

print_status(Game, Crow, Ccol, L) :- size(Game,_,Col), member([Crow,Ccol], L), open_at(Game,Crow,Ccol,R),
not(R == 'bomb'), not(R == 'empty'), format("~d ", R),
((Ccol == Col, nl, X is Crow+1); (X = Crow)), ((Ccol == Col, Y = 1); (Y is Ccol+1)),
print_status(Game, X, Y, L).

print_status(Game, Crow, Ccol, L) :- size(Game,_,Col), member([Crow,Ccol], L), format("  "),
((Ccol == Col, nl, X is Crow+1); (X = Crow)), ((Ccol == Col, Y = 1); (Y is Ccol+1)),
print_status(Game, X, Y, L).

print_status(Game, Crow, Ccol, L) :- size(Game,Row,Col), ((Crow =< Row), (Ccol =< Col)), format("? "),
((Ccol == Col, nl, X is Crow+1); (X = Crow)), ((Ccol == Col, Y = 1); (Y is Ccol+1)),
print_status(Game, X, Y, L).

/*question 5*/
same(X,X).
every_coord(Game, L) :- size(Game, Row,Col), findall([X,Y],((between(1,Row,X), (between(1,Col,Y)), not(bomb(Game,X,Y)))), L).
is_win(Game,Opened) :- every_coord(Game, L), same(Opened, L).
