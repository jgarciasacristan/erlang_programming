-module(create_lists).

-export([create/1,reverse_create/1]).


reverse_create(0) -> [];
reverse_create(N) when N > 0 -> [N | reverse_create(N-1)].

create(0,L) -> L;
create(N,L) -> create(N-1,[N|L]).

create(N) when N >= 0 -> create(N,[]).
