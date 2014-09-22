-module(manip_lists).

-export([reverse/1, filter/2, concatenate/1]).

reverse([], Acc) -> Acc;
reverse([H|T],Acc) -> reverse(T, [H|Acc]).

reverse(L) -> reverse(L,[]).

filter([], _, Acc) -> reverse(Acc);
filter([H|T], X, Acc) when H > X -> filter(T,X,Acc); 
filter([H|T], X, Acc) -> filter(T,X, [H|Acc]). 

filter(L,X) -> filter(L,X,[]).

concat_help([],Acc) -> reverse(Acc);
concat_help([H|T], Acc) -> concat_help(T,[H|Acc]). 

concatenate([], Acc) -> Acc;
concatenate([H|T], Acc) -> concatenate(T, concat_help(H,Acc)). 

concatenate(L) -> concatenate(L,[]).
