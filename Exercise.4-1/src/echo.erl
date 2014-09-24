-module(echo).

-export([start/0,print/1,stop/0,loop/0]).

start() ->
    register(echo, spawn(echo, loop, [])),
    ok.

print(Term) ->
    echo ! {print, Term},
    ok.

stop() ->
    echo ! stop,
    ok.


loop() ->
    receive
	{print, Term} ->
	    io:format("~w~n", [Term]),
	    loop();
	stop -> ok;
	_ ->  loop()
    end.
     
