-module(my_db_tests).
-include_lib("eunit/include/eunit.hrl").

start() ->
    my_db:start(),
    my_db:write(francesco,london),
    my_db:write(lelle, stockholm),
    my_db:write(joern, stockholm).

stop(_Pid) ->
   my_db:stop(),
   ?debugMsg("after stop").

 read_test_() -> 
  {setup,
   fun start/0,
   fun stop/1,
   [?_assertEqual({ok,london}, my_db:read(francesco)),
        ?_assertEqual({ok,stockholm},my_db:read(joern)),
	 ?_assertEqual({error,instance}, my_db:read(jose))]}.


match_test_() -> {setup,
        fun start/0,
        fun stop/1,
         [?_assertEqual([lelle, joern], my_db:match(stockholm)),
        ?_assertEqual([francesco],my_db:match(london)),
	 ?_assertEqual([], my_db:match(dublin))]}.


delete_test_() -> 
       {setup,
        fun start/0,
        fun stop/1,
        [?_assertEqual({ok, stockholm}, my_db:read(lelle)),
	 ?_assertEqual(ok, my_db:delete(lelle)),
         ?_assertEqual({error,instance}, my_db:read(lelle))]}.

