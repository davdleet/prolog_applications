member(X, [X|_]).
member(X,[_|Y]) :- member(X,Y).

nexthouse(L,R,[L,R|_]).
nexthouse(L,R,[_|Rest]):-nexthouse(L,R,Rest).

neighbor(X,Y,Houses):- nexthouse(X,Y,Houses);
nexthouse(Y,X,Houses).

member([eng, red, _, _,_], Houses),
member([swe,_,dog,_,_], Houses),
member([den,_,_,tea,_], Houses),
nexthouse([_,green,_,_,_],[_,white,_,_,_],Houses),
member([_,green,_coffee,_],Houses),
member([_,_,bird,_,pall],Houses),
member([_,yellow,_,_,dunhill],Houses),
Houses = [[nor,_,_,_,_],_,[_,_,_,milk,_],_,_],
neighbor([_,_,_,_blend],[_,_,cat,_,_],Houses),
neighbor([_,_,horse,_,_],[_,_,_,_,dunhill],Houses),
member([_,_,_,beer,bluemaster],Houses),
member([ger,_,_,_,prince],Houses),
neighbor([])