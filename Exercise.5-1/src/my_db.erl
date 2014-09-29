-module(my_db).
-export([start/0, stop/0, write/2, delete/1, read/1, match/1, loop/1]).

start() ->
    register(my_db, spawn(my_db, loop, [new()])),
    ok.

stop() ->
    my_db ! stop,
    ok.

write(Key, Element) ->
    my_db ! {write, Key,Element},
    ok.

delete(Key) ->
    my_db ! {delete, Key},
    ok.

read(Key) ->
    my_db ! {read, Key, self()},
    receive
	Msg -> Msg
    end.

match(Element) ->
    my_db ! {match, Element, self()},
    receive
	Msg -> Msg
    end.

loop(Db) ->
    receive
	{write, Key, Element} ->
	    NewDb = write(Key, Element, Db),
	    loop(NewDb);
	{delete, Key} ->
	    NewDb = delete(Key, Db),
	    loop(NewDb);
        {read, Key, Pid} ->
	    Pid ! read(Key, Db),
            loop(Db);
        {match, Element, Pid} ->
	    Pid ! match(Element, Db),
            loop(Db);
        stop -> destroy(Db)
    end.
     


%% DB Methods

new() -> [].

destroy(_) -> ok.

write(Key, Element, Db) -> [{Key, Element} | Db].

delete(_,[]) -> [];
delete(Key,[{Key, _}| T]) -> T;
delete(Key, [V |T]) -> [V|delete(Key,T)].

read(_,[]) -> {error,instance};
read(Key,[{Key,Element}|_]) -> {ok, Element};
read(Key, [_|T]) -> read(Key,T).  

match(_,[],Acc) -> Acc;
match(Element,[{Key,Element}|T],Acc) -> match(Element, T, [Key|Acc]); 
match(Element,[_|T],Acc) -> match(Element,T,Acc).

match(Element, Db) -> match(Element, Db, []). 
